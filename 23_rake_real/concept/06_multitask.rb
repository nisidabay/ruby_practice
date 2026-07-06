#!/usr/bin/env ruby
# frozen_string_literal: true

# Problem: Independent tasks run sequentially, wasting time. Compile CSS and JS can run at the same time.
# Example: `rake build` compiles SCSS and minifies JS in parallel — 2x faster.
#
# Solution: multitask — like task but runs prerequisites in parallel threads.
# Visibility: `multitask name: [:dep1, :dep2]`. Dependencies run concurrently.

require 'tmpdir'

Dir.mktmpdir('rake_demo_') do |dir|
  File.write("#{dir}/Rakefile", <<~'RAKEFILE')
    # Sequential — each task waits for the previous one
    task :compile_css do
      puts '[CSS] Starting...'
      sleep 1  # simulate work
      puts '[CSS] Done'
    end

    task :compile_js do
      puts '[JS]  Starting...'
      sleep 1  # simulate work
      puts '[JS]  Done'
    end

    task :minify_images do
      puts '[IMG] Starting...'
      sleep 1  # simulate work
      puts '[IMG] Done'
    end

    desc 'Build sequentially (3 seconds)'
    task seq_build: [:compile_css, :compile_js, :minify_images]

    desc 'Build in parallel (~1 second)'
    multitask par_build: [:compile_css, :compile_js, :minify_images]
  RAKEFILE

  puts 'Sequential build:'
  t1 = Time.now
  system("rake -f #{dir}/Rakefile seq_build")
  puts "Time: #{(Time.now - t1).round(2)}s"

  puts "\nParallel build:"
  t2 = Time.now
  system("rake -f #{dir}/Rakefile par_build")
  puts "Time: #{(Time.now - t2).round(2)}s"
end

# This could also be done like this:
# Threads manually (works, but no rake integration):
#
#   threads = []
#   threads << Thread.new { compile_css }
#   threads << Thread.new { compile_js }
#   threads.each(&:join)
#
# multitask integrates with rake's dependency graph — you get
# parallel execution without managing threads yourself.
#
# Thinking in Ruby
#
# Rake's multitask is a pragmatic solution to a common build problem: independent
# tasks shouldn't run sequentially. By introducing a single keyword (`multitask`
# instead of `task`), Rake gives you parallel execution without changing your
# task definitions or managing threads. This reflects Ruby's philosophy of
# "optimizing for the common case" — most build scripts have independent steps
# that can run concurrently, and multitask makes this trivial to express.
