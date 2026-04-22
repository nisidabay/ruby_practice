#!/usr/bin/env ruby

# String Operations
# This file demonstrates string manipulation techniques.
# Shows interpolation, concatenation, and various string methods.

# ═══════════════════════════════════════════════════════════════════════════
# BASIC STRING OPERATIONS
# ═══════════════════════════════════════════════════════════════════════════

# Concatenation
puts 'Test' + 'Test' # Implicit concatenation

# Repetition
puts 'Test' * 3 # => "TestTestTest"

# Length methods (aliases)
puts 'Test'.length # => 4
puts 'Test'.size   # => 4 (alias for length)

# ─────────────────────────────────────────────────────────────────────────────
# CASE TRANSFORMATIONS
# ─────────────────────────────────────────────────────────────────────────────

puts 'Test'.capitalize  # => "Test"
puts 'test'.capitalize  # => "Test"
puts 'TEST'.downcase    # => "test"
puts 'test'.upcase      # => "TEST"
puts 'TeSt'.swapcase    # => "tEsT"

# ═══════════════════════════════════════════════════════════════════════════
# STRING MODIFICATION
# ═══════════════════════════════════════════════════════════════════════════

puts 'Test'.reverse     # => "tseT"
puts 'Test'.chop        # => "Tes" (removes last character)
puts 'Test'.chomp       # => "Test" (removes trailing newline if present)
puts 'Test'.next        # => "Tesu" (next in sequence)
puts 'Test'.succ        # => "Tesu" (alias for next)

# Method chaining
puts 'Test'.upcase.reverse # => "TSET"
puts 'Test'.upcase.reverse.next # => "TSEU"

# ─────────────────────────────────────────────────────────────────────────────
# WHITESPACE HANDLING
# ─────────────────────────────────────────────────────────────────────────────

puts '  Test  '.strip   # => "Test" (both sides)
puts '  Test  '.lstrip  # => "Test  " (left only)
puts '  Test  '.rstrip  # => "  Test" (right only)

# Insert
s = 'Test'
puts s.insert(0, '!')   # => "!Test"
s = 'Test'
puts s.insert(4, '!')   # => "Test!"

# ═══════════════════════════════════════════════════════════════════════════
# QUERY METHODS
# ═══════════════════════════════════════════════════════════════════════════

# Check if empty
p ''.empty?              # => true
p 'Test'.empty?          # => false

# Check if contains substring
p 'Test'.include?('es')  # => true
p 'Test'.include?('x')   # => false

# Check beginning/end
p 'Test'.start_with?('Te')  # => true
p 'Test'.end_with?('st')    # => true

# ─────────────────────────────────────────────────────────────────────────────
# INDEXING AND ACCESS
# ─────────────────────────────────────────────────────────────────────────────

# Get character by index
puts 'Test'[0]           # => "T"
puts 'Test'[1]           # => "e"
puts 'Test'[-1]          # => "t" (last character)

# Get substring by range
puts 'Test'[0..1]        # => "Te"
puts 'Test'[1..2]        # => "es"
puts 'Test'[0, 2]        # => "Te" (start position, length)

# Find index of substring
p 'Test'.index('e')      # => 1
p 'Test'.index('x')      # => nil
p 'Test'.rindex('t')     # => 3 (reverse index)

# ═══════════════════════════════════════════════════════════════════════════
# SPLITTING AND JOINING
# ═══════════════════════════════════════════════════════════════════════════

# Split string into array
p 'hello world'.split        # => ["hello", "world"]
p 'hello world'.split('o')   # => ["hell", " w", "rld"]
p 'a,b,c'.split(',')         # => ["a", "b", "c"]

# Characters to array
p 'Test'.chars # => ["T", "e", "s", "t"]

# Join array into string
p %w[a b c].join       # => "abc"
p %w[a b c].join('-')  # => "a-b-c"

