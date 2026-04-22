#!/usr/bin/env ruby
#
# Adding a file to a directory

folder = 'backups'

Dir.mkdir(folder) unless Dir.exist?(folder)

file_name = 'log.txt'
file_path = File.join(folder, file_name)
File.write(file_path, "\nBackup completed", mode: 'a')
