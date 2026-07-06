#!/usr/bin/env ruby
# frozen_string_literal: true

# ConditionVariable lets threads wait until another thread
# signals that a condition is met. Always paired with a Mutex.

mutex   = Mutex.new
cv      = ConditionVariable.new
payload = nil

# Consumer: waits for the producer to drop data.
consumer = Thread.new do
  mutex.synchronize do
    puts "consumer waiting..."
    cv.wait(mutex)           # releases mutex, sleeps until signal
    puts "consumer got: #{payload}"
  end
end

# Producer: does some work, then signals.
Thread.new do
  sleep 0.2
  mutex.synchronize do
    payload = "ready!"
    puts "producer signaling..."
    cv.signal                # wakes ONE waiter (use #broadcast for all)
  end
end

consumer.join

# Thinking in Ruby
#
# ConditionVariable implements the "wait/signal" pattern that's fundamental
# to threaded programming. A thread waits on a condition (releasing the
# mutex temporarily), and another thread signals when the condition is met.
# The waiting thread re-acquires the mutex and continues. This is more
# efficient than busy-waiting (polling in a loop). cv.signal wakes one
# waiter; cv.broadcast wakes all. Always pair ConditionVariable with a
# Mutex — they're designed to work together.
