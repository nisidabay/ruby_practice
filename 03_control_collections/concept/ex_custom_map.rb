#!/usr/bin/env ruby
# frozen_string_literal :true
# Exercise from Udemy Course

# Define a custom_map method that accepts an array.
# The method should emulate the functionality of the array's map method.
# The block that we pass to custom_map will specify what to do to
# each array element. The custom_map method should return an array
# of the results of those operations.
# Do NOT use the array's map method in your solution.
#
# Examples:
# The => indicates the expected return value
# custom_map([1, 2, 3]) { |number| number * 3 }            => [3, 6, 9]
# custom_map(["Hello", "Goodbye"]) { |text| text.length }  => [5, 7]
# custom_map([]) { |text| text.length }                    => []

# NOTE: yield send the element to the "block"
def custom_map(elements)
  counter = 0
  results = []
  while counter < elements.length
    # results << yield(elements[counter])
    results.push(yield(elements[counter]))
    counter += 1
  end
  results
end

p custom_map([1, 2, 3]) { |number| number * 3 }
p custom_map(%w[Hello Goodbye]) { |text| text.length }
p custom_map([]) { |text| text.length }
