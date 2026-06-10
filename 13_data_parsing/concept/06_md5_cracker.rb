#!/usr/bin/env ruby
# frozen_string_literal: true

# 06_md5_cracker.rb — MD5 hash cracker with wordlist + cache
require "digest/md5"

# Educational script: cracks MD5 hashes using a wordlist.
# Demonstrates Digest::MD5, file I/O, hash comparison, and caching.

class Md5Cracker
  attr_reader :hashes, :cache

  def initialize(filename)
    @hashes = []
    @cache = {}

    File.foreach(filename) do |line|
      if (m = line.chomp.match(/\b([a-fA-F0-9]{32})\b/))
        @hashes << m[1].downcase
      end
    end
    @hashes.uniq!
    puts "Loaded #{@hashes.count} unique hashes"

    load_cache
  end

  def crack(wordlist_file)
    wordlist = File.readlines(wordlist_file).map(&:chomp)
    puts "Testing #{wordlist.size} words..."

    @hashes.each do |hash|
      # Check cache first
      if (plaintext = @cache[hash])
        puts "#{hash}:#{plaintext} (cached)"
        next
      end

      # Try dictionary attack
      if (plaintext = dictionary_attack(hash, wordlist))
        puts "#{hash}:#{plaintext}"
        append_to_cache(hash, plaintext)
      end
    end
  end

  private

  def dictionary_attack(hash, wordlist)
    wordlist.each do |word|
      return word if Digest::MD5.hexdigest(word) == hash
    end
    nil
  end

  CACHE_FILE = "md5_cache.txt"

  def load_cache
    return unless File.file?(CACHE_FILE)

    File.foreach(CACHE_FILE) do |line|
      if (m = line.chomp.match(/^([a-fA-F0-9]{32}):(.*)$/))
        @cache[m[1].downcase] = m[2]
      end
    end
    puts "Loaded #{@cache.size} cached entries"
  end

  def append_to_cache(hash, plaintext)
    File.open(CACHE_FILE, "a") { |f| f.puts "#{hash}:#{plaintext}" }
  end
end

# ── CLI ──
if __FILE__ == $PROGRAM_NAME
  if ARGV.size < 2
    puts "Usage: ruby 06_md5_cracker.rb <hashes.txt> <wordlist.txt>"
    puts ""
    puts "Example:"
    puts "  echo '5d41402abc4b2a76b9719d911017c592' > hashes.txt"
    puts "  echo 'hello' > words.txt"
    puts "  ruby 06_md5_cracker.rb hashes.txt words.txt"
    exit 1
  end

  Md5Cracker.new(ARGV[0]).crack(ARGV[1])
end
