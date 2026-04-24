#!/usr/bin/env ruby
# frozen_string_literal: true

# Problem: You want to define a basic class that can be instantiated.
# Example: Creating Cookie objects to represent individual cookies.
#
# Solution: Define a class with a simple class definition.
# Visibility: All methods are public by default.

class Cookie
end

# Usage: Create instances of the class
def create_cookie
  Cookie.new
end

def multiple_cookies
  [Cookie.new, Cookie.new]
end

cookie = create_cookie
p cookie

cookies = multiple_cookies
p cookies

# This could also be done like this:
# Add an initialize method to set up state:
#
# class Cookie
#   def initialize(flavor)
#     @flavor = flavor
#   end
# end
#
# chocolate_chip = Cookie.new("Chocolate Chip")
