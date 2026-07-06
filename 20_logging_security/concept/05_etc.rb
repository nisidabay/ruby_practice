#!/usr/bin/env ruby
# frozen_string_literal: true

# Problem: You need system information — current user, home directory, system users.
# Example: A script that checks if it's running as root, or lists all system users.
#
# Solution: Etc (stdlib) — access to /etc/passwd, /etc/group, and system info.
# Visibility: `require 'etc'`. Read-only access to system user/group databases.

require 'etc'

# Current user
puts "Current user: #{Etc.getlogin}"
puts "UID: #{Process.uid}"
puts "Home: #{Dir.home}"

# Check if running as root
if Process.uid == 0
  puts 'WARNING: Running as root!'
else
  puts 'Running as normal user (safe)'
end

# Usage: Get a specific user by name
root = Etc.getpwnam('root')
puts "\nRoot: UID=#{root.uid}, GID=#{root.gid}, Shell=#{root.shell}"

# Usage: Get current user's full entry
me = Etc.getpwuid(Process.uid)
puts "Me: #{me.name}, #{me.gecos}, #{me.dir}"

# Usage: Iterate all users with a block (yields Passwd structs)
puts "\nSystem users (first 5):"
count = 0
Etc.passwd do |entry|
  break if count >= 5
  puts "  #{entry.name} (UID #{entry.uid}): #{entry.gecos} — #{entry.dir}"
  count += 1
end

# Usage: System groups with a block (yields Group structs)
puts "\nSystem groups (first 5):"
count = 0
Etc.group do |entry|
  break if count >= 5
  puts "  #{entry.name} (GID #{entry.gid}): #{entry.mem.join(', ')}"
  count += 1
end

# This could also be done like this:
# Without a block, Etc.passwd returns just usernames (strings):
#
#   Etc.passwd.take(5)  # => ["root", "bin", "daemon", ...]
#
# With a block, it yields full Passwd structs with name, uid, gid, etc.
#
# Thinking in Ruby
#
# The Etc library gives Ruby scripts direct access to the system's user and
# group databases — a capability that many higher-level languages hide behind
# platform-specific APIs. Ruby exposes /etc/passwd and /etc/group as iterable
# structs, making system administration scripts straightforward. This reflects
# Ruby's origins as a language for practical scripting: it doesn't abstract away
# the OS; it makes OS interaction more convenient.
