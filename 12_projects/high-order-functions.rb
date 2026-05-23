#!/usr/bin/env ruby
# frozen_string_literal: true

# high-order-functions.rb — lambdas let you pass logic around like data

# WITHOUT lambdas — duplicate the filtering logic everywhere:
#
#   active = orders.select { |o| o[:status] == :active }
#   # ... later, same check scattered across 5 places in the codebase
#
# WITH lambdas — define the check once, reuse:

active = ->(order) { order[:status] == :active }

orders = [
  {id: 1, status: :active},
  {id: 2, status: :cancelled},
  {id: 3, status: :active},
]

p orders.select(&active)  # => [{id:1,...}, {id:3,...}]
