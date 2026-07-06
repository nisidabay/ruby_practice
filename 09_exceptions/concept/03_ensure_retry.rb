#!/usr/bin/env ruby
# frozen_string_literal: true

# 03_ensure_retry.rb — ensure runs no matter what; retry reboots the begin block
#
# WITHOUT ensure — resources leak on failure:
#
#   def process_log(path)
#     f = File.open(path)
#     parse(f.read)
#     f.close       # never runs if parse raises!
#   end
#
# WITH ensure — cleanup always happens:

require "tempfile"

Tempfile.create(["transfer", ".log"]) do |tmp|
  tmp.write("txn_id: 4291\namount: 5000\n")
  tmp.rewind

  attempts = 0

  begin
    attempts += 1
    content = File.read(tmp.path)

    # Simulate intermittent failure
    if content.bytesize < 50 && attempts <= 2
      raise "Truncated read — retrying"
    end

    puts "Processed in #{attempts} attempt(s): #{content.chomp}"
  rescue => e
    puts "#{e.message} (attempt #{attempts})"
    retry  # jumps back to the top of 'begin' — re-reads the file
  ensure
    # ensure ALWAYS runs — even if rescue fires, even if there's a return
    puts "  [ensure: cleanup would go here — close handles, remove locks]"
  end
end
# => Truncated read — retrying (attempt 1)
#    [ensure: cleanup...]
# => Truncated read — retrying (attempt 2)
#    [ensure: cleanup...]
# => Processed in 3 attempt(s): txn_id: 4291\namount: 5000
#    [ensure: cleanup...]

# ensure also fires when there's NO exception — it's unconditional.
# retry: re-runs the begin block from the top. Useful for transient failures
# (network timeouts, locked files). Always put a counter so you don't loop forever.

# Thinking in Ruby
#
# ensure is Ruby's unconditional cleanup block — it runs whether the
# code succeeds, fails, or even hits a return statement. This makes it
# more reliable than Python's finally (same idea) in that ensure fires
# before the method returns the rescued value. retry is unique to Ruby —
# it jumps back to the beginning of the begin block, not the surrounding
# method. Always use a counter with retry to prevent infinite loops on
# persistent failures.
