#!/usr/bin/env ruby
#
# Log unreadable files, permissions 000
folder = 'secret_docs'
locked_path = 'locked_files.txt'

exit if !Dir.exist?(folder) || Dir.empty?(folder)

Dir.foreach(folder) do |entry|
  next if ['.', '..'].include?(entry)

  full_path = File.join(folder, entry)

  begin
    File.read(full_path)
  rescue Errno::EACCES
    File.open(locked_path, 'a') { |f| f.puts entry }
  end
end
