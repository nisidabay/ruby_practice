#!/usr/bin/env ruby
# frozen_string_literal: true

# Problem: You want to accept many optional parameters without a long parameter list.
# Example: Restaurant needs name, address, cuisine (required) plus optional head_chef, rating, menu.
#
# Solution: Use keyword arguments with defaults for optional params.
# Visibility: PUBLIC - all arguments are named at call site.

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

# Usage: Required args must be provided, optional use defaults
r1 = Restaurant.new(
  name: "La Casa",
  address: "123 Flavortown Street, NJ",
  cuisine: "Patriotic American",
  head_chef: "Guy Fieri",
  rating: 5,
  menu: { wings: 14.99 }
)
p r1

r2 = Restaurant.new(
  name: "Hell's Kitchen",
  address: "345 Las Vegas Boulevard, NV",
  cuisine: "British"
)
puts r2.head_chef  # "" (default)
puts r2.rating     # 3 (default)
puts r2.menu       # {} (default)

# This could also be done like this:
# Make all arguments optional with defaults:
#
# def initialize(name: nil, address: nil, cuisine: nil, head_chef: '', rating: 3, menu: {})
#   raise "name required" if name.nil?
#   @name = name
#   ...
# end
