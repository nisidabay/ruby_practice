# Ruby Concepts — Practice Suite

A progressive learning path from Ruby fundamentals through OptionParser and Rake.

Files use a 3-letter prefix for instant category recognition:

| Prefix | Category | When |
|---|---|---|
| `basics_` | Ruby fundamentals | Read first |
| `args_` | Method argument patterns | Read second |
| `optparse_` | OptionParser CLI | Read third |
| `reference/` | Templates, exercises, guides | Not linear |
| `rake_` | Task automation with Rake | Read last |

## Quick Start

```bash
# 1. Ruby basics
ruby basics_01_hello_lesson.rb                    # each vs while loops
ruby basics_02_comments.rb                        # comment conventions
ruby basics_03_input.rb                           # gets, $stdin
ruby basics_04_default_arguments.rb               # keyword args with defaults
ruby basics_05_splat_args.rb                      # *args captures variable positional args

# 2. Method argument patterns
ruby args_01_kwarg_double_splat.rb                # **options captures extra kwargs
ruby args_02_kwarg_forwarding.rb                  # forward **flags to another method
ruby args_03_block_argument.rb                    # &block explicit block parameter
ruby args_04_argument_forwarding.rb               # (...) forwards everything

# 3. OptionParser series (crescendo: each builds on the one before)
ruby optparse_01_basic_flags.rb -v --debug --no-quiet
ruby optparse_02_parse_vs_parse_bang.rb
ruby optparse_03_string_args.rb -n "Alice" --email "alice@example.com"
ruby optparse_04_type_conversion.rb -p 8080 -r 2.5
ruby optparse_05_validation.rb --api-key abc123 --endpoint https://api.example.com
ruby optparse_06_advanced_types.rb -t ruby -t python -i abc,def -f json -w 5
ruby optparse_07_separators_banners.rb --host 0.0.0.0 --port 3000 --verbose
ruby optparse_08_subcommands.rb deploy --environment production --servers web1,web2

# 4. Rake — task automation
cd ../project && rake -T                           # list available tasks
cd ../project && rake process                      # download → process chain
ruby rake_01_basics.rb                             # task definition template
```

## Learning Path

### Ruby Fundamentals (~30 min)

| Script | Concept |
|---|---|
| `basics_01_hello_lesson.rb` | `each` vs `while` loops |
| `basics_02_comments.rb` | Comments explain WHY, not what |
| `basics_03_input.rb` | `gets`, `$stdin`, `&.` safe navigation |
| `basics_04_default_arguments.rb` | Keyword args with defaults (`convertible: false`) |
| `basics_05_splat_args.rb` | Splat `*args` captures variable positional args |
| `argf_demo.rb` | `ARGF` — pipe or file input, UNIX tool pattern |

### Method Argument Patterns (~30 min)

| Script | Problem it solves |
|---|---|
| `args_01_kwarg_double_splat.rb` | `**options` — accept extra kwargs without declaring them |
| `args_02_kwarg_forwarding.rb` | Catch with `**` then pass through to another method |
| `args_03_block_argument.rb` | `&block` — capture block as Proc (store it, forward it) |
| `args_04_argument_forwarding.rb` | `(...)` — forward ALL args (positional + keyword + block) |

### OptionParser Series (~2 hours) — Crescendo: each file builds on the one before

| Script | Concepts | Builds on | Time |
|---|---|---|---|
| `optparse_01_basic_flags.rb` | Boolean flags, `--[no-]option` pattern | — | 10 min |
| `optparse_02_parse_vs_parse_bang.rb` | `parse!` mutates ARGV vs `parse` returns | 01 (now you understand the bang) | 10 min |
| `optparse_03_string_args.rb` | Value-taking args, required vs optional brackets | 01 (block receives value instead of nothing) | 15 min |
| `optparse_04_type_conversion.rb` | Integer, Float auto-conversion | 03 (block gets typed value, not String) | 15 min |
| `optparse_05_validation.rb` | `begin/rescue/end`, `$stderr`, required validation, custom validators | 03+04 (errors + pipe problem) | 25 min |
| `optparse_06_advanced_types.rb` | Array, restricted values, optional typed args | 04 (more type patterns) | 20 min |
| `optparse_07_separators_banners.rb` | Option groups, `separator`, version flag, dynamic banner | 01+03+04 (now organized) | 15 min |
| `optparse_08_subcommands.rb` | Subcommands, `order!` vs `parse!`, full CLI tool | 01–07 capstone | 30 min |

