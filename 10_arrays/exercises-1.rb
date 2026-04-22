#!/usr/bin/env ruby
# frozen_string_literal: true

# Exercises-1
# This file contains Ruby code for exercises-1.

# Define a first_and_last method that accepts an array of strings.
# The method should concatenate the first element and the last element
# and return the result.
# Assume the list will always have 1 or more elements.
#
def first_and_last(array)
  "#{array[0]}#{array[-1]}"
end

p first_and_last(%w[a b c])
p first_and_last(%w[bob tom rob])
p first_and_last(['a'])

# Examples
# The => indicates the expected return value
# first_and_last(["a", "b", "c"])        => "ac"
# first_and_last(["bob", "tom", "rob"])  => "bobrob"
# first_and_last(["a"])                  => "aa"

# Define a product_of_even_indices method that accepts an
# array of numbers. The array will always have 6 total elements.
# The method should return the product (multiplied total) of
# all numbers at an even index (0, 2, 4).
#
def product_of_even_indexes(array)
  product = 1
  array.each_with_index do |value, index|
    product *= value if index.even?
  end
  product
end
p product_of_even_indexes([1, 2, 3, 4, 5, 6])
p product_of_even_indexes([3, 4, 3, 5, 3, 6])

# Examples
# The => indicates the expected return value
# product_of_even_indices([1, 2, 3, 4, 5, 6])    =>  15
# product_of_even_indices([3, 4, 3, 5, 3, 6])    =>  27

# Define a first_letter_of_last_string method that accepts an
# array of strings. It should return one character: the first
# letter of the last string in the array.
# Assume the array will always have at least one string.
def first_letter_of_last_string(array)
  array[-1][0]
end
p first_letter_of_last_string(%w[cat dog zebra])
p first_letter_of_last_string(['nonsense'])
# Examples
# The => indicates the expected return value
# first_letter_of_last_string(["cat", "dog", "zebra"]) => "z"
# first_letter_of_last_string(["nonsense"])            => "n"
#

# Define a split_in_two method that accepts an array.
# I'd like to split the array into two arrays.
# If the original array has an even number of elements,
# ensure that the 2 new arrays have an equal number of elements
# If the original array has an odd number of elements,
# ensure that the first new array has the greater number of elements.
def split_in_two(array)
  n = array.length
  mid = ((n / 2) + (n % 2))
  [array[0, mid], array[mid..]]
end

# Examples:
# The => indicates the expected return value
# split_in_two(["A", "B"])                => [["A"], ["B"]]
# split_in_two(["A", "B", "C", "D"])      => [["A", "B"], ["C", "D"]]
# split_in_two(["A", "B", "C"])           => [["A", "B"], ["C"]]
# split_in_two(["A", "B", "C", "D", "E"]) => [["A", "B", "C"], ["D", "E"]]
p split_in_two(%w[A B])
p split_in_two(%w[A B C D])
p split_in_two(%w[A B C])
p split_in_two(%w[A B C D E])

# Define a product_of_number_and_index method that accepts an array of numbers.
# The method should iterate over the elements. For each element,
# it should multiply the element by its index position. It should
# then add that product to a rolling sum. Return the final sum.
# If the array has no elements, the final sum should be 0.
#
# Examples:
# The => indicates the expected return value
# product_of_number_and_index([1, 2, 3]) => (0 * 1) + (1 * 2) + (2 * 3) => 8
# product_of_number_and_index([])        => 0
def product_of_number_and_index(array)
  sum = 0
  array.each_with_index { |value, index| sum += index * value }
  sum
end

p product_of_number_and_index([1, 2, 3])
p product_of_number_and_index([])
