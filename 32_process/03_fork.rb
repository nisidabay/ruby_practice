#!/usr/bin/env ruby
# frozen_string_literal: true

# 03_fork.rb — fork: copy the Ruby process, run code in the child
#
# fork is how you do parallelism without threads. It clones the CURRENT process.
# The child gets a copy of all variables, file descriptors, and memory.
#
# WITHOUT fork — sequential, one thing at a time:
#
#   process_log("access.log")   # 5 seconds
#   process_log("error.log")    # 5 seconds   → 10 seconds total
#
# WITH fork — both run in parallel:
#
#   fork { process_log("access.log") }
#   process_log("error.log")     → 5 seconds total

puts "Parent PID: #{Process.pid}"

# fork returns: nil in the child, the child's PID in the parent
child_pid = fork do
  # This block runs in the CHILD process
  puts "  Child: PID=#{Process.pid}, parent=#{Process.ppid}"
  sleep 0.5
  puts "  Child: done with work"
end

# fork returned the child's PID (not nil), so this is the PARENT
puts "Parent: spawned child PID=#{child_pid}"

# Wait for the child to finish
pid, status = Process.waitpid2(child_pid)
puts "Parent: child #{pid} exited with status #{status.exitstatus}"

# fork doesn't share memory — changes in the child don't affect the parent:
counter = 0
fork do
  counter = 99
  puts "  Child counter: #{counter}"  # => 99
end
Process.wait
puts "Parent counter: #{counter}"     # => 0 (unchanged)

# fork returns the child's PID to the parent and nil to the child.
# The block only runs in the child (pid == nil).
# This is Unix's copy-on-write — fast and isolated.
