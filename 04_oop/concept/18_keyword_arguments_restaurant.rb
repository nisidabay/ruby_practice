#!/usr/bin/env ruby
# frozen_string_literal: true

# keyword_arguments_restaurant.rb — keyword args with defaults

class Restaurant
  attr_reader :name, :address, :cuisine, :head_chef, :rating, :menu

  def initialize(name:, address:, cuisine:, head_chef: '', rating: 3, menu: {})
    @name = name
    @address = address
    @cuisine = cuisine
    @head_chef = head_chef
    @rating = rating
    @menu = menu
  end
end

r1 = Restaurant.new(
  name: "La Casa", address: "123 Flavortown St",
  cuisine: "American", head_chef: "Guy Fieri",
  rating: 5, menu: { wings: 14.99 }
)
p r1

r2 = Restaurant.new(name: "Hell's Kitchen", address: "345 LV Blvd", cuisine: "British")
puts r2.head_chef  # => "" (default)
puts r2.rating     # => 3 (default)


# Thinking in Ruby
#
# Keyword arguments make object initialization self-documenting — at the
# call site, each value is labeled. Required keywords (name:, address:)
# enforce completeness at parse time, while optional keywords with
# defaults (rating: 3) handle the common case concisely. This is Ruby's
# answer to the "builder pattern" without the boilerplate.
