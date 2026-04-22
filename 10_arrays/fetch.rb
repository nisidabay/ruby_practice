#!/usr/bin/env ruby
# frozen_string_literal: true
#
# Fetch
# This file contains Ruby code for fetch.

# Use of fetch, it allows a default value
# If the index in out of range throws and IndexError
names = %w[Alice Bob Peter]

p names.fetch(4, 'Charles')
# p names.fetch(4)  This will fail
p names[4]