# ─────────────────────────────────────────────────────────────────────────────
# CHARACTER ITERATION
# ─────────────────────────────────────────────────────────────────────────────

# Iterate over characters
'Test'.each_char { |c| print c.upcase } # => TEST
puts

# Iterate over bytes
'Test'.each_byte { |b| print b, ' ' } # => 84 101 115 116
puts

# Iterate over lines
"line1\nline2".each_line { |l| puts l }

# ═══════════════════════════════════════════════════════════════════════════
# REPLACEMENT
# ═══════════════════════════════════════════════════════════════════════════

# Substitution
puts 'hello'.sub('l', 'L')        # => "heLlo" (first occurrence)
puts 'hello'.gsub('l', 'L')       # => "heLLo" (all occurrences)
puts 'hello'.gsub('l', 'x')       # => "hexxo" (with regex)

# Delete characters
puts 'Test'.delete('t')           # => "Tes"
puts 'Test'.delete('Te')          # => "s" (deletes T and e)

# Replace entire string
s = 'Test'
s.replace('New')
puts s # => "New"

# Prepend and append
s = 'Test'
s.prepend('>>')                   # => ">>Test"
s << '!'                          # => ">>Test!"
s.concat(' end')                  # => ">>Test! end"
puts s

# ─────────────────────────────────────────────────────────────────────────────
# COUNTING
# ─────────────────────────────────────────────────────────────────────────────

# Count occurrences
puts 'Test'.count('t')            # => 1 (case-sensitive)
puts 'Test'.count('Tt')           # => 2 (counts T OR t)
puts 'Test'.sum                   # => checksum value (416)
puts 'Test'.each_byte.reduce(0) { |sum, v| sum + v } # => checksum value (416)

# ═══════════════════════════════════════════════════════════════════════════
# COMPARISON
# ═══════════════════════════════════════════════════════════════════════════

# Comparison operators
p 'a' <=> 'b'                     # => -1 (a comes before b)
p 'b' <=> 'a'                     # => 1 (b comes after a)
p 'a' <=> 'a'                     # => 0 (equal)
p 'A' == 'a'                      # => false (case-sensitive)
p 'a'.eql?('a')                   # => true

# Case-insensitive comparison
p 'Test'.casecmp('test') # => 0 (equal, case-insensitive)

# ═══════════════════════════════════════════════════════════════════════════
# CONVERSION
# ═══════════════════════════════════════════════════════════════════════════

# String to number
p '42'.to_i                       # => 42 (integer)
p '3.14'.to_f                     # => 3.14 (float)
p '42abc'.to_i                    # => 42 (stops at non-numeric)
p 'abc'.to_i                      # => 0 (no valid number)

# Number to string
p 42.to_s                         # => "42"
p 3.14.to_s                       # => "3.14"

# Other conversions
p :test                   # => :test (symbol)
p :test                   # => :test (alias for to_sym)

# ═══════════════════════════════════════════════════════════════════════════
# PADDING AND CENTERING
# ═══════════════════════════════════════════════════════════════════════════

puts 'Test'.center(10)            # => "   Test   "
puts 'Test'.center(10, '-')       # => "---Test---"
puts 'Test'.ljust(10)             # => "Test      "
puts 'Test'.rjust(10)             # => "      Test"

# ─────────────────────────────────────────────────────────────────────────────
# REGEX OPERATIONS
# ─────────────────────────────────────────────────────────────────────────────

# Match regex
p 'Test' =~ /e/                   # => 1 (index of match)
p 'Test' =~ /x/                   # => nil (no match)
p 'Test'.match(/e/)               # => #<MatchData "e">
p 'Test'.match?(/e/)              # => true

# Scan for all matches
p 'test test'.scan('t')           # => ["t", "t", "t"]
p 'test123'.scan(/\d/)            # => ["1", "2", "3"]

# ═══════════════════════════════════════════════════════════════════════════
# CLEAR AND FREEZE
# ═══════════════════════════════════════════════════════════════════════════

