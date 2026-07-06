#!/usr/bin/env ruby
# frozen_string_literal: true

# 10_public_send_dynamic_calls.rb — send() calls methods by string/symbol

# WITHOUT send — hardcode method names, can't be dynamic:
#
#   if field == "host" then config.host
#   elsif field == "port" then config.port
#   # adds a branch every time you add a field
#
# WITH send — one call for any method name:

class Config
  attr_accessor :host, :port, :ssl

  def initialize
    @host = "localhost"
    @port = 5432
    @ssl  = true
  end
end

cfg = Config.new
%w[host port ssl].each do |field|
  puts "#{field} = #{cfg.send(field)}"
end

# public_send is safer — refuses private methods:
# cfg.public_send(:host)   # works
# cfg.public_send(:puts)   # NoMethodError — puts is private here

# Thinking in Ruby
#
# send bypasses the need for if/elsif chains when calling methods by
# name. public_send is the safe version — it respects method visibility.
# This is how dynamic dispatch works in Ruby: methods are just messages
# sent to objects, and the method name can be a runtime value.
