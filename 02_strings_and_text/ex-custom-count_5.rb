#!/usr/bin/env ruby

# Define a custom_count method that accepts a string and a string
# of search characters. The method should count how many times the
# search characters appear in the original string. Do not use the
# built-in count method in your solution.
#
# Examples:
# The => indicates the expected return value
# custom_count("Hello World", "l")     => 3
# custom_count("Hello World", "O")     => 0
# custom_count("Hello World", "z")     => 0
# custom_count("Hello World", "lo")    => 5
# custom_count("Hello World", "ol")    => 5
#
def custom_count_extended(text, chars_to_count)
  counter = 0
  text.each_char do |t|
    chars_to_count.each_char do |c|
      counter += 1 if c == t
    end
  end
  counter
end

def custom_count(text, chars_to_count)
  counter = 0
  text.each_char { |char| counter += 1 if chars_to_count.include?(char) }
  counter
end

p custom_count_extended('Hello World', 'l')
p custom_count_extended('Hello World', 'O')
p custom_count_extended('Hello World', 'z')
p custom_count_extended('Hello World', 'lo')
p custom_count_extended('Hello World', 'ol')

p custom_count('Hello World', 'l')
p custom_count('Hello World', 'O')
p custom_count('Hello World', 'z')
p custom_count('Hello World', 'lo')
p custom_count('Hello World', 'ol')
