#!/usr/bin/env ruby
# Define a custom_index method that accepts a string and a search term.
# The method should return the first index position of the
# search term within the string. If the search term does not exist,
# return nil. Do not use the built-in index method in your solution.
#
# Examples:
# The => indicates the expected return value
# custom_index("I am very handsome", "I")     => 0
# custom_index("I am very handsome", "e")     => 6
# custom_index("I am very handsome", "Z")     => nil
# custom_index("I am very handsome", "am")    => 2
# custom_index("I am very handsome", "ma")    => nil

# def custom_index(text, search)
#   return nil if search.empty?
#
#   search_length = search.length
#   text_length = text.length
#
#   i = 0
#   while i <= text_length - search_length
#     if text[i, search_length] == search
#       return i
#     end
#
#     i += 1
#   end
#
#   nil
# end

# Short version
def custom_index(text, search)
  search_length = search.size

  return nil if search.empty?

  text.each_char.with_index do |_char, index|
    return index if text[index, search_length].include?(search)
  end
  nil
end

p custom_index('I am very handsome', 'I')
p custom_index('I am very handsome', 'e')
p custom_index('I am very handsome', 'Z')
p custom_index('I am very handsome', 'am')
p custom_index('I am very handsome', 'ma')
