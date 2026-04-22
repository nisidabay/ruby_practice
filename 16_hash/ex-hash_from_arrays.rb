#!/usr/bin/env ruby
# Define a hash_from_arrays method that accepts two arrays.
# The two arrays will be equal in length.
# Return a hash where the elements of the first array
# are the keys and the elements of the second array are
# the elements. Match the elements across the two arrays
# by their shared index position.
#
# Examples:
# The => indicates the expected return value
# hash_from_arrays(["red", "green", "blue"], [1, 2, 3])   => {"red"=>1, "green"=>2, "blue"=>3}
# hash_from_arrays([:hello, :happy], [:goodbye, :sad])    => {:hello=>:goodbye, :happy=>:sad}
# hash_from_arrays([], [])                                => {}


def hash_from_arrays(arr1, arr2)
  raise ArgumentError "Arrays must be the same size" unless arr1.size == arr2.size
  hash={}
  arr1.each_with_index{ |key,index| hash[key]=arr2[index]}
  hash
end

p hash_from_arrays(["red", "green", "blue"], [1, 2, 3])   
p hash_from_arrays([:hello, :happy], [:goodbye, :sad])    
p hash_from_arrays([], [])                               
