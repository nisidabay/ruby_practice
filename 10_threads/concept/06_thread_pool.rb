#!/usr/bin/env ruby
# frozen_string_literal: true

# Mutex + ConditionVariable together: workers pull from a queue.

class ThreadPool
  def initialize(size)
    @mutex   = Mutex.new
    @cv      = ConditionVariable.new
    @queue   = []
    @alive   = true
    @workers = size.times.map { spawn_worker }
    sleep 0.01                     # let workers reach wait
  end

  def enqueue(&job)
    @mutex.synchronize { @queue << job; @cv.broadcast }
  end

  def stop
    @mutex.synchronize { @alive = false; @cv.broadcast }
    @workers.each(&:join)
  end

  private

  def spawn_worker
    Thread.new do
      loop do
        job = @mutex.synchronize do
          @cv.wait(@mutex) while @queue.empty? && @alive
          break :exit unless @alive
          @queue.shift
        end
        break if job == :exit
        job.call
      end
    end
  end
end

pool = ThreadPool.new(3)
10.times { |i| pool.enqueue { sleep 0.02; puts "job #{i} on ##{Thread.current.object_id % 100}" } }
sleep 0.25                       # let work finish
pool.stop
puts "done"

# Thinking in Ruby
#
# ThreadPool combines Mutex, ConditionVariable, and an array-backed queue
# to create a reusable worker pool. Workers wait on the condition variable
# until there's a job in the queue (#broadcast wakes them all, but only
# one gets the job). The shutdown logic (#enqueue :exit to each worker or
# set @alive = false + broadcast) is explicit and controllable. This raw
# implementation shows what's happening inside high-level thread pool gems
# — it's just Mutex + CV + Queue + a loop.
