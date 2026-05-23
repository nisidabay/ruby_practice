#!/usr/bin/env ruby
# frozen_string_literal: true

# Thread#[] / Thread#[]= — "fiber-local" (Ruby < 3.4 inherited
# from parent fiber; Ruby 3.4+ each fiber gets its own stash).
#
# Thread#thread_variable_get/set — always thread-local (Fiber-safe).

t = Thread.new do
  Thread.current[:key]         = "fiber-local"
  Thread.current.thread_variable_set(:key, "thread-local")

  Fiber.new do
    # Ruby 3.4+: fiber-local doesn't leak across fibers.
    puts "fiber-local:  #{Thread.current[:key].inspect}"
    puts "thread-local: #{Thread.current.thread_variable_get(:key).inspect}"
  end.resume
end

t.join
