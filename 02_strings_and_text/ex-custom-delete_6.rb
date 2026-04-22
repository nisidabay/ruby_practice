#!/usr/bin/env ruby
# Define a custom_delete method that accepts a text string and
# a string of deletion characters. The method should build up
# a new string consisting of only characters that are NOT found
# among the deletion characters. Do not use the built-in
# delete method in your solution.
#
# Examples:
# The => indicates the expected return value
# custom_delete("cottage cheese", "c")     => "ottage heese"
# custom_delete("cottage cheese", "e")     => "cottag chs"
# custom_delete("cottage cheese", "ce")    => "ottag hs"
# custom_delete("cottage cheese", "ec")    => "ottag hs"
# custom_delete("cottage cheese", "")      => "cottage cheese"

def custom_delete(text, letters)
  return text if letters.empty?

  new_string = ''
  text.each_char do |ch|
    new_string << ch unless letters.include?(ch)
  end
  new_string
end

p custom_delete('cottage cheese', 'c')
p custom_delete('cottage cheese', 'e')
p custom_delete('cottage cheese', 'ce')
p custom_delete('cottage cheese', 'ec')
p custom_delete('cottage cheese', '')
