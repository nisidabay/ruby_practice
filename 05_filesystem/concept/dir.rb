#!/usr/bin/env ruby
#
# Essential one-liners

Dir.pwd                    
Dir.chdir("/tmp")         
p Dir.entries(".").reject {|e| e.start_with?(".")}
Dir.foreach(".") { |f| puts f }  
Dir["**/*.rb"]             
Dir.mkdir("new_dir", 0755)
Dir.rmdir("empty_dir")   
Dir.exist?("some/path") 
Dir.mktmpdir           
Dir.empty?("dir")    

# Change directory - restore after block
temp_dir=File.realpath(File.expand_path("~/temp"))
Dir.chdir(temp_dir) do  
  p Dir.pwd
  Dir.foreach(".") {|f| p f}
end
p Dir.pwd


# Thinking in Ruby
#
# Dir class methods give you all the directory operations you need without
# shelling out: pwd, chdir, entries, foreach, glob, mkdir, rmdir, exist?,
# mktmpdir, empty?. Ruby's Dir also supports block-form chdir that
# automatically restores the original directory — a safety pattern that
# shell scripts handle with subshells and manual cd/back juggling.


