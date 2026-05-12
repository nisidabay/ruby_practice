#!/usr/bin/env ruby
# frozen_string_literal: true

# ==============================================================================
# RUBY PRACTICE GUIDE: FROM REFERENCE TO MASTERY
# ==============================================================================
# Methodology: One Problem -> One Solution -> One Key Insight
# Goal: Look at the challenge, understand the solution, put it into practice.

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
product = numbers.each_with_index.reduce(1) { |prod, (val, idx)| idx.even? ? prod * val : prod }
p product # 15 (1 * 3 * 5)
# Key Insight: `reduce` (or `inject`) is the power-tool for aggregation; always
# provide an initial value (1 for multiplication, 0 for addition).

# Challenge 3: Detect trends in sequential data (Sliding Window)
# Goal: Compare today's price with yesterday's price.
prices = [100, 105, 102, 110, 115]
prices.each_cons(2) do |yesterday, today|
  diff = today - yesterday
  puts "Trend: #{diff > 0 ? '📈' : '📉'} (#{diff})"
end
# Key Insight: `each_cons(n)` (consecutive) is the idiomatic way to implement sliding windows in Ruby.

# ------------------------------------------------------------------------------
# TOPIC: STRING & CHARACTER MANIPULATION
# ------------------------------------------------------------------------------

puts "\n--- Topic: String Mastery ---"

# Challenge 4: Efficiently count specific character classes
# Goal: Count all vowels in a sentence regardless of case.
sentence = 'Hello Ruby World'
count = sentence.downcase.count('aeiou')
p "Vowel Count: #{count}"
# Key Insight: `.count` accepts a string of characters or a regex; it's significantly faster than `.select` or `.grep` for simple counting.

# Challenge 5: Proper Emoji/Grapheme handling
# Goal: Iterate over characters that might be composed of multiple bytes (like emojis).
text = '👧🏽'
text.each_grapheme_cluster { |c| puts "Cluster: #{c} (Length: #{c.length} bytes)" }
# Key Insight: Use `each_grapheme_cluster` instead of `chars` when dealing with complex Unicode/Emojis to avoid splitting a single visual character into multiple pieces.

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
# Key Insight: Treat Hash keys as a Set. Using the subtraction operator (`-`) on arrays of keys is the cleanest way to find missing requirements.

# Challenge 7: Indexing and Labeling a Hash
# Goal: Print a numbered list of steps from a hash.
steps = { download: 'Get file', install: 'Run setup', launch: 'Start app' }
steps.each_with_index do |(step, desc), idx|
  puts "#{idx + 1}. #{step.capitalize}: #{desc}"
end
# Key Insight: Deconstruct pairs directly in the block arguments `|(step, desc)|` for maximum readability.

# ------------------------------------------------------------------------------
# TOPIC: FILE I/O (Surgical Implementation)
# ------------------------------------------------------------------------------

puts "\n--- Topic: File I/O ---"

# Challenge 8: Atomic Write-Read-Verify cycle
# Goal: Create a file, add data, and verify it line-by-line without leaving handles open.
fn = 'practice_test.txt'

# Write & Append (Surgical)
File.write(fn, "Line 1: Start\n")
File.open(fn, 'a') { |f| f.puts 'Line 2: End' }

# Efficient Reading
puts 'Verifying content:'
File.foreach(fn) { |line| puts "-> #{line.strip}" }

# Cleanup
File.delete(fn) if File.exist?(fn)
# Key Insight: `File.write` is for quick whole-file operations; `File.foreach` is mandatory for large files to avoid loading the entire content into RAM (Memory-efficient).
