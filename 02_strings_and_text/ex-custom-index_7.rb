#!/usr/bin/env ruby
# frozen_string_literal: true

# ex-custom-index_7.rb — find first index of substring

def custom_index(text, search)
  return nil if search.empty?

  text.each_char.with_index do |_, i|
    return i if text[i, search.size] == search
  end
  nil
end

p custom_index('I am very handsome', 'I')    # => 0
p custom_index('I am very handsome', 'e')    # => 6
p custom_index('I am very handsome', 'Z')    # => nil
p custom_index('I am very handsome', 'am')   # => 2
p custom_index('I am very handsome', 'ma')   # => nil
