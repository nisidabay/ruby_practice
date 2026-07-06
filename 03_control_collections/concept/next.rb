#!/usr/bin/env ruby
# frozen_string_literal: true

# next.rb — skip this iteration, go to the next one

def healthy_endpoints(services)
  ok = []
  services.each do |name, status|
    next if status != 200  # skip unhealthy, don't add them
    ok << name
  end
  ok
end

services = [["api", 200], ["db", 500], ["cache", 200], ["queue", 503]]
p healthy_endpoints(services)  # => ["api", "cache"]

# Thinking in Ruby
#
# next skips the current iteration and proceeds to the next — Ruby's
# equivalent of continue, but it can also pass a value. In blocks used
# with map or select, next value becomes the element emitted for that
# iteration, giving fine-grained control over what the block produces.
