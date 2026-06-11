# Rake for Real Projects — Practice Suite

Rake is Ruby's task runner — like Make, but in Ruby. This group shows you
how to use it in real projects: testing, building, linting, packaging, and CI.

Every file is **executable** — it creates a temporary Rakefile and runs it
with `rake`, showing real output. No templates, no commented-out code.

> **Prerequisites:** Groups 01 (basics), 11 (testing — Minitest), 18 (gems).
> Rake comes with Ruby. No install needed.

## Quick Start

```bash
# Core Rake features
ruby 01_task_arguments.rb               # rake deploy[production,main]
ruby 02_test_task.rb                    # rake test — one command for Minitest
ruby 03_filelist.rb                     # Select files with exclude patterns

# Project maintenance
ruby 04_clean_clobber.rb                # rake clean / rake clobber
ruby 05_package_task.rb                 # rake package — .gem + .tar.gz
ruby 06_multitask.rb                    # Parallel tasks — 3x faster

# Real-world Rakefiles
ruby 07_real_rakefile.rb                # Complete Rakefile: test, lint, build, release
ruby 08_ci_pipeline.rb                  # CI: test → lint → build → package
```

## Learning Path

### Core Features (~25 min)

| Script | Concept |
|---|---|
| `01_task_arguments.rb` | `task :name, [:arg1, :arg2]` — pass parameters to tasks |
| `02_test_task.rb` | `Rake::TestTask` — `rake test` for Minitest |
| `03_filelist.rb` | `FileList['**/*.rb'].exclude('test/**/*')` — file selection |

### Project Maintenance (~20 min)

| Script | Concept |
|---|---|
| `04_clean_clobber.rb` | `CLEAN` / `CLOBBER` — two-level cleanup |
| `05_package_task.rb` | `Rake::PackageTask` — .gem + .tar.gz |
| `06_multitask.rb` | `multitask` — parallel execution |

### Real-World Rakefiles (~20 min)

| Script | Concept |
|---|---|
| `07_real_rakefile.rb` | Complete Rakefile: test, lint, build, release |
| `08_ci_pipeline.rb` | CI pipeline: test → lint → build → package |

## Common Patterns

```ruby
# TestTask — one command for all tests
require 'rake/testtask'
Rake::TestTask.new(:test) do |t|
  t.libs << 'lib' << 'test'
  t.test_files = FileList['test/**/*_test.rb']
end

# Task arguments — pass parameters
task :deploy, [:env, :branch] do |t, args|
  puts "Deploying to #{args[:env]} from #{args[:branch]}"
end
# Usage: rake deploy[production,main]

# Clean/Clobber — standard cleanup
require 'rake/clean'
CLEAN.include('build/', '*.log')
CLOBBER.include('pkg/', '*.gem')

# Multitask — parallel execution
multitask build: [:compile_css, :compile_js, :minify_images]

# CI pipeline — fail-fast chain
task ci: [:test, :lint, :build, :package]
```

## Now Build Your Own

Take the Rakefile from `project/Rakefile` and adapt it to your own project:
1. Change `test_files` to match your test directory
2. Add a `:lint` task that runs your linter (RuboCop, Standard, etc.)
3. Add a `:release` task that tags and pushes to git
4. Make `rake` (default) run `rake test`

The project Rakefile is designed to be copied — it's a real, working template.
