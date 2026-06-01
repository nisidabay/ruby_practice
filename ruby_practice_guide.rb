#!/usr/bin/env ruby
# frozen_string_literal: true

# ==============================================================================
# RUBY PRACTICE GUIDE: FROM REFERENCE TO MASTERY
# ==============================================================================
# Methodology: One Problem -> One Solution -> One Key Insight
# Goal: Look at the challenge, understand the solution, put it into practice.

require 'open3'
require 'pathname'

# ------------------------------------------------------------------------------
# TOPIC: COLLECTION LOGIC (Arrays & Enumerables)
# ------------------------------------------------------------------------------

puts "\n--- Topic: Collection Logic ---"

# Challenge 1: Transform and Filter data in one pipeline
# Goal: Take a list of words and extract only those longer than 7 chars, then
# uppercase them.
words = %w[spaghetti penne fettucine ziti lasagna ravioli cannelloni tagliatelle]
result = words.select { |w| w.length > 7 }.map(&:upcase)
p result
# Key Insight: `.map(&:method)` is a shorthand for `.map { |x| x.method }`. Use
# it for cleaner pipelines.

# Challenge 2: Calculate the product of elements at even indexes
# Goal: Efficiently aggregate values based on position.
numbers = [1, 2, 3, 4, 5, 6]
product = numbers.select.with_index { |_, idx| idx.even? }.reduce(1, :*)
p product # 15 (1 * 3 * 5)
# Key Insight: Separate filtering from aggregation. `.select.with_index` picks
# only the elements you care about. `.reduce` then combines them — clean and
# focused. Each step does one thing.

# Challenge 3: Detect trends in sequential data (Sliding Window)
# Goal: Compare today's price with yesterday's price.
prices = [100, 105, 102, 110, 115]
prices.each_cons(2) do |yesterday, today|
  diff = today - yesterday
  puts "Trend: #{diff > 0 ? '📈' : '📉'} (#{diff})"
end
# Key Insight: `each_cons(n)` (consecutive) is the idiomatic way to implement
# sliding windows in Ruby.

# ------------------------------------------------------------------------------
# TOPIC: STRING & CHARACTER MANIPULATION
# ------------------------------------------------------------------------------

puts "\n--- Topic: String Mastery ---"

# Challenge 4: Efficiently count specific character classes
# Goal: Count all vowels in a sentence regardless of case.
sentence = 'Hello Ruby World'
count = sentence.downcase.count('aeiou')
p "Vowel Count: #{count}"
# Key Insight: `.count` accepts a string representing a character set (e.g., 'a-z').
# It does NOT accept regex. It is significantly faster than `.select` or `.grep`
# for simple counting.

# Challenge 5: Proper Emoji/Grapheme handling
# Goal: Iterate over characters that might be composed of multiple bytes.
text = '👧🏽'
text.each_grapheme_cluster { |c| puts "Cluster: #{c} (Length: #{c.length} chars, #{c.bytesize} bytes)" }
# Key Insight: Use `each_grapheme_cluster` instead of `chars` for complex Unicode
# to avoid splitting visual characters. String#length returns character count,
# not byte count.

# ------------------------------------------------------------------------------
# TOPIC: HASH & SET OPERATIONS
# ------------------------------------------------------------------------------

puts "\n--- Topic: Hash Mastery ---"

# Challenge 6: Detect missing required configuration keys
# Goal: Ensure a config hash contains all necessary keys.
config = { debug: true, cache: false, logging: true }
required = %i[debug cache timeout]
missing = required - config.keys
p "Missing: #{missing}" if missing.any?
# Key Insight: Treat Hash keys as a Set. Array subtraction (`-`) is the cleanest
# way to find missing requirements.

# Challenge 7: Indexing and Labeling a Hash
# Goal: Print a numbered list of steps from a hash.
steps = { download: 'Get file', install: 'Run setup', launch: 'Start app' }
steps.each_with_index do |(step, desc), idx|
  puts "#{idx + 1}. #{step.capitalize}: #{desc}"
