#!/usr/bin/env ruby
# frozen_string_literal: true

def create_car(model, convertible: false)
  puts "Created #{model}"
  puts "\tConvertible #{convertible}" if convertible
  puts '-'
end

create_car('sedan')
create_car('sports car', convertible: true)
create_car('minivan', convertible: false)

# Thinking in Ruby
#
# Ruby keyword arguments name parameters at the call site, eliminating
# positional-order bugs. Optional keywords with defaults let callers
# override only what they need — the definition side stays concise and
# the caller side stays self-documenting.
