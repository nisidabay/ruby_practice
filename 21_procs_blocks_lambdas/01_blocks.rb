# Ruby Blocks - Basic Usage
# Blocks are chunks of code enclosed between do...end or {...}
# Blocks are NOT objects - they cannot be stored in variables

# Basic block syntax with each
[1, 2, 3].each do |number|
  puts number * 2
end

# Single-line block syntax
[1, 2, 3].each { |number| puts number * 2 }

# Yield - blocks are executed via yield
def greet
  puts "Before"
  yield
  puts "After"
end

greet { puts "BLOCK" }

# Multiple yields
def print_twice
  yield
  yield
end

print_twice { puts "Hello!" }

# Checking for block presence with block_given?
def maybe_yield
  if block_given?
    yield
  else
    puts "No block provided"
  end
end

maybe_yield { puts "Block here!" }
maybe_yield

# Capturing blocks with &block (converts to Proc)
def with_logging(&block)
  puts "Starting..."
  block.call
  puts "Finished!"
end

with_logging { puts "Doing work..." }

# Custom iterator using blocks
def repeat(n)
  n.times { yield } if block_given?
end

repeat(3) { puts "Echo!" }
