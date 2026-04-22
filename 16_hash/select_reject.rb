#!/usr/bin/env ruby
# select - build new hash by keeping key-value pairs based on a
# condition

# reject - build new hash by discarding key-value pairs based on
# a condition

recipe = { sugar: 3, flour: 10, salt: 1, peper: 8 }

# key, value
p(recipe.select { |_, teaspoon| teaspoon >= 5 })

p(recipe.reject { |_, teaspoon| teaspoon.even? })

# Convert the symbol to string before searching
p(recipe.reject { |ingredients, _teaspoon| ingredients.to_s.include?('s') })
