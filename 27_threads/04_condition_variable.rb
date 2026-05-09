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
