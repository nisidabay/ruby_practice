# Ruby Concepts — Practice Suite

A progressive learning path from Ruby fundamentals through OptionParser.

Files use a 3-letter prefix for instant category recognition:

| Prefix | Category | When |
|---|---|---|
| `basics_` | Ruby fundamentals | Read first |
| `args_` | Method argument patterns | Read second |
| `optparse_` | OptionParser CLI | Read third |
| `reference/` | Templates, exercises, guides | Not linear |

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

# 3. OptionParser series
ruby optparse_01_basic_flags.rb -v --debug
ruby optparse_02_string_args.rb -n "Alice" --email "alice@example.com"
ruby optparse_03_type_conversion.rb -p 8080 -r 3.14 -t ruby -t python
ruby optparse_04_required_options.rb --api-key abc123 --endpoint https://api.example.com
ruby optparse_05_custom_validation.rb --port 8080 --env production
ruby optparse_06_advanced_features.rb -V
ruby optparse_07_real_world_cli.rb deploy --environment production --servers web1,web2 --dry-run
ruby optparse_08_parse_vs_parse_bang.rb
ruby optparse_09_stderr_exit_codes.rb --port 99999
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

### Method Argument Patterns (~30 min)

| Script | Problem it solves |
|---|---|
| `args_01_kwarg_double_splat.rb` | `**options` — accept extra kwargs without declaring them |
| `args_02_kwarg_forwarding.rb` | Catch with `**` then pass through to another method |
| `args_03_block_argument.rb` | `&block` — capture block as Proc (store it, forward it) |
| `args_04_argument_forwarding.rb` | `(...)` — forward ALL args (positional + keyword + block) |

### OptionParser Series (~2 hours)

| Script | Concepts | Time |
|---|---|---|
| `optparse_01_basic_flags.rb` | Boolean flags, `--[no-]option` pattern | 10 min |
| `optparse_02_string_args.rb` | String arguments, required vs optional | 15 min |
| `optparse_03_type_conversion.rb` | Integer, Float, Array, restricted values | 20 min |
| `optparse_04_required_options.rb` | Post-parse validation, mutual exclusion | 15 min |
| `optparse_05_custom_validation.rb` | Custom validators, error handling | 20 min |
| `optparse_06_advanced_features.rb` | Separators, banners, version | 15 min |
| `optparse_07_real_world_cli.rb` | Complete CLI application | 30 min |
| `optparse_08_parse_vs_parse_bang.rb` | `parse!` (mutates ARGV) vs `parse` (returns) | 10 min |
| `optparse_09_stderr_exit_codes.rb` | `$stderr` for errors, exit codes for shell | 10 min |

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

# Optional argument
opts.on("-o", "--output [FILE]", "Output file") do |file|
  options[:output] = file || "stdout"
end

# Type conversion
opts.on("-p", "--port PORT", Integer, "Port number") do |port|
  options[:port] = port
end

# Restricted values
opts.on("-e", "--env ENV", ["dev", "staging", "prod"], "Environment") do |env|
  options[:env] = env
end

# Array (multiple values)
opts.on("-t", "--tag TAG", Array, "Tags") do |tags|
  options[:tags] ||= []
  options[:tags] += tags
end

# Custom validator
opts.on("-p", "--port PORT", "Port (1-65535)") do |port_str|
  port = Integer(port_str)
  raise OptionParser::InvalidArgument, "Invalid port" unless (1..65535).include?(port)
  options[:port] = port
end
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
