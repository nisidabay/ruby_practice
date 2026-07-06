#!/usr/bin/env ruby
# frozen_string_literal: true
# partition - split and array into two arrays based on matching/not matching
# a condition

foods = ["Steak", "Vegetables", "Steak Burger", "Kale", "Tofu", "Tuna Steaks"]
good_foods, bad_foods= foods.partition{ |food| food.include?("Steak")}
p good_foods
p bad_foods


# Thinking in Ruby
#
# partition splits a collection into two arrays in one pass — matching
# and non-matching. Where other languages require two separate filter
# calls (partition = [].select(&pred) + [].reject(&pred)), Ruby does it
# in a single enumeration with tuple assignment.
