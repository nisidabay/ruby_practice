#!/usr/bin/env ruby
# frozen_string_literal: true

# Problem: Run async I/O without callbacks or threads — pause and resume around blocking operations.
# Example: Read from two files concurrently without spawning threads.
#
# Solution: Fiber Scheduler (Ruby 3.0+) — hooks into IO operations, auto-yields on block.
# Visibility: Requires a scheduler implementation. Ruby provides the interface, not the scheduler.
# NOTE: This file demonstrates the CONCEPT. A full async framework (like Async gem) implements it.

# The Fiber Scheduler interface (what Ruby expects):
puts 'Fiber Scheduler interface (Ruby 3.0+):'
puts <<~INTERFACE
  # Ruby calls these hooks on your scheduler:
  #   io_wait(io, events, timeout)  — called when IO would block
  #   kernel_sleep(duration)        — called by sleep()
  #   process_wait(pid, flags)      — called by Process.wait
  #   timeout_after(duration, &block) — called by Timeout.timeout

  # A minimal scheduler (conceptual):
  class MinimalScheduler
    def io_wait(io, events, timeout)
      # Instead of blocking, register this fiber for later
      # and switch to another ready fiber
    end

    def kernel_sleep(duration)
      # Same — don't block, switch fibers
    end
  end
INTERFACE

# Usage: How it works (conceptual)
puts "\nWithout scheduler:"
puts "  File.read('/dev/urandom')  # blocks the whole thread"

puts "\nWith scheduler:"
puts "  Fiber.set_scheduler(MinimalScheduler.new)"
puts "  Fiber.schedule do"
puts "    File.read('/dev/urandom')  # scheduler intercepts, switches fibers"
puts "  end"

# This could also be done like this:
# Threads — preemptive, OS-managed, more overhead:
#
#   Thread.new { File.read('/dev/urandom') }
#
# Fibers + Scheduler — cooperative, user-managed, less overhead.
# The Async gem (https://github.com/socketry/async) is the most popular
# Fiber Scheduler implementation.
