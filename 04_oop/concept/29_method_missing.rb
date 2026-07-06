#!/usr/bin/env ruby
# frozen_string_literal: true

# 29_method_missing.rb — intercept calls to undefined methods
#
# WITHOUT method_missing — every method must exist at definition time:
#
#   class Report
#     def daily;  fetch("daily");  end
#     def weekly; fetch("weekly"); end
#     def monthly; fetch("monthly"); end  # 50 more...
#   end
#
# WITH method_missing — dynamic dispatch, no boilerplate:

class Report
  def method_missing(name, *args, &block)
    if name.to_s.start_with?("fetch_")
      period = name.to_s.sub("fetch_", "")
      puts "Fetching #{period} report..."
      "(#{period} data)"  # pretend API call
    else
      super  # raise NoMethodError — let Ruby handle it normally
    end
  end

  # ALWAYS pair with respond_to_missing? so respond_to? works correctly
  def respond_to_missing?(name, include_private = false)
    name.to_s.start_with?("fetch_") || super
  end
end

r = Report.new
puts r.fetch_daily      # => Fetching daily report... \n (daily data)
puts r.fetch_quarterly  # => Fetching quarterly report... \n (quarterly data)
puts r.respond_to?(:fetch_weekly)  # => true  (respond_to_missing? says yes)
puts r.respond_to?(:destroy)       # => false

# Without respond_to_missing?, respond_to? would return false even for
# fetch_weekly — invisible methods. With it, the object behaves normally.

# method_missing is how ActiveRecord's dynamic finders work:
#   User.find_by_email("...") → missing → extract "email" → build query

# Thinking in Ruby
#
# method_missing is Ruby's ultimate dynamic dispatch — intercept ANY
# method call and route it at runtime. The ALWAYS-required companion
# respond_to_missing? makes invisible methods visible to respond_to?.
# This is how ActiveRecord's find_by_email and friends work: Ruby's
# metaprogramming powers entire frameworks.
