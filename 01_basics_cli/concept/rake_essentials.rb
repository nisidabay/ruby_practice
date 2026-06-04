#!/usr/bin/env ruby
# frozen_string_literal: true

# rake_essentials.rb — when to reach for Rake over a plain Ruby script
#
# Rake is a task runner. Use it when:
#   - Work has dependencies (B before A)
#   - You want to skip already-done work (file timestamps)
#   - A project needs a self-documenting entry point (rake -T)
#
# Use a plain Ruby script when:
#   - It's a linear sequence with no skip/rebuild logic
#   - The task is small enough that `ruby script.rb` suffices
#
# ── The Core Concepts ────────────────────────────────────────────────────────

# 1. TASK DEPENDENCIES: A directed acyclic graph of work
#    Rake resolves the order. You declare what depends on what.
#
#    task :coffee do
#      puts '☕'
#    end
#    task breakfast: :coffee do  # coffee runs first
#      puts '🥞'
#    end

# 2. FILE TASKS: Timestamp-aware rebuilds
#    If the target file is newer than its sources, the block is skipped.
#
#    file 'output.pdf' => 'input.md' do
#      sh 'pandoc input.md -o output.pdf'
#    end
#
#    This is the Make-like pattern — rebuild only when needed.

# 3. RULES: One pattern, infinite files
#    A rule matches %.ext and generates any matching file from its source.
#
#    rule '.o' => '.c' do |t|
#      sh "gcc -c #{t.source} -o #{t.name}"
#    end

# 4. NAMESPACES: Organize with ::
#    namespace :db do
#      task :create do ... end
#      task :migrate => :create do ... end
#    end
#    # Run with: rake db:migrate

# 5. DEFAULT: `rake` with no arguments
#    task default: :list  # show all tasks when user just types `rake`

# 6. INVOKE FROM RUBY: Bridge between scripts and tasks
#    Rake::Task[:download].invoke  # call any task from your own scripts

# ── The Decision Matrix ──────────────────────────────────────────────────────
#
# | Situation                           | Tool        |
# |-------------------------------------|-------------|
# | One-off script, 20 lines            | ruby script |
# | Build pipeline with dependencies    | Rake        |
# | Need `rake -T` discoverability      | Rake        |
# | Timestamp-aware incremental builds  | Rake        |
# | Data processing, no file outputs    | ruby script |
# | CI/CD orchestration                 | Rake        |

puts 'rake_essentials.rb — load this file for the explanation above.'
puts 'See 01_basics_cli/project/Rakefile for a progressive, runnable example.'
