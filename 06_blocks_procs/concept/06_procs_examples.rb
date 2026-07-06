#!/usr/bin/env ruby
#
# Ways to create procs. An object representation of a block

# Initialize an array of numbers
a = [1, 2, 4]

# Create a Proc that calculates the cube of a number.
# Procs are objects that store blocks of code for later execution.
to_cubes = proc { |number| number**3 }

# Pass the Proc to the `map` method. The `&` symbol converts the Proc object
# back into a block that the method expects.
p "Converted to cubes: #{a.map(&to_cubes)}"

# Alternative syntax for creating a Proc using do...end.
to_squares = proc do |number|
  number**2
end
p "Converted to squares: #{a.map(&to_squares)}"

ages = [34, 55, 90, 61, 18, 33]

# Create a Proc that returns a boolean (useful for filtering).
senior = proc { |age| age > 51 }

# Use the Proc with `select` to keep only elements matching the condition.
p "Senior ages: #{ages.select(&senior)}"

# Use the same Proc with `reject` to remove elements matching the condition.
p "No Senior ages: #{ages.reject(&senior)}"

# Passing blocks implicitly
# When defining a method, `&block` captures an incoming block into a Proc object.
def with_logging(&block)
  p 'Starting ...'
  block.call # Execute the captured block
  p 'Finished'
end

# Call the method with a literal block. The method converts it to a Proc internally.
with_logging { p 'Doing work...' }

# You can call a Proc directly using the `.call` method.
my_proc = proc { |x| x * 2 }
p my_proc.call(5)

# Methods can accept regular arguments alongside a block.
def talk_about(name, &my_proc)
  p "Let me tell you about #{name}"
  my_proc.call(name)
end

# Define a Proc variable to pass to a method.
good_thing = proc { |name| p "#{name} is a jolly good fellow" }

# Pass the Proc `good_thing` as a block argument using `&`.
talk_about('Carlos', &good_thing)

# A method that yields to a block without explicitly defining it as a parameter.
def talk_about_2(name)
  p "Let me tell you about #{name}"
  yield(name) # Transfers execution to the block
end

# Call with a literal block.
talk_about_2('Carlos') { |name| p "#{name} is a someone special" }

# Call with an existing Proc, converting it to a block for the yield.
talk_about_2('Carlos', &good_thing)

# Thinking in Ruby
#
# Procs are first-class objects that represent blocks of code. The & operator
# is the bridge between blocks (syntactic) and Procs (objects). Once you
# understand that every method's block parameter is secretly a Proc, Ruby's
# block system opens up — you can pass procs to methods that yield, store
# procs in variables, pass them between methods, and compose them like any
# other object. The & callable conversion also works with symbols and methods.
