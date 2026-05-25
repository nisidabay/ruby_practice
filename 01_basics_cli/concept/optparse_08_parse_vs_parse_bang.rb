#!/usr/bin/env ruby

require 'optparse'

program = File.basename($0, '.rb')

puts "=" * 60
puts "DEMONSTRATION: parse! vs parse"
puts "=" * 60
puts

# Demo 1: parse! (destructive)
puts "1. Using parse! (destructive - modifies ARGV)"
puts "-" * 50

# Simulate ARGV for demonstration
test_argv = ['--verbose', '--name', 'Alice', 'file1.txt', 'file2.txt']
puts "Before parse!: #{test_argv.inspect}"

options = { verbose: false, name: nil }
OptionParser.new do |opts|
  opts.banner = "Usage: #{program} [options] [files...]"
  opts.on("-v", "--verbose", "Enable verbose mode") { options[:verbose] = true }
  opts.on("-n", "--name NAME", "Specify name") { |name| options[:name] = name }
end.parse!(test_argv)

puts "After parse!:  #{test_argv.inspect}"
puts "Options: #{options.inspect}"
puts "Note: ARGV was MODIFIED - options removed in-place"
puts

# Demo 2: parse (non-destructive)
puts "2. Using parse (non-destructive - preserves original)"
puts "-" * 50

test_argv2 = ['--verbose', '--name', 'Bob', 'data.csv', 'output.json']
puts "Before parse: #{test_argv2.inspect}"

options2 = { verbose: false, name: nil }
remaining = OptionParser.new do |opts|
  opts.banner = "Usage: #{program} [options] [files...]"
  opts.on("-v", "--verbose", "Enable verbose mode") { options2[:verbose] = true }
  opts.on("-n", "--name NAME", "Specify name") { |name| options2[:name] = name }
end.parse(test_argv2)

puts "After parse:  #{test_argv2.inspect}"
puts "Remaining:    #{remaining.inspect}"
puts "Options: #{options2.inspect}"
puts "Note: Original array PRESERVED - return value has remaining args"
puts

# Demo 3: Real-world pattern with parse!
puts "3. Real-world CLI pattern (using parse! with ARGV)"
puts "-" * 50

puts "Typical CLI tool structure:"
puts <<~CODE
  #!/usr/bin/env ruby
  require 'optparse'
  
  options = { file: nil }
  OptionParser.new do |opts|
    opts.on("-f", "--file FILE", "Input file") { |f| options[:file] = f }
  end.parse!
  
  # ARGV now contains only positional arguments
  input_file = ARGV[0]
  output_file = ARGV[1]
CODE
puts

puts "=" * 60
puts "SUMMARY"
puts "=" * 60
puts "parse! : Use for CLI tools (modifies ARGV, cleaner code)"
puts "parse  : Use when you need to preserve original args"
puts "=" * 60
