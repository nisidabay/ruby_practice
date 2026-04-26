# Ruby Lambdas - Strict Procs
# Lambdas are Procs with strict argument checking and safe return behavior

# Creating Lambdas - stabby syntax (Ruby 1.9+)
my_lambda = ->(x) { x * 2 }
puts my_lambda.call(5)

# Alternative syntax using lambda keyword
my_lambda2 = lambda { |x| x * 2 }
puts my_lambda2.call(5)

# Multi-line lambda
greet = ->(name) do
  puts "Hello, #{name}!"
  puts "Welcome!"
end
greet.call("Alice")

# Argument Strictness - lambdas enforce argument count
strict = ->(a, b) { a + b }

puts strict.call(1, 2)  # 3

begin
  strict.call(1)
rescue ArgumentError => e
  puts "Error: #{e.message}"
end

begin
  strict.call(1, 2, 3)
rescue ArgumentError => e
  puts "Error: #{e.message}"
end

# Return Behavior - safe, returns to caller not enclosing method
def test_lambda
  my_lambda = -> { return "From Lambda" }
  my_lambda.call
  "Method ended"  # This IS reached
end

puts test_lambda

# Lambdas for functional-style code
add = ->(a, b) { a + b }
multiply = ->(a, b) { a * b }

[add, multiply].each do |fn|
  puts fn.call(2, 3)
end

# Higher-Order Functions with Lambdas
def compose(f, g)
  ->(x) { f.call(g.call(x)) }
end

double = ->(x) { x * 2 }
increment = ->(x) { x + 1 }

double_then_increment = compose(increment, double)
puts double_then_increment.call(5)  # 11 (5 * 2 + 1)

# Proc Composition (Ruby 2.6+)
increment2 = ->(x) { x + 1 }
double2 = ->(x) { x * 2 }

# << means "pipe right to left" (increment first, then double)
puts (double2 << increment2).call(5)  # 12 (5+1=6, then 6*2=12)

# >> means "pipe left to right" (double first, then increment)
puts (double2 >> increment2).call(5)  # 11 (5*2=10, then 10+1=11)

# Lazy Evaluation
def lazy_eval
  -> { expensive_computation }
end

def expensive_computation
  puts "Computing..."
  42
end

lazy = lazy_eval
puts "Not computed yet"
puts lazy.call

# Check type
my_proc = Proc.new { |x| x * 2 }
my_lambda3 = ->(x) { x * 2 }

puts "Proc is lambda?: #{my_proc.lambda?}"
puts "Lambda is lambda?: #{my_lambda3.lambda?}"
