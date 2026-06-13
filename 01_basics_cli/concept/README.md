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

# 3. OptionParser series (crescendo: each builds on the one before — all use ytdl)
ruby optparse_01_basic_flags.rb -v --dry-run --no-metadata
ruby optparse_02_parse_vs_parse_bang.rb
ruby optparse_03_string_args.rb -u 'https://youtube.com/watch?v=abc123' -o my_video.mp4
ruby optparse_04_type_conversion.rb -c 5 -r 1.5 -t 60
ruby optparse_05_validation.rb -u 'https://youtube.com/watch?v=abc' -f mp4 -p 8080 -j
ruby optparse_06_advanced_types.rb -q high -g ruby,python,go -p stdin
ruby optparse_08_subcommands.rb download -u 'https://youtube.com/watch?v=abc' -f mp4 -q high --dry-run
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

All examples use the same `ytdl` (YouTube downloader) tool identity so you focus on option mechanics, not re-learning what each script does.

| Script | Concepts | Builds on | Time |
|---|---|---|---|
| `optparse_01_basic_flags.rb` | Boolean flags, `--[no-]option` pattern | — | 10 min |
| `optparse_02_parse_vs_parse_bang.rb` | `parse!` mutates ARGV vs `parse` returns | 01 (now you understand the bang) | 10 min |
| `optparse_03_string_args.rb` | Value-taking args, required vs optional brackets | 01 (block receives value instead of nothing) | 15 min |
| `optparse_04_type_conversion.rb` | Integer, Float auto-conversion | 03 (block gets typed value, not String) | 15 min |
| `optparse_05_validation.rb` | `begin/rescue/end`, required validation, custom validators | 03+04 (errors + required enforcement) | 25 min |
| `optparse_06_advanced_types.rb` | Array, restricted values, optional typed args | 04 (more type patterns) | 20 min |
| `optparse_08_subcommands.rb` | Subcommands, full CLI tool | 01–06 capstone | 30 min |

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
opts.on("-u", "--url URL", "Video URL") do |url|
  options[:url] = url
end

# Type conversion
opts.on("-c", "--concurrent-downloads N", Integer, "Concurrent downloads") do |n|
  options[:concurrent] = n
end

# Restricted values
opts.on("-f", "--format FORMAT", %w[mp3 mp4 mkv], "Output format") do |fmt|
  options[:format] = fmt
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

## Now Build Your Own

Write a CLI tool that takes `--name` and `--repeat N` flags,
prints `"Hello, #{name}!"` N times, and exits 0 on success.
Use `optparse_01_basic_flags.rb` as your template.
