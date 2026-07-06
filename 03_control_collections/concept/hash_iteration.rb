#!/usr/bin/env ruby
#
# each        - Iterate over each key-value pair
# each_key    - Iterate over each key
# each_value  - Iterate over each value
# keys        - Return array of hash's keys
# values      - Return array of hash's values

salaries = { director: 10_000, producer: 20_000, ceo: 30_000}

salaries.each { |position, salary| puts "The #{position} earns #{salary}"}
salaries.each_key {|position| puts "The next position is #{position}"}
salaries.each_value {|salary| puts "The next employee earns #{salary}"}
p salaries.keys
p salaries.values



# Thinking in Ruby
#
# Hash iteration is dual-channel — each_key, each_value, and each (which
# yields key-value pairs as a two-element block parameter). This
# separation makes intent explicit: iterating over keys only? each_key.
# Need both? each with two block parameters. Ruby's block destructuring
# makes this natural.
