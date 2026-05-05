#!/usr/bin/env ruby
# frozen_string_literal: true

# exercises.rb — array transformation exercises

def double_elements(values)
  values.map { |v| v * 2 }
end

p double_elements([1, 2, 3, 4, 5])  # => [2, 4, 6, 8, 10]
p double_elements([10, 20, 30])     # => [20, 40, 60]

def extract_long_words(words)
  words.select { |w| w.length > 7 }
end

p extract_long_words(%w[spaghetti penne fettuccine ziti])         # => ["spaghetti", "fettuccine"]
p extract_long_words(%w[lasagna ravioli cannelloni tagliatelle])  # => ["cannelloni", "tagliatelle"]

def pastas_and_sauces(pastas, sauces)
  pastas.product(sauces).map { |p, s| "#{p.capitalize} with #{s.capitalize} sauce" }
end

p pastas_and_sauces(%w[fettucine spaghetti penne], %w[alfredo bolognese pesto])
