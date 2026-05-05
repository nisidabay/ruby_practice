#!/usr/bin/env ruby
# frozen_string_literal: true

# strings_methods.rb — String method reference

# === Creation & Basics
puts 'Test' + 'Test'        # => TestTest
puts 'Test' * 3             # => TestTestTest
puts 'Test'.length          # => 4 (size is an alias)

# === Case
puts 'test'.capitalize      # => Test
puts 'test'.upcase          # => TEST
puts 'TEST'.downcase        # => test
puts 'TeSt'.swapcase        # => tEsT

# === Modification
puts 'Test'.reverse         # => tseT
puts 'Test'.chop            # => Tes (remove last char)
puts 'Test'.chomp           # => Test (remove trailing newline)
puts 'Test'.next            # => Tesu (succ is alias)
puts '  Test  '.strip       # => Test
puts '  Test  '.lstrip      # => Test  (left only)
puts '  Test  '.rstrip      # =>   Test (right only)

s = 'Test'
s.insert(0, '!')            # => !Test

# === Querying
p ''.empty?                 # => true
p 'Test'.empty?             # => false
p 'Test'.include?('es')     # => true
p 'Test'.start_with?('Te')  # => true
p 'Test'.end_with?('st')    # => true

# === Indexing
puts 'Test'[0]              # => T
puts 'Test'[-1]             # => t
puts 'Test'[0..1]           # => Te
puts 'Test'[0, 2]           # => Te (start, length)
p 'Test'.index('e')         # => 1
p 'Test'.rindex('t')        # => 3

# === Split & Join
p 'hello world'.split       # => ["hello", "world"]
p 'a,b,c'.split(',')        # => ["a", "b", "c"]
p 'Test'.chars              # => ["T", "e", "s", "t"]
p %w[a b c].join('-')       # => "a-b-c"

# === Iteration
'Test'.each_char { |c| print c.upcase } # => TEST
puts

# === Replacement
puts 'hello'.sub('l', 'L')          # => heLlo (first only)
puts 'hello'.gsub('l', 'L')         # => heLLo (all)
puts 'Test'.delete('t')             # => Tes
s = 'Test'; s.replace('New'); p s   # => "New"

# === Padding
puts 'Test'.center(10)              # => "   Test   "
puts 'Test'.ljust(10)               # => "Test      "
puts 'Test'.rjust(10)               # => "      Test"

# === Regex
p 'Test' =~ /e/                     # => 1 (index of match)
p 'Test'.match?(/e/)                # => true
p 'test test'.scan('t')             # => ["t", "t", "t"]

# === Comparison
p 'a' <=> 'b'                       # => -1
p 'Test'.casecmp('test')            # => 0 (case-insensitive)

# === Conversion
p '42'.to_i                         # => 42
p '3.14'.to_f                       # => 3.14
p 42.to_s                           # => "42"
p 'hello'.to_sym                    # => :hello
p :hello.to_s                       # => "hello"

# === Squeeze & Translate
puts 'aaabbbccc'.squeeze            # => abc
puts 'hello'.tr('el', 'ip')         # => hippo

# === Slice
s = 'Hello World'
puts s.slice(0, 5)                  # => Hello
puts s.slice!(0, 5); p s            # =>  World (destructive)

# === Partition
p 'hello world'.partition(' ')      # => ["hello", " ", "world"]

# === Misc
p 'hello'.bytes                     # => [104, 101, 108, 108, 111]
p 'A'.ord                           # => 65
p 65.chr                            # => "A"
p 'hello'.ascii_only?               # => true
