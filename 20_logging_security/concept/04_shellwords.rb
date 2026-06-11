#!/usr/bin/env ruby
# frozen_string_literal: true

# Problem: Building shell commands from user input is dangerous — spaces, quotes, special chars.
# Example: A filename like `my file; rm -rf /` breaks your script if not escaped.
#
# Solution: Shellwords (stdlib) — safely escape and join shell arguments.
# Visibility: `require 'shellwords'`. Shellwords.shelljoin is the safe alternative to string interpolation.

require 'shellwords'

# DANGEROUS — string interpolation:
filename = 'my file; rm -rf /'
dangerous = "ls #{filename}"
puts "Dangerous: #{dangerous}"
# => ls my file; rm -rf /  (would execute rm!)

# SAFE — Shellwords.shellescape:
safe = "ls #{Shellwords.shellescape(filename)}"
puts "Safe: #{safe}"
# => ls my\ file\;\ rm\ -\rf\ /  (treated as one filename)

# Usage: Build a full command from parts
command = ['find', '/tmp', '-name', '*.log', '-mtime', '+7']
puts Shellwords.shelljoin(command)
# => find /tmp -name \*.log -mtime \+7

# Usage: Parse a command string back into arguments
args = Shellwords.shellsplit("ls -la 'My Documents'")
puts args.inspect  # => ["ls", "-la", "My Documents"]

# This could also be done like this:
# Open3.capture3 with array args (also safe, no shell):
#
#   Open3.capture3('ls', filename)  # filename is one arg, never parsed by shell
#
# Shellwords is for when you MUST build a shell command string.
# Open3 with array args is safer when you can avoid the shell entirely.