# Clear string (modifies in place)
s = 'Test'
s.clear
p s # => ""

# Encoding information
p 'Test'.encoding                 # => #<Encoding:UTF-8>
p 'Test'.bytes                    # => [84, 101, 115, 116]

# Freeze string (makes it immutable)
s = 'Test'
s.freeze
p s.frozen? # => true

# ═══════════════════════════════════════════════════════════════════════════
# ADDITIONAL CHARACTER MANIPULATION
# ═══════════════════════════════════════════════════════════════════════════

# Squeeze - removes duplicate adjacent characters
puts 'aaabbbccc'.squeeze                 # => "abc"
puts 'hellooo   world'.squeeze           # => "helo world"
puts 'aaabbbccc'.squeeze('a')            # => "abbbccc" (only squeeze 'a')
puts 'aaabbbccc'.squeeze('a-c')          # => "abc" (squeeze a through c)

# Tr (translate) - character substitution
puts 'hello'.tr('el', 'ip') # => "hippo"
puts 'hello'.tr('a-z', 'A-Z')           # => "HELLO"
puts 'hello'.tr('aeiou', '*')           # => "h*ll*"

# Tr with pairs
puts 'hello'.tr_s('el', 'ip') # => "hipo" (tr + squeeze)

# ─────────────────────────────────────────────────────────────────────────────
# SLICE AND SLICE!
# ─────────────────────────────────────────────────────────────────────────────

# Slice - extracts substring (non-destructive)
s = 'Hello World'
puts s.slice(0)                         # => "H"
puts s.slice(0, 5)                      # => "Hello"
puts s.slice(0..4)                      # => "Hello"
puts s.slice(/World/)                   # => "World"
puts s                                  # => "Hello World" (unchanged)

# Slice! - extracts and removes (destructive)
s = 'Hello World'
puts s.slice!(0, 5)                     # => "Hello"
p s                                     # => " World" (modified)

# ─────────────────────────────────────────────────────────────────────────────
# PARTITION AND RPARTITION
# ─────────────────────────────────────────────────────────────────────────────

# Partition - splits into 3 parts at first occurrence
p 'hello world'.partition(' ')          # => ["hello", " ", "world"]
p 'hello world'.partition('o')          # => ["hell", "o", " world"]
p 'hello'.partition('x')                # => ["hello", "", ""] (no match)

# Rpartition - splits at last occurrence
p 'hello world'.rpartition(' ')         # => ["hello", " ", "world"]
p 'hello world'.rpartition('o')         # => ["hello w", "o", "rld"]

# ═══════════════════════════════════════════════════════════════════════════
# ARRAY CONVERSIONS
# ═══════════════════════════════════════════════════════════════════════════

# Lines - returns array of lines
p "line1\nline2\nline3".lines # => ["line1\n", "line2\n", "line3"]
p "line1\nline2\nline3".lines("\n") # => ["line1\n", "line2\n", "line3"]

# Byteslice - byte-level slicing
puts 'hello'.byteslice(0)               # => "h"
puts 'hello'.byteslice(0, 3)            # => "hel"
puts 'hello'.byteslice(0..2)            # => "hel"

# Codepoints - returns array of Unicode codepoints
p 'hello'.codepoints                    # => [104, 101, 108, 108, 111]
p 'héllo'.codepoints                    # => [104, 233, 108, 108, 111]
p 'hello'.each_codepoint.to_a           # => [104, 101, 108, 108, 111]

# ─────────────────────────────────────────────────────────────────────────────
# ORD AND CHR
# ─────────────────────────────────────────────────────────────────────────────

# Ord - integer ordinal of first character
puts 'A'.ord                            # => 65
puts 'hello'.ord                        # => 104 (first char only)
puts 'é'.ord                            # => 233