### Rake (~30 min)

| Script | Concept | Time |
|---|---|---|
| `rake_01_basics.rb` | `task` definitions, `=>` dependencies, `rake -T` | 5 min |
| `rake_essentials.rb` | When Rake vs. plain Ruby script — decision guide | 5 min |
| `../project/Rakefile` | 6-phase progressive: deps, file tasks, rules, namespaces, defaults, invoke | 20 min |

### Reference

| File | Notes |
|---|---|
| `reference/minimal_setup.rb` | Smallest possible OptionParser template |
| `reference/exercises.rb` | Consolidation: all 4 argument patterns |
| `reference/OPTIONPARSER_TUTORIAL.md` | Comprehensive written guide |

## Common Patterns Reference

### Keyword Arg Patterns

```ruby
# ** — catch unknown kwargs into a Hash
def create_user(name:, email:, **options)
  options.each { |k, v| puts "  #{k}: #{v}" }
end

# Forward ** to another method
def deploy(env:, **flags)
  run_checks(**flags)
end

# & — capture block as Proc
def benchmark(label, &block)
  start = Time.now
  result = block.call
  puts "#{label}: #{(Time.now - start).round(4)}s"
  result
end

# (...) — forward everything (Ruby 2.7+)
def wrapper(...)
  target(...)
end

# * — capture variable positional args into an Array
def deploy(env, *services)
  puts "Deploying to #{env}: #{services.join(', ')}"
end
```

### OptionParser Patterns

```ruby
# Boolean flag
opts.on("-v", "--verbose", "Enable verbose output") do
  options[:verbose] = true
end

# Required string
opts.on("-n", "--name NAME", "Your name") do |name|
  options[:name] = name
end

# Type conversion
opts.on("-p", "--port PORT", Integer, "Port number") do |port|
  options[:port] = port
end

# Restricted values
opts.on("-e", "--env ENV", %w[dev staging prod], "Environment") do |env|
  options[:env] = env
end

# Custom validator
opts.on("-p", "--port PORT", "Port (1-65535)") do |port_str|
  port = Integer(port_str)
  raise OptionParser::InvalidArgument, "Invalid port" unless (1..65535).include?(port)
  options[:port] = port
end
```

### Rake Patterns

```ruby
# Basic task
task :greet do
  puts "Hello!"
end

# Task with dependencies (runs :download first)
task process: :download do
  data = File.read("/tmp/data.txt")
end

# File task — only runs if target is older than source
file 'output.pdf' => 'input.md' do
  sh 'pandoc input.md -o output.pdf'
end

# Rule — one pattern, infinite files
rule '.reversed' => '.txt' do |t|
  content = File.read(t.source).reverse
  File.write(t.name, content)
end

# Namespaces — organize with ::
namespace :db do
  task create: ... end
  task migrate: :create do ... end
end

# Programmatic invocation from Ruby
Rake::Task[:download].invoke

# List all tasks: rake -T
```

## Error Handling

OptionParser provides these exception classes:

- `OptionParser::InvalidOption` — Unknown option
- `OptionParser::MissingArgument` — Required argument not provided
- `OptionParser::InvalidArgument` — Argument fails custom validation
- `OptionParser::AmbiguousOption` — Abbreviated option matches multiple

```ruby
begin
  OptionParser.new { |opts| ... }.parse!
rescue OptionParser::InvalidOption => e
  $stderr.puts "Error: #{e.message}"   # stderr, not stdout
  exit 1                                # non-zero = failure
end
```

## Additional Resources

- `reference/OPTIONPARSER_TUTORIAL.md` — Comprehensive written guide
- [Ruby Docs: OptionParser](https://ruby-doc.org/stdlib/libdoc/optparse/rdoc/OptionParser.html)
- Run any script with `-h` to see its help message

## Now Build Your Own

Write a CLI tool that takes `--name` and `--repeat N` flags,
prints `"Hello, #{name}!"` N times, and exits 0 on success.
Use `optparse_01_basic_flags.rb` as your template.
