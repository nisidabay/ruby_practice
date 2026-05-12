#!/usr/bin/env ruby
# frozen_string_literal: true

# strings_methods.rb — REFERENCE: quick lookup, not a concept file
# See 05_methods/include.rb for the include? AHA.

# Creation & Basics
puts 'Ruby' + 'Lang'                     # => RubyLang
puts 'Go' * 3                            # => GoGoGo

# Case
puts 'carlos'.capitalize                 # => Carlos
puts 'LOG'.downcase                      # => log

# Modification (non-destructive by default — returns new string)
puts 'desrever'.reverse                  # => reversed
puts ' hello '.strip                     # => hello

# Querying
p ''.empty?                              # => true
p '/admin'.start_with?('/')              # => true
p 'file.rb'.end_with?('.rb')             # => true

# Indexing (returns character or substring — never nil)
puts 'Ruby'[0]                           # => R
puts 'Ruby'[-1]                          # => y
puts 'Ruby'[0..1]                        # => Ru

# Split & Join (the two you'll use most)
p 'a,b,c'.split(',')                     # => ["a", "b", "c"]
p %w[a b c].join('-')                    # => "a-b-c"

# Substitution
puts 'hello'.sub('l', 'L')               # => heLlo (first only)
puts 'hello'.gsub('l', 'L')              # => heLLo (all)

# Regex
p 'user@domain.com'.match?(/@/) # => true

# Conversion
p '42'.to_i                              # => 42
p :status.to_s                           # => "status"
p :status # => :status
