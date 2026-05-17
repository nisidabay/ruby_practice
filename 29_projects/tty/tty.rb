#!/usr/bin/env ruby
# frozen_string_literal: true
#
# Tty
# This file contains Ruby code for tty.

# gem install tty-prompt
require 'tty-prompt'

prompt = TTY::Prompt.new
name = prompt.ask('What is your name?', default: ENV.fetch('USER', nil))
choices = %w[Bash Ruby Lua Python]

selection = prompt.select('Which language do you prefer for scripting?', choices)

puts "Hello #{name}, you chose #{selection}!"
