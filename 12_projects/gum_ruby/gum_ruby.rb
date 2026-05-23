#!/usr/bin/env ruby
# frozen_string_literal: true
#
# Gum ruby
# This file contains Ruby code for gum ruby.

# gem install gum
require 'gum'

# Text input
Gum.input(placeholder: "What's your name?")

# Multi-line input
Gum.write(placeholder: 'Describe your project...', height: 5)

# Single / multi choice
Gum.choose('red', 'green', 'blue')
Gum.choose(%w[apple banana cherry], limit: 2, no_limit: true)

# Fuzzy filter
Gum.filter(Dir.glob('**/*.rb'), placeholder: 'Pick a file...')

# Confirm
if Gum.confirm('Delete everything?')
  Gum.spin('Deleting...') { system('deleting file') } # don't actually do this 🙂
end

# Spinner with block (super clean)
Gum.spin('Processing data...') do
  sleep 2
  # your code here
end

# Beautiful styled output
puts Gum.style('Success!', foreground: '82', bold: true, border: :rounded, padding: '0 2')
