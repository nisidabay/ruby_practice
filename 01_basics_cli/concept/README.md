# Ruby Concepts — Practice Suite

A progressive learning path from Ruby fundamentals through OptionParser.

## Quick Start

Work through scripts in order — each builds on the previous:

```bash
# 1. Ruby basics
ruby hello_lesson.rb                       # each vs while loops
ruby comments.rb                           # comment conventions
ruby input.rb                              # gets, $stdin
ruby default_arguments.rb                   # keyword args with defaults
ruby additional_arguments.rb               # splat (*) + keyword args

# 2. Method argument patterns
ruby kwarg_double_splat.rb                 # **options captures extra kwargs
ruby kwarg_forwarding.rb                   # forward **flags to another method
ruby block_argument.rb                     # &block explicit block parameter
ruby argument_forwarding.rb                # (...) forwards everything

# 3. OptionParser series
ruby 01_basic_flags.rb -v --debug
ruby 02_string_args.rb -n "Alice" --email "alice@example.com"
ruby 03_type_conversion.rb -p 8080 -r 3.14 -t ruby -t python
ruby 04_required_options.rb --api-key abc123 --endpoint https://api.example.com
ruby 05_custom_validation.rb --port 8080 --env production
ruby 06_advanced_features.rb -V
ruby 06_advanced_features.rb --host localhost --port 3000 --verbose
ruby 07_real_world_cli.rb deploy --environment production --servers web1,web2 --dry-run
ruby 08_parse_vs_parse_bang.rb
ruby 09_stderr_exit_codes.rb --port 99999
```

## Learning Path

### Ruby Fundamentals (~30 min)

| Script | Concepts |
|---|---|
| `hello_lesson.rb` | `each` vs `while` loops |
| `comments.rb` | Comments explain WHY, not what |
| `input.rb` | `gets`, `$stdin`, `&.` safe navigation |
| `default_arguments.rb` | Keyword args with defaults (`convertible: false`) |
| `additional_arguments.rb` | Splat `*services` + keyword args |
| `exercises.rb` | Positional, keyword, splat, double-splat — combined |

### Method Argument Patterns (~30 min)

| Script | Problem it solves |
|---|---|
| `kwarg_double_splat.rb` | `**options` — accept extra kwargs without declaring them |
| `kwarg_forwarding.rb` | Catch with `**` then pass through to another method |
| `block_argument.rb` | `&block` — capture block as Proc (store it, forward it) |
| `argument_forwarding.rb` | `(...)` — forward ALL args (positional + keyword + block) |

### OptionParser Series (~2 hours)

| Script | Concepts | Time |
|---|---|---|
| `01_basic_flags.rb` | Boolean flags, `--[no-]option` pattern | 10 min |
| `02_string_args.rb` | String arguments, required vs optional | 15 min |
| `03_type_conversion.rb` | Integer, Float, Array, restricted values | 20 min |
| `04_required_options.rb` | Post-parse validation, mutual exclusion | 15 min |
| `05_custom_validation.rb` | Custom validators, error handling | 20 min |
| `06_advanced_features.rb` | Separators, banners, version | 15 min |
| `07_real_world_cli.rb` | Complete CLI application | 30 min |
| `08_parse_vs_parse_bang.rb` | `parse!` (mutates ARGV) vs `parse` (returns) | 10 min |
| `09_stderr_exit_codes.rb` | `$stderr` for errors, exit codes for shell | 10 min |

### Reference

| Script | Notes |
|---|---|
| `minimal_setup.rb` | Smallest possible OptionParser template |
| `reference/03_keyword_args.rb` | Original unsplit file (4 concepts) |

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

- `OPTIONPARSER_TUTORIAL.md` — Comprehensive written guide
- [Ruby Docs: OptionParser](https://ruby-doc.org/stdlib/libdoc/optparse/rdoc/OptionParser.html)
- Run any script with `-h` to see its help message
