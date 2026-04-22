# Ruby OptionParser Practice Suite

A hands-on learning suite for mastering Ruby's OptionParser module.

## Quick Start

Work through the scripts in order - each builds on concepts from the previous:

```bash
# 1. Basic boolean flags
ruby 01_basic_flags.rb -v --debug

# 2. String arguments  
ruby 02_string_args.rb -n "Alice" --email "alice@example.com"

# 3. Type conversion (Integer, Float, Array)
ruby 03_type_conversion.rb -p 8080 -r 3.14 -t ruby -t python

# 4. Required options and validation
ruby 04_required_options.rb --api-key abc123 --endpoint https://api.example.com

# 5. Custom validators
ruby 05_custom_validation.rb --port 8080 --env production

# 6. Advanced features (separators, version, complex layouts)
ruby 06_advanced_features.rb -V
ruby 06_advanced_features.rb --host localhost --port 3000 --verbose

# 7. Real-world CLI application
ruby 07_real_world_cli.rb deploy --environment production --servers web1,web2 --dry-run
```

## Learning Path

| Script | Concepts | Time |
|--------|----------|------|
| `01_basic_flags.rb` | Boolean flags, `--[no-]option` pattern | 10 min |
| `02_string_args.rb` | String arguments, required vs optional | 15 min |
| `03_type_conversion.rb` | Integer, Float, Array, restricted values | 20 min |
| `04_required_options.rb` | Post-parse validation, mutual exclusion | 15 min |
| `05_custom_validation.rb` | Custom validators, error handling | 20 min |
| `06_advanced_features.rb` | Separators, banners, version, formatting | 15 min |
| `07_real_world_cli.rb` | Complete CLI application | 30 min |

**Total: ~2 hours**

## Key Concepts by Script

### 01 - Basic Flags
- Simple boolean options (`-v`, `--verbose`)
- The `--[no-]option` pattern for toggleable flags
- Accessing parsed values from the options hash

### 02 - String Arguments
- Required string arguments
- Optional arguments with `[ARG]` syntax
- Multi-line option descriptions

### 03 - Type Conversion
- Automatic Integer/Float conversion
- Array collection (multiple `-t` flags)
- Comma-separated values
- Restricted value sets (`["json", "xml", "yaml"]`)

### 04 - Required Options
- Post-parse validation
- Checking for missing required options
- Mutually exclusive options
- Dependent option validation

### 05 - Custom Validation
- Raising `OptionParser::InvalidArgument`
- Port range validation
- Environment validation
- File existence checks
- Date format validation

### 06 - Advanced Features
- Custom banners with heredocs
- Section separators
- Version information
- Custom help footers
- Option grouping

### 07 - Real-World CLI
- Complete deployment tool simulation
- Command parsing (deploy/rollback/status/logs)
- JSON output format
- Authentication handling
- Dry-run mode
- Verbose/quiet modes

## Common Patterns Reference

### Boolean Flag
```ruby
opts.on("-v", "--verbose", "Enable verbose output") do
  options[:verbose] = true
end
```

### Required String
```ruby
opts.on("-n", "--name NAME", "Your name") do |name|
  options[:name] = name
end
```

### Optional Argument
```ruby
opts.on("-o", "--output [FILE]", "Output file") do |file|
  options[:output] = file || "stdout"
end
```

### Type Conversion
```ruby
opts.on("-p", "--port PORT", Integer, "Port number") do |port|
  options[:port] = port
end
```

### Restricted Values
```ruby
opts.on("-e", "--env ENV", ["dev", "staging", "prod"], "Environment") do |env|
  options[:env] = env
end
```

### Array (Multiple Values)
```ruby
opts.on("-t", "--tag TAG", Array, "Tags") do |tags|
  options[:tags] ||= []
  options[:tags] += tags
end
```

### Custom Validator
```ruby
opts.on("-p", "--port PORT", "Port (1-65535)") do |port_str|
  port = Integer(port_str)
  raise OptionParser::InvalidArgument, "Invalid port" unless (1..65535).include?(port)
  options[:port] = port
end
```

## Error Handling

OptionParser provides these exception classes:

- `OptionParser::InvalidOption` - Unknown option
- `OptionParser::MissingArgument` - Required argument not provided
- `OptionParser::InvalidArgument` - Argument fails custom validation
- `OptionParser::AmbiguousOption` - Abbreviated option matches multiple

Example:
```ruby
begin
  OptionParser.new { |opts| ... }.parse!
rescue OptionParser::InvalidOption => e
  puts "Error: #{e.message}"
  exit 1
end
```

## Additional Resources

- `OPTIONPARSER_TUTORIAL.md` - Comprehensive written guide
- [Ruby Docs: OptionParser](https://ruby-doc.org/stdlib/libdoc/optparse/rdoc/OptionParser.html)
- Run any script with `-h` to see its help message

## Tips for Learning

1. **Run with `-h` first** - See what each script accepts
2. **Try invalid inputs** - See how validation works
3. **Read the source** - Each script is well-commented
4. **Modify and experiment** - Change options and see what breaks
5. **Build your own** - Use script 07 as a template for your CLI
