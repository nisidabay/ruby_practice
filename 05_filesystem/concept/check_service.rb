#!/usr/bin/env ruby
# frozen_string_literal: true
require 'open3'
# Check service
# This file contains Ruby code for check service.


command_to_run = 'systemctl status lightdm'

puts "Running command: #{command_to_run}"

# Open3.capture3 is the magic method.
# It runs the command and gives you three things back:
# 1. standard_output (what you normally see)
# 2. standard_error (the error messages)
# 3. status (was it successful or did it fail?)
standard_output, standard_error, status = Open3.capture3(command_to_run)

# status.success? returns true if the exit code was 0 (meaning no errors)
if status.success?
  puts 'Success! Here is the output:'
  puts standard_output
else
  puts 'Uh oh, the command failed.'
  puts "Error message from Linux: #{standard_error.strip}"
  puts "Exit code: #{status.exitstatus}"
end
