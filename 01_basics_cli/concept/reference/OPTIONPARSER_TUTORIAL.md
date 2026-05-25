# Ruby OptionParser Master Guide

## Table of Contents
1. [What is OptionParser?](#what-is-optionparser)
2. [Basic Setup](#basic-setup)
3. [Defining Options](#defining-options)
4. [Option Types](#option-types)
5. [Advanced Features](#advanced-features)
6. [Best Practices](#best-practices)
7. [Practice Scripts](#practice-scripts)

---

## What is OptionParser?

OptionParser is Ruby's built-in library for parsing command-line options. It's
part of the standard library and provides a clean, declarative way to define
and handle CLI arguments.

**Key Features:**
- Automatic help message generation (`-h`/`--help`)
- Type coercion (strings, integers, floats, booleans)
- Short and long option support (`-v` and `--verbose`)
- Option validation and error handling
- Banner and summary customization

---

## Basic Setup

### Minimal Example

```ruby
#!/usr/bin/env ruby
require 'optparse'

options = {}
OptionParser.new do |opts|
  opts.banner = "Usage: script.rb [options]"
  
  opts.on("-v", "--verbose", "Enable verbose mode") do
    options[:verbose] = true
  end
end.parse!

puts options.inspect
```

### Dynamic Script Name in Banner

Never hardcode the script name! Use `$0` or `$PROGRAM_NAME`:

```ruby
#!/usr/bin/env ruby
require 'optparse'

program = File.basename($0, '.rb')  # Strips path and extension

options = {}
OptionParser.new do |opts|
  opts.banner = <<-BANNER
Usage: #{program} [options] [files...]

Process files with various options.

Options:
  BANNER
  
  opts.on("-v", "--verbose", "Enable verbose mode") do
    options[:verbose] = true
  end
end.parse!
```

**Why `File.basename($0)`?**

```ruby
# If script is called as:
#   ./bin/mytool
#   /home/user/scripts/mytool.rb
#   ruby /path/to/mytool.rb

$0                      #=> "./bin/mytool" or "/home/user/scripts/mytool.rb"
File.basename($0)       #=> "mytool" or "mytool.rb"
File.basename($0, '.rb') #=> "mytool" (strips extension too)
```

### parse! vs parse - Understanding the Difference

The `!` (bang) indicates **mutation** - whether the original array gets modified:

**`parse!` (destructive)**
- Modifies the original array (usually ARGV)
- Removes parsed options in-place
- Returns remaining unparsed arguments

```ruby
ARGV = ['--verbose', 'input.txt', 'output.txt']
options = {}
OptionParser.new do |opts|
  opts.on('--verbose') { options[:verbose] = true }
end.parse!

# ARGV is now: ['input.txt', 'output.txt']
# The --verbose flag was REMOVED from ARGV
```

**`parse` (non-destructive)**
- Leaves the original array untouched
- Returns remaining unparsed arguments
- You must capture the return value

```ruby
ARGV = ['--verbose', 'input.txt', 'output.txt']
options = {}
remaining = OptionParser.new do |opts|
  opts.on('--verbose') { options[:verbose] = true }
end.parse(ARGV)

# ARGV is still: ['--verbose', 'input.txt', 'output.txt']
# remaining = ['input.txt', 'output.txt']
```

**Why use `parse!`?**

Most CLI tools use `parse!` because:
1. **Clean separation** - After parsing, ARGV contains only positional arguments
2. **No extra variable** - You don't need to capture the return value
3. **Convention** - Other ARGV-processing code can safely use what's left

```ruby
# Typical CLI pattern with parse!
options = {}
OptionParser.new do |opts|
  opts.on('-f FILE') { |f| options[:file] = f }
end.parse!

# Now ARGV has only positional args
input_file = ARGV[0]
output_file = ARGV[1]
```

**When to use `parse`?**

Use non-destructive `parse` when you need to preserve the original arguments for:
- Logging/debugging
- Passing to another parser
- Audit trails

### Running the Script
```bash
./script.rb -v
./script.rb --verbose
./script.rb -h  # Shows help
```

---

## Defining Options

### Option Syntax

```ruby
opts.on("-s", "--short LONG", "Description") do |value|
  # Handle the option
end
```

**Components:**
- `-s` : Short option (single character)
- `--short` : Long option (descriptive name)
- `LONG` : Argument name (shown in help)
- `"Description"` : Help text

### Common Patterns

```ruby
# Boolean flag (no argument)
opts.on("-v", "--verbose", "Enable verbose output") do
  options[:verbose] = true
end

# String argument
opts.on("-n", "--name NAME", "Your name") do |name|
  options[:name] = name
end

# Integer argument
opts.on("-p", "--port PORT", Integer, "Port number") do |port|
  options[:port] = port
end

# Array of values (can be specified multiple times)
opts.on("-t", "--tag TAG", Array, "Tags (can repeat)") do |tags|
  options[:tags] ||= []
  options[:tags] += tags
end
```

---

## Option Types

### Built-in Type Conversions

```ruby
# Integer
opts.on("-c", "--count N", Integer, "Number of items") do |n|
  # n is already an Integer
end

# Float
opts.on("-r", "--rate R", Float, "Rate value") do |r|
  # r is already a Float
end

# Array (comma-separated or multiple flags)
opts.on("-i", "--ids ID1,ID2,ID3", Array, "List of IDs") do |ids|
  # ids is an Array of strings
end

# Custom type validation
opts.on("-e", "--env ENV", ["dev", "staging", "prod"], "Environment") do |env|
  # env is validated against the array
end
```

### Optional Arguments

```ruby
# Optional string argument
opts.on("-o", "--output [FILE]", "Output file (default: stdout)") do |file|
  options[:output] = file || "stdout"
end

# Optional with default
opts.on("-f", "--format [FORMAT]", String, "Output format") do |fmt|
  options[:format] = fmt || "json"
end
```

---

## Advanced Features

### Required Options

```ruby
required = [:api_key, :endpoint]
missing = required - options.keys

if missing.any?
  puts "Missing required options: #{missing.join(', ')}"
  puts opts
  exit 1
end
```

### Mutually Exclusive Options

```ruby
if options[:json] && options[:xml]
  puts "Error: Cannot use both --json and --xml"
  exit 1
end
```

### Custom Validators

```ruby
opts.on("-p", "--port PORT", "Port number (1-65535)") do |port|
  port_int = Integer(port)
  raise OptionParser::InvalidArgument, "Port must be 1-65535" unless (1..65535).include?(port_int)
  options[:port] = port_int
end
```

### Version Banner

```ruby
opts.banner = <<-BANNER
Usage: #{File.basename($0)} [options] <command>

Commands:
  start     Start the server
  stop      Stop the server
  status    Show server status

Options:
BANNER

opts.on("-V", "--version", "Show version") do
  puts "myapp v1.0.0"
  exit
end
```

### Separating Options from Arguments

```ruby
options = {}
args = []

OptionParser.new do |opts|
  opts.on("-v", "--verbose", "Verbose mode") do
    options[:verbose] = true
  end
end.parse!(into: args)

# args now contains non-option arguments
# options contains parsed flags
```

---

## Best Practices

### 1. Always Include Help

```ruby
opts.on("-h", "--help", "Show this help message") do
  puts opts
  exit
end
```

### 2. Use Descriptive Option Names

```ruby
# Good
opts.on("-u", "--username USER", "Username for authentication")

# Bad
opts.on("-u", "--u USER", "User")
```

### 3. Group Related Options

```ruby
opts.separator ""
opts.separator "Connection options:"
opts.on("--host HOST", "Server hostname")
opts.on("--port PORT", "Server port")

opts.separator ""
opts.separator "Authentication options:"
opts.on("--user USER", "Username")
opts.on("--pass PASS", "Password")
```

### 4. Provide Sensible Defaults

```ruby
options = {
  verbose: false,
  port: 8080,
  format: "json"
}

# Then override with CLI options
```

### 5. Handle Errors Gracefully

```ruby
begin
  OptionParser.new do |opts|
    # ... options
  end.parse!
rescue OptionParser::InvalidOption => e
  puts "Error: #{e.message}"
  puts opts
  exit 1
end
```

---

## Practice Scripts

| Script | Focus |
|--------|-------|
| `01_basic_flags.rb` | Simple boolean flags |
| `02_string_args.rb` | String arguments |
| `03_type_conversion.rb` | Integer, Float, Array types |
| `04_required_options.rb` | Validation and requirements |
| `05_custom_validation.rb` | Custom validators |
| `06_advanced_features.rb` | Separators, version, complex setups |
| `07_real_world_cli.rb` | Complete CLI application |

Run each script with `-h` to see available options!

---

## Quick Reference

### Common Option Patterns

```ruby
# Flag (boolean)
opts.on("-v", "--verbose", "Verbose output") { options[:verbose] = true }

# Required argument
opts.on("-n", "--name NAME", "Your name") { |v| options[:name] = v }

# Optional argument
opts.on("-o", "--output [FILE]", "Output file") { |v| options[:output] = v || "stdout" }

# Type conversion
opts.on("-p", "--port PORT", Integer, "Port number") { |v| options[:port] = v }

# Multiple values
opts.on("-t", "--tag TAG", Array, "Tags") { |v| options[:tags] ||= []; options[:tags] += v }

# Restricted values
opts.on("-e", "--env ENV", %w[dev staging prod], "Environment") { |v| options[:env] = v }
```

### Error Classes

- `OptionParser::InvalidOption` - Unknown option
- `OptionParser::MissingArgument` - Required argument missing
- `OptionParser::InvalidArgument` - Argument fails validation
- `OptionParser::AmbiguousOption` - Abbreviated option matches multiple

---

## Resources

- [Ruby Docs: OptionParser](https://ruby-doc.org/stdlib/libdoc/optparse/rdoc/OptionParser.html)
- Practice scripts in this directory
- Run `ruby script_name.rb -h` for each script's help
