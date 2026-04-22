#!/usr/bin/env ruby
#
# Expands a relative file path to an absolute path
# Aborts if the file doesn't exist
def file_expand(file_name)
  abort("File: #{file_name} does not exist!") unless
File.exist?(file_name)
  File.expand_path(file_name, __dir__)
  File.join(__dir__, file_name)
end

p file_expand('rescue.rb')
