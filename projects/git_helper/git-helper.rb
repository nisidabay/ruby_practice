#!/usr/bin/env ruby
# frozen_string_literal: true

require 'thor'
require 'pastel'
require 'yaml'
require 'fileutils'

class GitHelper < Thor
  desc 'check', 'Validate commit messages against project conventions'
  long_desc <<~LONGDESC
    Validates commit messages to ensure they follow Conventional Commits format.

    The check looks for commits that start with a valid type followed by ':' or '(scope):'.
    Valid types are defined in .githelper.yml or use defaults: feat, fix, docs, style,
    refactor, perf, test, build, ci, chore, revert, integration.

    EXAMPLES:
      git-helper.rb check                    # Check unpushed commits (default)
      git-helper.rb check --range "HEAD~10..HEAD"  # Check last 10 commits
      git-helper.rb check --all              # Check ALL commits in repository

    EXIT CODES:
      0 - All commits pass validation
      1 - One or more commits fail validation
  LONGDESC
  option :range, type: :string, default: nil, desc: 'Commit range (e.g., HEAD~10..HEAD or @{u}..HEAD)'
  option :all, type: :boolean, default: false, desc: 'Check all commits in the repository'

  def check
    pastel = Pastel.new
    config = load_config
    allowed_types = config[:types] || default_types

    if options[:all]
      range = '--all'
      puts "#{pastel.blue('🔍')} Checking all commits in the repository..."
    else
      range = options[:range] || detect_unpushed_range
      puts "#{pastel.blue('🔍')} Checking commits in range: #{range}"
    end

    commit_messages = `git log --pretty=format:%s #{range}`.split("\n").reject(&:empty?)

    if commit_messages.empty?
      puts "#{pastel.yellow('⚠️')} No commits to check in that range."
      return
    end

    bad_commits = []
    commit_messages.each do |msg|
      bad_commits << msg unless valid_conventional?(msg, allowed_types)
    end

    if bad_commits.empty?
      puts "#{pastel.green('✅')} All commits follow the project conventions!"
    else
      total = commit_messages.length
      bad_count = bad_commits.length
      puts "#{pastel.red('❌')} #{bad_count}/#{total} commits do not follow Conventional Commits format."
      puts "\n#{pastel.yellow('📋')} Format: #{pastel.cyan('type: description')} or #{pastel.cyan('type(scope): description')}"
      puts "#{pastel.yellow('📌')} Valid types: #{pastel.cyan(allowed_types.join(', '))}"
      puts "\n#{pastel.red('⚠️')} Bad commits:"
      bad_commits.each { |m| puts "   #{pastel.red('•')} #{m}" }
      puts "\n#{pastel.yellow('💡')} Fix with: git rebase -i HEAD~#{bad_count}"
      exit 1
    end
  end

  desc 'sanity', 'Sanity check: validate ALL commits in the repository'
  long_desc <<~LONGDESC
    Performs a full repository scan to validate ALL commits against Conventional Commits format.

    This command is useful for:
    - Auditing an entire repository before enforcing commit standards
    - Identifying legacy commits that need cleanup
    - Getting statistics on commit message quality

    Shows:
    - Total commit count
    - Compliant vs non-compliant breakdown
    - Pattern analysis of bad commits (--summary)

    EXIT CODES:
      0 - All commits pass validation
      1 - One or more commits fail validation

    WARNING: Fixing old commits rewrites history. Only do this if you haven't
    pushed to a shared repository.
  LONGDESC
  option :summary, type: :boolean, default: false, desc: 'Show pattern summary instead of individual commits'

  def sanity
    pastel = Pastel.new
    config = load_config
    allowed_types = config[:types] || default_types

    puts "#{pastel.blue('🔍')} Sanity check: Scanning all commits in the repository..."

    commit_messages = `git log --pretty=format:%s --all`.split("\n").reject(&:empty?)

    if commit_messages.empty?
      puts "#{pastel.yellow('⚠️')} No commits found in the repository."
      return
    end

    bad_commits = []
    commit_messages.each do |msg|
      bad_commits << msg unless valid_conventional?(msg, allowed_types)
    end

    total = commit_messages.length
    good_count = total - bad_commits.length
    compliance_pct = (good_count.to_f / total * 100).round(2)

    puts "\n#{pastel.cyan('📊')} Repository Statistics:"
    puts "   Total commits: #{total}"
    puts "   Compliant: #{pastel.green(good_count)} (#{compliance_pct}%)"
    puts "   Non-compliant: #{pastel.red(bad_commits.length)} (#{(100 - compliance_pct).round(2)}%)"

    if bad_commits.empty?
      puts "\n#{pastel.green('✅')} All commits follow Conventional Commits format!"
      puts "#{pastel.green('🎉')} Your repository is clean!"
    else
      puts "\n#{pastel.red('❌')} #{bad_commits.length} commits need fixing:"
      puts "\n#{pastel.yellow('📋')} Format: #{pastel.cyan('type: description')} or #{pastel.cyan('type(scope): description')}"
      puts "#{pastel.yellow('📌')} Valid types: #{pastel.cyan(allowed_types.join(', '))}"

      if options[:summary]
        # Show pattern summary
        puts "\n#{pastel.yellow('📊')} Pattern analysis:"
        patterns = analyze_patterns(bad_commits)
        patterns.each do |p|
          puts "   #{pastel.cyan(p[:pattern])}"
          puts "      → #{pastel.green("Consider: #{p[:suggestion]}")}" if p[:suggestion]
        end
      else
        puts "\n#{pastel.red('⚠️')} Non-compliant commits (first 20):"
        bad_commits.take(20).each { |m| puts "   #{pastel.red('•')} #{m}" }
        puts "   #{pastel.yellow('...')} and #{bad_commits.length - 20} more" if bad_commits.length > 20
      end

      puts "\n#{pastel.yellow('💡')} To fix history:"
      puts '   Use git rebase -i for selective rewrites'
      puts '   Or git filter-branch for bulk rewrites (use with caution!)'
      puts "\n#{pastel.yellow('⚠️')} WARNING: Rewriting history changes commit hashes."
      puts "   Only do this if you haven't pushed to a shared repository."

      exit 1
    end
  end

  desc 'install-hook', 'Install git-helper as a pre-push hook'
  long_desc <<~LONGDESC
    Installs git-helper.rb as a pre-push hook in the current git repository.

    The hook will automatically validate commit messages before pushing.
    If validation fails, the push is blocked until commits are fixed.

    Hook location: .git/hooks/pre-push
  LONGDESC

  def install_hook
    pastel = Pastel.new

    unless system('git rev-parse --git-dir > /dev/null 2>&1')
      puts "#{pastel.red('❌')} Not in a git repository."
      exit 1
    end

    hook_path = '.git/hooks/pre-push'
    script_path = File.expand_path(__FILE__)

    hook_content = <<~HOOK
      #!/bin/bash
      # git-helper pre-push hook
      # Validates commit messages before pushing

      remote="$1"
      url="$2"

      # Get the range of commits being pushed
      if [ -z "$(git rev-parse @{u} 2>/dev/null)" ]; then
        range="--all"
      else
        range="@{u}..HEAD"
      fi

      # Run validation
      ruby "#{script_path}" check --range "$range" 2>/dev/null

      if [ $? -ne 0 ]; then
        echo ""
        echo "❌ Push blocked: Commit messages don't follow Conventional Commits format."
        echo "   Fix your commits with: git rebase -i"
        echo "   Or run: git-helper.rb sanity"
        exit 1
      fi

      exit 0
    HOOK

    if File.exist?(hook_path)
      puts "#{pastel.yellow('⚠️')} Hook already exists at #{hook_path}"
      print 'Overwrite? [y/N]: '
      response = $stdin.gets.chomp.downcase
      unless response == 'y'
        puts 'Aborted.'
        return
      end
    end

    # Ensure hooks directory exists
    hooks_dir = File.dirname(hook_path)
    FileUtils.mkdir_p(hooks_dir) unless File.directory?(hooks_dir)

    File.write(hook_path, hook_content)
    FileUtils.chmod(0o755, hook_path)

    puts "#{pastel.green('✅')} Pre-push hook installed at #{hook_path}"
    puts "\n#{pastel.cyan('ℹ️')} The hook will:"
    puts '   • Validate commits before each push'
    puts "   • Block push if commits don't follow Conventional Commits"
    puts '   • Suggest fixes when validation fails'
  end

  desc 'uninstall-hook', 'Remove the pre-push hook'
  def uninstall_hook
    pastel = Pastel.new
    hook_path = '.git/hooks/pre-push'

    unless File.exist?(hook_path)
      puts "#{pastel.yellow('⚠️')} No hook found at #{hook_path}"
      return
    end

    File.delete(hook_path)
    puts "#{pastel.green('✅')} Pre-push hook removed."
  end

  private

  def default_types
    %w[feat fix docs style refactor perf test build ci chore revert integration]
  end

  def valid_conventional?(msg, types)
    types.any? { |type| msg.start_with?("#{type}(") || msg.start_with?("#{type}:") }
  end

  def analyze_patterns(commits)
    patterns = {}

    commits.each do |msg|
      match = msg.match(/^(\w+)\s+/i)
      next unless match

      word = match[1].downcase
      patterns[word] ||= 0
      patterns[word] += 1
    end

    type_map = {
      'add' => 'feat:',
      'create' => 'feat:',
      'new' => 'feat:',
      'implement' => 'feat:',
      'remove' => 'chore:',
      'delete' => 'chore:',
      'modify' => 'chore:',
      'update' => 'chore:',
      'change' => 'chore:',
      'fix' => 'fix:',
      'bugfix' => 'fix:',
      'refactor' => 'refactor:',
      'docs' => 'docs:',
      'document' => 'docs:',
      'clean' => 'chore:',
      'cleaning' => 'chore:',
      'revert' => 'revert:',
      'test' => 'test:',
      'style' => 'style:',
      'merge' => 'merge:'
    }

    patterns.sort_by { |_, count| -count }.first(10).map do |word, count|
      {
        pattern: "\"#{word} ...\" (#{count} commits)",
        suggestion: type_map[word] ? "#{type_map[word]} ..." : nil
      }
    end
  end

  def load_config
    config_file = find_config_file
    return {} unless config_file

    YAML.safe_load_file(config_file) || {}
  end

  def find_config_file
    dir = Dir.pwd

    loop do
      config_path = File.join(dir, '.githelper.yml')
      return config_path if File.exist?(config_path)

      parent = File.dirname(dir)
      break if parent == dir

      dir = parent
    end

    nil
  end

  def detect_unpushed_range
    `git rev-parse --verify @{u} 2>/dev/null`
    if $?.success?
      '@{u}..HEAD'
    else
      'HEAD~20..HEAD'
    end
  end
end

GitHelper.start(ARGV)