end
# Key Insight: Deconstruct pairs directly in the block arguments `|(step, desc)|`
# for maximum readability.

# ------------------------------------------------------------------------------
# TOPIC: FILE I/O (Surgical Implementation)
# ------------------------------------------------------------------------------

puts "\n--- Topic: File I/O ---"

# Challenge 8: Atomic Write-Read-Verify cycle
# Goal: Create a file, add data, and verify line-by-line without leaving handles open.
fn = 'practice_test.txt'

# Write & Append (Surgical)
File.write(fn, "Line 1: Start\n")
File.open(fn, 'a') { |f| f.puts 'Line 2: End' }

# Efficient Reading
puts 'Verifying content:'
File.foreach(fn) { |line| puts "-> #{line.strip}" }

# Cleanup
File.delete(fn) if File.exist?(fn)
# Key Insight: `File.write` is for quick whole-file operations; `File.foreach`
# is mandatory for large files to avoid loading the entire content into RAM.

# ------------------------------------------------------------------------------
# TOPIC: SYSTEM COMMANDS & SHELL EXECUTION
# ------------------------------------------------------------------------------

puts "\n--- Topic: Shell Execution ---"

# Challenge 9: Safely execute shell commands and handle failures
# Goal: Run a system command, capture the output, but don't silently fail if it crashes.
_, stderr, status = Open3.capture3('ls', '/nonexistent')
puts "Command failed (as expected): #{stderr.strip}" unless status.success?
# Key Insight: `Open3.capture3` gives you three things: stdout, stderr, and
# the exit status. You can check `status.success?` before trusting the output —
# that's what makes it safe for production scripts.

# ------------------------------------------------------------------------------
# TOPIC: PATH MANIPULATION (Pathname)
# ------------------------------------------------------------------------------

puts "\n--- Topic: Path Manipulation ---"

# Challenge 10: Navigate and manipulate the filesystem without string concatenation
# Goal: Find a config file relative to the current script's location.
script_dir = Pathname.new(__dir__)
config_file = script_dir.parent.join('config.yml')

puts "Looking for config at: #{config_file}"
# Key Insight: `Pathname` wraps File, Dir, and IO into a single object-oriented
# interface. Always `require 'pathname'` instead of using `File.join`.

# ------------------------------------------------------------------------------
# TOPIC: CLI INPUT (ARGF)
# ------------------------------------------------------------------------------

puts "\n--- Topic: CLI Input ---"

# Challenge 11: Write a script that acts like a standard UNIX tool (grep, cat)
# Goal: Accept input from a piped command OR a file argument.
#
# Simulate a file argument by writing a temp file to ARGV.
temp = 'guide_argh_demo.txt'
File.write(temp, "ALPHA\nbeta\n  GAMMA  \n")
ARGV.replace([temp])

puts 'ARGF reading from file argument:'
ARGF.each_line do |line|
  next if line.strip.empty?
  puts "  Processed: #{line.strip.upcase}"
end

ARGV.clear # Don't interfere with later requires
File.delete(temp)
# Key Insight: `ARGF` is a stream designed for CLI tools. It automatically reads
# from STDIN if data is piped, or from files passed in ARGV. Both paths use the
# same `each_line` call — your logic doesn't change.

# ------------------------------------------------------------------------------
# TOPIC: ERROR RECOVERY
# ------------------------------------------------------------------------------

puts "\n--- Topic: Error Recovery ---"

# Challenge 12: Handle flaky external resources (APIs, network drives)
# Goal: Attempt an operation and retry automatically up to 3 times before failing.
retries = 0
begin
  # Simulate flaky call
  raise 'Network timeout' if retries < 2

  puts 'Operation Success!'
rescue RuntimeError => e
  if (retries += 1) <= 3
    puts "Attempt #{retries} failed (#{e.message}). Retrying..."
    retry
  else
    puts 'Operation failed completely after 3 retries.'
    raise # Re-raise to kill the script
  end
end
# Key Insight: `retry` jumps back to the `begin` block. You must maintain a
# counter, otherwise a persistent failure causes an infinite loop.
