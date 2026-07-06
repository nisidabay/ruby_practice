#!/usr/bin/env ruby
#
# !! Convert the return value to boolean
def ip_address?(str)
  !!(str =~ /^\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}$/)
end

p ip_address?('192.168.1.1')
p ip_address?('192.168.1')

# Thinking in Ruby
#
# The !! idiom converts any truthy/falsy value to a strict boolean. In
# this case, =~ returns an integer (position) or nil, and !! coerces it
# to true/false. Ruby never pretends nil is false — this conversion is
# explicit when you need a boolean contract.
