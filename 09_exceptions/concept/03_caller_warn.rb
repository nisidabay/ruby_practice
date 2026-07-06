#!/usr/bin/env ruby
# frozen_string_literal: true

# 03_caller_warn.rb — caller: who called me? warn: errors to stderr
#
# WITHOUT caller — mystery about execution path:
#
#   def validate(data)
#     raise "invalid"  # stack trace shows it, but you can't inspect it programmatically
#   end
#
# WITH caller — get the call stack as an array of strings:

def authenticate(token)
  puts "authenticate called from:"
  # caller returns [file:line:in `method', ...] — first entry is OUR caller
  puts "  #{caller.first}"
end

def handle_request
  authenticate("abc123")
end

handle_request
# => authenticate called from:
#    03_caller_warn.rb:19:in `handle_request'

# caller(0) includes THIS method. caller(1) starts at OUR caller (default).
# caller_locations returns Thread::Backtrace::Location objects — structured access.

puts "\nFull stack:"
caller_locations.each do |loc|
  puts "  #{File.basename(loc.path)}:#{loc.lineno} in `#{loc.label}'"
end

# ── warn: write to stderr without raising ──
def deploy_config(path)
  unless File.exist?(path)
    warn "WARNING: #{path} not found, using defaults"  # goes to stderr
    return {host: "localhost"}
  end
  {host: File.read(path).chomp}
end

config = deploy_config("/tmp/nonexistent.yml")
puts "Config: #{config}"  # still runs — warn doesn't stop execution

# caller: inspect the stack programmatically (logging, debugging, metrics)
# warn:  non-fatal error messages to stderr (won't halt the program)
# raise: fatal — stops execution unless rescued

# Thinking in Ruby
#
# caller and caller_locations give Ruby programs X-ray vision into the
# call stack. caller returns strings, caller_locations returns structured
# objects with path, lineno, and label — no regex needed. warn writes to
# stderr without raising (unlike puts which goes to stdout). These three
# tools — caller (inspect), warn (inform), raise (abort) — give you a
# complete debugging toolkit without external dependencies.
