#!/usr/bin/env ruby
# frozen_string_literal: true

# 07_directory_buster.rb — concurrent URL path enumerator
require "net/http"
require "uri"
require "optparse"

# Educational script: discovers hidden directories via HTTP wordlist.
# Demonstrates OptionParser, Thread pools + Queue, and Net::HTTP.

options = { threads: 10, codes: [200, 301, 302, 403] }
OptionParser.new do |opts|
  opts.banner = "Usage: 07_directory_buster.rb -u <url> -w <wordlist> [options]"
  opts.on("-u URL", "Target URL") { |v| options[:url] = v }
  opts.on("-w FILE", "Wordlist file") { |v| options[:wordlist] = v }
  opts.on("-t N", Integer, "Threads (default: 10)") { |v| options[:threads] = v }
  opts.on("--status-codes x,y,z", Array,
          "HTTP codes to report (default: 200,301,302,403)") do |v|
    options[:codes] = v.map(&:to_i)
  end
end.parse!

unless options[:url] && options[:wordlist]
  puts "Error: -u and -w are required. Use -h for help."
  exit 1
end

uri = URI(options[:url])
wordlist = File.readlines(options[:wordlist]).map(&:chomp)
queue = Queue.new
wordlist.each { |path| queue << path }
mutex = Mutex.new

puts "Busting #{uri} with #{options[:threads]} threads..."

threads = options[:threads].times.map do
  Thread.new do
    while !queue.empty?
      path = queue.pop(true) rescue nil
      next unless path

      begin
        target = URI.join(uri, path)
        res = Net::HTTP.get_response(target)
        if options[:codes].include?(res.code.to_i)
          mutex.synchronize { puts "[#{res.code}] #{target}" }
        end
      rescue Errno::ECONNREFUSED
        mutex.synchronize { puts "Connection refused: #{uri.host}:#{uri.port}" }
        break
      rescue StandardError => e
        mutex.synchronize { puts "Error: #{e.message}" }
      end
    end
  end
end
threads.each(&:join)

puts "Done."
