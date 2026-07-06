#!/usr/bin/env ruby
# frozen_string_literal: true

# define_class_cookie.rb — simplest possible class

class Cookie
end

p Cookie.new       # => #<Cookie:0x...>
p [Cookie.new, Cookie.new]  # => array of Cookie instances


# Thinking in Ruby
#
# The simplest possible Ruby class — an empty class body is valid. Even
# without any methods, Cookie.new works because all Ruby objects inherit
# from Object (which includes Kernel). This is the minimal expression of
# "everything is an object" — even an empty class produces real instances.
