#!/usr/bin/env ruby
# frozen_string_literal: true

# the_inequality_operator.rb — != checks "not equal to"

# WITHOUT != — negate ==, more typing, harder to read:
#
#   !(user == "root")   # double negative: "not (user equals root)"
#
# WITH != — reads like English:

p "admin" != "root"     # => true  (restricted user)
p "root" != "root"      # => false (this IS the superuser)
p 401 != 200            # => true  (not a success code)
p "200" != 200          # => true  (string vs integer — different types)
