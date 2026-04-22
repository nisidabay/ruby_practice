#!/usr/bin/env ruby
#
# !! Convert the return value to boolean
def ip_address?(str)
  !!(str =~ 
/^\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}$/)
end

p ip_address?("192.168.1.1")
p ip_address?("192.168.1")
