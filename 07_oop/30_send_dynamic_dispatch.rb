#!/usr/bin/env ruby
# frozen_string_literal: true

# 30_send_dynamic_dispatch.rb — call methods by name at runtime
#
# WITHOUT send — you hardcode every method call:
#
#   case action
#   when "start"  then server.start
#   when "stop"   then server.stop
#   when "status" then server.status
#   end
#
# WITH send — call any method from a string or symbol:

class Server
  def start;   "Booting up...";    end
  def stop;    "Shutting down..."; end
  def status;  "Running — PID 4291"; end
  def restart; stop; start;        end
end

s = Server.new

# Public methods only (safe)
%w[start stop status].each do |action|
  puts "#{action}: #{s.public_send(action)}"
end
# => start: Booting up...
#    stop: Shutting down...
#    status: Running — PID 4291

# send calls ANY method including private — dangerous for user input
# public_send only calls public methods — use this for external input

# With arguments:
puts s.public_send(:status)  # no args

# Key difference: send vs public_send
#   send          — calls private/protected methods too (like internal dispatch)
#   public_send   — only public methods (safe for user-facing dispatch)
#
# This is how Rails routes: `controller.public_send(action_name)`
