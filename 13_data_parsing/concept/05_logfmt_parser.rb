#!/usr/bin/env ruby
# frozen_string_literal: true

# 05_logfmt_parser.rb — 5-state FSM parser for logfmt format
# Parses "key=value key2=value2" lines into Ruby hashes.
# Demonstrates: state machines, String#each_char, type coercion.

module Logfmt
  # Parser with 5 states:
  #   GARBAGE (0) — skipping whitespace between pairs
  #   KEY     (1) — reading a key name
  #   EQUAL   (2) — saw '=', waiting for value
  #   IVALUE  (3) — reading an unquoted value
  #   QVALUE  (4) — reading a quoted value (handles escapes)
  module Parser
    GARBAGE = 0
    KEY     = 1
    EQUAL   = 2
    IVALUE  = 3
    QVALUE  = 4

    def self.integer?(str)
      str.to_s.match?(/\A[-+]?[0-9]+\Z/)
    end

    def self.numeric?(str)
      str.to_s.match?(/\A[-+]?[0-9]*\.?[0-9]+([eE][-+]?[0-9]+)?\Z/)
    end

    # Coerce a value string to Integer, Float, or keep as String.
    def self.coerce(value)
      if integer?(value)
        value.to_i
      elsif numeric?(value)
        value.to_f
      else
        value
      end
    end

    def self.parse(line)
      output = {}
      key   = +""
      value = +""
      escaped = false
      state = GARBAGE

      line.each_char do |char|
        case state
        when GARBAGE
          if char > " " && char != '"' && char != "="
            key = char
            state = KEY
          end

        when KEY
          if char > " " && char != '"' && char != "="
            key << char
          elsif char == "="
            output[key.strip] = true
            state = EQUAL
          else
            output[key.strip] = true
            state = GARBAGE
          end

        when EQUAL
          if char > " " && char != '"' && char != "="
            value = char
            state = IVALUE
          elsif char == '"'
            value = +""
            escaped = false
            state = QVALUE
          else
            state = GARBAGE
          end

        when IVALUE
          if char > " " && char != '"'
            value << char
          else
            output[key.strip] = coerce(value)
            state = GARBAGE
          end

        when QVALUE
          if char == '\\'
            escaped = true
          elsif char == '"' && !escaped
            output[key.strip] = value
            state = GARBAGE
          else
            escaped = false
            value << char
          end
        end
      end

      # Handle final state if line ends mid-parse
      if state == KEY
        output[key.strip] = true
      elsif state == IVALUE
        output[key.strip] = coerce(value)
      end

      output
    end
  end
end

# ── Demo ──
if __FILE__ == $PROGRAM_NAME
  test = 'name=app level=info active=true count=5 port=8080'
  result = Logfmt::Parser.parse(test)
  puts "Input:  #{test}"
  puts "Output: #{result.inspect}"
  puts "Types:  #{result.transform_values(&:class)}"

  # Parse from STDIN
  unless ARGV.empty?
    File.foreach(ARGV[0]) do |line|
      next if line.strip.empty? || line.start_with?("#")
      puts Logfmt::Parser.parse(line).inspect
    end
  end
end
