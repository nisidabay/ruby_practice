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

# Thinking in Ruby
#
# fork, spawn, and exec give you three different process-creation
# strategies: clone (fork), new (spawn), or replace (exec). fork runs
# a block in the child, spawn returns a PID immediately, and exec
# transforms the current process. Ruby exposes Unix process primitives
# directly — no wrappers, no abstractions, just the kernel API with
# Ruby's block syntax for the fork pattern.