# Chr - character from integer
puts 65.chr                             # => "A"
puts 97.chr                             # => "a"
puts 129_419.chr(Encoding::UTF_8) # => "🦋" (butterfly emoji)

# ═══════════════════════════════════════════════════════════════════════════
# SYMBOL CONVERSION
# ═══════════════════════════════════════════════════════════════════════════

# To_sym / Intern - convert to symbol
p :hello                        # => :hello
p :hello                        # => :hello (alias)

# Symbol to string
p :hello.to_s                           # => "hello"
p :hello.id2name                        # => "hello" (alias)

# ─────────────────────────────────────────────────────────────────────────────
# HASH AND ENCODING
# ─────────────────────────────────────────────────────────────────────────────

# Hash - hash value for string
p 'hello'.hash                          # => unique integer (consistent for same string)
p 'hello'.hash                          # => same value (in same session)

# Encoding checks
p 'hello'.ascii_only?                   # => true
p 'héllö'.ascii_only?                   # => false
p 'hello'.valid_encoding? # => true

# Force encoding
s = 'hello'
p s.encoding # => #<Encoding:UTF-8>
p s.force_encoding('ISO-8859-1').encoding # => #<Encoding:ISO-8859-1>

# Encode
p 'hello'.encode('UTF-8') # => "hello"
p 'hello'.encode Encoding::ISO_8859_1 # => "hello"

# ─────────────────────────────────────────────────────────────────────────────
# INSPECT AND DUMP
# ─────────────────────────────────────────────────────────────────────────────

# Inspect - debug representation
p 'hello'.inspect                       # => "\"hello\""
p 'hello world'.inspect                 # => "\"hello world\""
p "tab\there".inspect # => "\"tab\\there\""

# Dump - escaped debug representation
p 'hello'.dump                          # => "\"hello\""
p "tab\there".dump                      # => "\"tab\\there\""

# ─────────────────────────────────────────────────────────────────────────────
# UNPACK
# ─────────────────────────────────────────────────────────────────────────────

# Unpack - decode string into array
p 'ABC'.unpack('C*')                    # => [65, 66, 67] (bytes)
p 'hello'.unpack('c*')                  # => [104, 101, 108, 108, 111]
p '\x00\x01'.unpack('S')                # => little-endian short

# ═══════════════════════════════════════════════════════════════════════════
# DUPLICATION AND CLONING
# ═══════════════════════════════════════════════════════════════════════════

# Dup vs Clone
s = 'hello'
s_dup = s.dup                           # Shallow copy (no frozen state)
s_clone = s.clone                       # Shallow copy (with frozen state)
s.freeze
p s.frozen?                             # => true
p s_dup.frozen?                         # => false (dup doesn't copy freeze)
p s_clone.frozen?                       # => false (was frozen before clone)

frozen_s = 'test'.freeze
p frozen_s.dup.frozen?                  # => false
p frozen_s.clone.frozen?                # => true

# String multiplication alternative
p 'ab' * 3 # => "ababab"

# ─────────────────────────────────────────────────────────────────────────────
# MISCELLANEOUS
# ─────────────────────────────────────────────────────────────────────────────

# Try_convert (Safe type conversion)
p String.try_convert('hello')           # => "hello"
p String.try_convert(42)                # => nil (no implicit conversion)
p String.try_convert(nil)               # => nil

# Match with position
md = 'hello world'.match(/o/)
if md
  p md.begin(0)                         # => 4 (start of match)
  p md.end(0)                           # => 5 (end of match)
end

# Index with regex
p 'hello world'.index(/o/)              # => 4
p 'hello world'.index(/w/)              # => 6

# Rindex with regex
p 'hello world'.rindex(/o/) # => 7 (last occurrence)

# =~ operator returns position or nil
p 'hello' =~ /l/                        # => 2
p 'hello' =~ /z/                        # => nil

# !~ operator (not match)
p 'hello' !~ /z/                        # => true
p 'hello' !~ /h/                        # => false
