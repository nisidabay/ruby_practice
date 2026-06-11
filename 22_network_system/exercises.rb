#!/usr/bin/env ruby
# frozen_string_literal: true

# exercises.rb — Network & System practice

require 'resolv'
require 'ipaddr'
require 'socket'
require 'find'
require 'tsort'

puts '=== Exercise 1: Resolv ==='
resolver = Resolv::DNS.new
addrs = resolver.getaddresses('localhost')
puts "localhost: #{addrs.map(&:to_s).join(', ')}"

puts "\n=== Exercise 2: IPAddr ==="
ip = IPAddr.new('127.0.0.1')
puts "Loopback? #{ip.loopback?}"

puts "\n=== Exercise 3: UDPSocket ==="
socket = UDPSocket.new
puts "UDP socket created (fd: #{socket.fileno})"
socket.close

puts "\n=== Exercise 4: UNIXSocket pair ==="
a, b = UNIXSocket.pair
a.puts 'ping'
puts "Received: #{b.gets.chomp}"
a.close; b.close

puts "\n=== Exercise 5: Find ==="
count = 0
Find.find(Dir.pwd) { |p| count += 1 if p.end_with?('.rb'); break if count >= 3 }
puts "First 3 .rb files found"

puts "\n=== Exercise 6: TSort ==="
class Graph
  include TSort
  def initialize(h); @h = h; end
  def tsort_each_node(&b); @h.each_key(&b); end
  def tsort_each_child(n, &b); @h[n].each(&b); end
end
puts Graph.new('a' => ['b'], 'b' => []).tsort.inspect
