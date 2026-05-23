#!/usr/bin/env ruby
# frozen_string_literal: true

# check_inclusion.rb — hash membership: key? + value? + include?

config = {host: "db.internal", port: 5432, ssl: true}

p config.key?(:port)       # => true   (check key)
p config.key?(:password)   # => false  (missing key)
p config.value?(5432)      # => true   (check value)
p config.value?("admin")   # => false  (wrong password)
p config.include?(:ssl)    # => true   (alias for key?)
