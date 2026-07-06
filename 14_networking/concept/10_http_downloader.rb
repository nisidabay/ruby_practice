#!/usr/bin/env ruby
# frozen_string_literal: true

# 10_http_downloader.rb — HTTP file downloader with progress
# NOTE: Requires 'rest-client' gem. Install with: gem install rest-client

# Educational script: downloads files over HTTP/HTTPS with error handling.
# Demonstrates the rest-client gem for robust HTTP, URI parsing,
# custom exceptions, and file I/O.

begin
  require "rest-client"
  require "addressable/uri"
rescue LoadError
  puts "This script requires the 'rest-client' gem."
  puts "Install it with: gem install rest-client"
  exit 1
end

require "uri"

module Downloadr
  # Main HTTP download class with timeout and error handling.
  class HTTP
    attr_reader :uri, :path

    def initialize(download_uri, download_path = nil)
      @uri = ::Addressable::URI.parse(download_uri)
      @path = normalize_path(download_path)
    end

    def download
      response = ::RestClient::Request.execute(
        method: :get, url: @uri.to_s,
        timeout: 100, open_timeout: 10
      )
      File.write(@path, response.to_str)
      puts "Downloaded: #{@path} (#{File.size(@path)} bytes)"
    rescue ::SocketError
      raise "SocketError: Could not connect to #{@uri}"
    rescue RestClient::ResourceNotFound
      raise "ResourceNotFound: 404 — #{@uri}"
    end

    def self.download(uri, download_path = nil)
      new(uri, download_path).download
    end

    private

    def normalize_path(download_path)
      return download_path if download_path

      if @uri.basename.nil? || @uri.basename.empty?
        raise "UnknownDownloadPath: cannot determine filename from URI"
      end
      @uri.basename
    end
  end
end

# Usage:
# Downloadr::HTTP.download('https://httpbin.org/image/jpeg', '/tmp/file.jpg')

# CLI mode
if __FILE__ == $PROGRAM_NAME
  if ARGV.empty?
    puts "Usage: ruby 10_http_downloader.rb <url> [output_path]"
    puts "Example: ruby 10_http_downloader.rb https://httpbin.org/image/jpeg"
    exit 1
  end

  begin
    Downloadr::HTTP.download(ARGV[0], ARGV[1])
  rescue StandardError => e
    puts "Error: #{e.message}"
    exit 1
  end
end

# Thinking in Ruby
#
# rest-client + Addressable::URI provides a robust HTTP downloader
# with timeout handling, error classification, and progress reporting.
# Ruby's exception hierarchy (SocketError, RestClient::ResourceNotFound)
# makes error handling declarative — you specify what to catch and what
# message to show. The Downloadr module keeps the code organized and
# reusable.
