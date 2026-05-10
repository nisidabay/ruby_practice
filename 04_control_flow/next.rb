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
