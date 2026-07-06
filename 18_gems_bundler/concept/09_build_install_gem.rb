#!/usr/bin/env ruby
# frozen_string_literal: true

# Problem: You want to build and install a gem — the full cycle from code to package.
# Example: Take a simple Ruby file, wrap it in a gem, build it, install it.
#
# Solution: Create a minimal gem structure, write a gemspec, run gem build.
# Visibility: This is the complete workflow — code → gemspec → .gem file → install.

require 'tmpdir'
require 'fileutils'

# Step 1: Create a minimal gem in a temp directory
Dir.mktmpdir('gem_demo_') do |dir|
  lib = File.join(dir, 'lib')
  FileUtils.mkdir_p(lib)

  # The actual code
  File.write(File.join(lib, 'greeter.rb'), <<~RUBY)
    module Greeter
      def self.hello(name = 'World')
        "Hello, \#{name}!"
      end
    end
  RUBY

  # The gemspec
  File.write(File.join(dir, 'greeter.gemspec'), <<~RUBY)
    Gem::Specification.new do |spec|
      spec.name        = 'greeter'
      spec.version     = '0.1.0'
      spec.summary     = 'A friendly greeter'
      spec.authors     = ['Demo']
      spec.files       = Dir['lib/**/*.rb']
      spec.require_paths = ['lib']
    end
  RUBY

  # Step 2: Build the gem
  puts "Building gem in #{dir}..."
  system("gem build #{File.join(dir, 'greeter.gemspec')} > /dev/null 2>&1")
  gem_file = Dir[File.join(dir, 'greeter-*.gem')].first

  if gem_file
    puts "Built: #{File.basename(gem_file)}"
    puts "Size: #{File.size(gem_file)} bytes"

    # Step 3: Inspect the built gem (without installing)
    spec = Gem::Package.new(gem_file).spec
    puts "  Name: #{spec.name} #{spec.version}"
    puts "  Files: #{spec.files.join(', ')}"
  else
    puts 'Build failed (gem command not available?)'
  end
end

# This could also be done like this:
# bundle gem greeter — generates the full skeleton:
#
#   bundle gem greeter
#   cd greeter
#   # Write your code in lib/greeter.rb
#   rake build    # builds the .gem file
#   rake install  # installs it locally
#   rake release  # pushes to RubyGems.org
#
# Thinking in Ruby
#
# Building a gem in Ruby is a self-contained cycle: write code, describe it in a
# gemspec, run `gem build`, and you have a distributable package. The entire
# toolchain — gem command, gemspec DSL, Gem::Package — is part of Ruby's standard
# library. This means every Ruby developer can package and distribute libraries
# without installing any additional tooling, lowering the barrier to code sharing.
