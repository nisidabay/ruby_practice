#!/usr/bin/env ruby
# frozen_string_literal: true

# 03_fork_spawn_exec.rb — fork (clone), spawn (new process), exec (replace)
puts "Parent PID: #{Process.pid}"

# spawn: new process, parent continues
spawn_pid = spawn("echo 'spawned child'")
Process.wait(spawn_pid)

# fork: copy process, both run from here
fork_pid = fork do
  puts "Child PID: #{Process.pid} (forked)"
  exit 0
end
Process.wait(fork_pid)

puts "Spawned: #{spawn_pid}, Forked: #{fork_pid}"
