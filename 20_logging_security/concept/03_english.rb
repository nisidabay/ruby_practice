#!/usr/bin/env ruby
# frozen_string_literal: true

# Problem: Ruby's global variables have cryptic names: $!, $?, $:, $0.
# Example: You see `$!` in code and have no idea what it means.
#
# Solution: English (stdlib) — gives readable aliases to all Ruby globals.
# Visibility: `require 'English'`. The aliases are constants, not methods.

require 'English'

# Without English — cryptic:
puts 'Without English:'
puts "  Last error: #{$!}"         # what?
puts "  Child status: #{$?}"       # what?
puts "  Load path: #{$:}"          # what?
puts "  Program name: #{$0}"       # what?

# With English — readable:
puts "\nWith English:"
puts "  Last error: #{$ERROR_INFO}"
puts "  Child status: #{$CHILD_STATUS}"
puts "  Load path: #{$LOAD_PATH}"
puts "  Program name: #{$PROGRAM_NAME}"

# Usage: Common English aliases
puts "\nCommon aliases:"
puts "  $!  → $ERROR_INFO       (last exception)"
puts "  $?  → $CHILD_STATUS      (last child exit status)"
puts "  $:  → $LOAD_PATH         (require search path)"
puts "  $0  → $PROGRAM_NAME      (script name)"
puts "  $$  → $PROCESS_ID         (PID)"
puts "  $/  → $INPUT_RECORD_SEPARATOR  (default: newline)"
puts "  $\\  → $OUTPUT_RECORD_SEPARATOR (default: nil)"

# This could also be done like this:
# Just use the English names from the start:
#
#   require 'English'
#   raise 'boom' rescue puts $ERROR_INFO.message
#
# No reason to use $! when $ERROR_INFO exists. English is stdlib —
# always available, zero cost.
#
# Thinking in Ruby
#
# The English library is a perfect example of Ruby's commitment to readability.
# Ruby's global variables ($!, $?, $:) are concise but cryptic — remnants of
# Perl's influence. The English module lets you alias them to self-documenting
# names without changing behavior. It's purely cosmetic, but cosmetic matters
# in a language where "code is read far more often than it is written."
