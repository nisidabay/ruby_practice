#!/usr/bin/env ruby
# frozen_string_literal: true

# define_class_cookie.rb — simplest possible class

class Cookie
end

p Cookie.new       # => #<Cookie:0x...>
p [Cookie.new, Cookie.new]  # => array of Cookie instances

