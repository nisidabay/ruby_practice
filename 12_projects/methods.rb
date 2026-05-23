#!/usr/bin/env ruby
# frozen_string_literal: true

# methods.rb — splat (*) and default arguments eliminate boilerplate

# WITHOUT splat — fixed parameter list, fragile:
#
#   def config(host, port)
#     puts "Connecting to #{host}:#{port}"
#   end
#   config("db.internal", 5432)
#   # config("db.internal", 5432, "ssl")  => ArgumentError!
#
# WITH splat — any number of arguments, discover them inside:

def config(*args)
  puts "#{args.length} arguments: #{args.join(', ')}"
end

config("db.internal", 5432)
config("db.internal", 5432, "ssl", "timeout=5")

# WITHOUT defaults — callers must always pass every argument:
#
#   def bill(amount, tip)
#     amount + amount * tip
#   end
#   bill(20, 0.20)  # must repeat 0.20 every time
#
# WITH defaults — sensible values built in:

def bill(amount, tip = 0.20)
  amount + amount * tip
end

p bill(20, 0.05)  # => 21.0  (override)
p bill(20)        # => 24.0  (uses default 0.20)
