#!/usr/bin/env ruby
# frozen_string_literal: true

# hash_methods.rb — Hash reference

# Creation
h = { carlos: 1, alicia: 2, sergio: 3 }
h = Hash.new(0)                  # default value for missing keys
count = Hash.new { |hash, key| hash[key] = 0 }  # default_proc

# Access
p h.fetch(:carlos)               # => 1
p h.fetch(:unknown, 'none')      # => 'none'
p h.fetch_values(:carlos, :unknown) { |k| "#{k}?" }
p h.key(3)                       # => :sergio
p h.keys                         # => [:carlos, :alicia, :sergio]
p h.values                       # => [1, 2, 3]
p h.key?(:carlos)                # => true
p h.value?(3)                    # => true

# Modifying
h.delete(:sergio)
h[:clara] = 4
h.merge!(daniele: 5)

# Iteration
h.each { |k, v| puts "#{k}: #{v}" }
h.each_key { |k| puts k }
h.each_value { |v| puts v }

# Filtering
p h.select { |k, v| v > 2 }
p h.reject { |k, v| v > 2 }

# Transformation
p h.transform_keys { |k| k.to_s.upcase }
p h.transform_values { |v| v * 2 }

# Merging
p h.merge(maria: 6)
p ({ a: 1, b: 2 }.merge({ b: 20, c: 30 }) { |k, o, n| o + n })  # => {a:1, b:22, c:30}

# Slice & Except
p h.slice(:carlos, :alicia)
p h.except(:carlos)

# Invert, Flatten, Compact, Sort
p h.invert                       # swap keys/values
p h.flatten                      # => [:carlos, 1, :alicia, 2, ...]
p h.compact                      # remove nil values
p h.sort                         # sort by key

# Dig (nested access)
nested = { user: { name: 'Carlos', address: { city: 'Madrid' } } }
p nested.dig(:user, :address, :city) # => "Madrid"
p nested.dig(:user, :phone)          # => nil

# Comparison
small = { a: 1, b: 2 }
big   = { a: 1, b: 2, c: 3 }
p small <= big   # => true (subset)
p small < big    # => true (proper subset)
p big >= small   # => true (superset)

# Other
temp = { x: 1, y: 2 }; temp.clear; p temp   # => {}
p h.size                                     # => 4
p h.empty?                                   # => false
p h.to_a                                     # convert to array of pairs
p h.assoc(:carlos)                           # => [:carlos, 1]
p h.rassoc(2)                                # => [:alicia, 2]
# identity hash: keys compared by object_id, not value
h = {}.compare_by_identity
h['hello'] = 1; h['hello'] = 2; p h          # => {"hello"=>1, "hello"=>2}

# Thinking in Ruby
#
# The Hash class offers a comprehensive API: fetch (with default/block),
# fetch_values, dig (nested access), slice, except, and even subset
# comparison with <=. Ruby's Hash is not just an associative array — it's
# a full data-structuring toolkit designed for real-world data
# manipulation.
