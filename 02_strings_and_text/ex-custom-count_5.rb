#!/usr/bin/env ruby
# frozen_string_literal: true

# ex-custom-count_5.rb — count matching characters

def custom_count(text, chars_to_count)
  text.each_char.count { |char| chars_to_count.include?(char) }
end

p custom_count('Hello World', 'l')    # => 3
p custom_count('Hello World', 'O')    # => 0
p custom_count('Hello World', 'z')    # => 0
p custom_count('Hello World', 'lo')   # => 5
p custom_count('Hello World', 'ol')   # => 5
