#!/usr/bin/env ruby
# frozen_string_literal: true

# 02_spawn_vs_exec.rb — spawn (background) vs exec (replace yourself)
#
# fork + exec is how Unix creates processes. Ruby wraps both.
# exec: the current Ruby process BECOMES the command — Ruby is gone.
# spawn: launches a new process in the background — Ruby keeps running.

# ── exec ──
# exec replaces the Ruby process entirely. Anything after exec never runs.
puts "=== exec (commented out — would kill this script) ==="
# exec("echo", "I'm echo now, Ruby is gone")
# puts "This will NEVER print"  # dead code

# ── spawn ──
# spawn returns a PID immediately. The child runs in parallel.
puts "\n=== spawn ==="
pid = spawn("sleep", "1")       # fire and forget
puts "Spawned PID: #{pid}"
puts "Ruby keeps running while sleep ticks..."

# Wait for the child to finish
Process.wait(pid)
puts "Child #{pid} finished (exit: #{$?.exitstatus})"

# spawn with output capture
reader, writer = IO.pipe
pid = spawn("echo", "Hello from child", out: writer)
writer.close                     # close write end so reader gets EOF
output = reader.read.chomp
reader.close
Process.wait(pid)
puts "Child said: #{output.inspect}"

# Key differences:
#   exec  — replaces this process (no return, Ruby ceases to exist)
#   spawn — creates a NEW process, returns PID, Ruby continues
#   fork  — clones this Ruby process (see 03_fork.rb)
