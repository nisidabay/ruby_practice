#!/usr/bin/env ruby
# frozen_string_literal: true

# between.rb — range check without two comparisons

# WITHOUT between? — two explicit comparisons:
#
#   temp = 98.6
#   normal = temp >= 97.0 && temp <= 99.0
#   # and again for every threshold check: disk_usage, latency, balance
#
# WITH between? — one method call:

p 98.6.between?(97.0, 99.0)    # => true  (normal body temp)
p 250.between?(200, 299)       # => true  (2xx HTTP success)
p 1500.between?(1000, 2000)    # => true  (budget range)
