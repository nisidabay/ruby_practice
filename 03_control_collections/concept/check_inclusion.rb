#!/usr/bin/env ruby
# frozen_string_literal: true

# check_inclusion.rb — hash membership: key? + value? + include?

config = {host: "db.internal", port: 5432, ssl: true}

p config.key?(:port)       # => true   (check key)
p config.key?(:password)   # => false  (missing key)
p config.value?(5432)      # => true   (check value)
p config.value?("admin")   # => false  (wrong password)
p config.include?(:ssl)    # => true   (alias for key?)

# Thinking in Ruby
#
# Hash membership is tri-directional: key?, value?, and include? (alias
# for key?). Ruby's consistent predicate naming (? suffix for booleans)
# and dual-access philosophy (do you care about the key or the value?)
# reflect its design priority: make the programmer's intent match the
# API.
