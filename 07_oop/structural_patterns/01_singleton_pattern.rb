#!/usr/bin/env ruby
# frozen_string_literal: true

# ============================================================
# Singleton Pattern in Ruby — three idiomatic approaches
# ============================================================
# The Singleton ensures a class has exactly one instance and
# provides a global point of access to it.
# ============================================================

puts '=' * 60
puts "APPROACH 1: Ruby's built-in Singleton module"
puts '=' * 60

require 'singleton'

class AppConfig1
  include Singleton

  attr_accessor :theme, :language

  def initialize
    # initialize runs once — when .instance is called the first time
    @theme    = 'dark'
    @language = 'en'
  end
end

# --- Demonstrate only one instance ---
a = AppConfig1.instance
b = AppConfig1.instance

puts "a.theme    = #{a.theme}"            # => dark
puts "b.language = #{b.language}"         # => en
puts "a.equal?(b) → #{a.equal?(b)}" # => true  (same object)

# --- Mutate through one reference, observe through the other ---
a.theme = 'solarized'
puts "After a.theme = 'solarized':"
puts "  a.theme = #{a.theme}"            # => solarized
puts "  b.theme = #{b.theme}"            # => solarized  (shared state)

# --- Direct construction is blocked ---
begin
  AppConfig1.new
rescue NoMethodError => e
  puts "AppConfig1.new → #{e.message}" # private method `new' called
end

# --- Drawbacks ---
# • Requires the 'singleton' stdlib dependency.
# • initialize runs on first .instance call (lazy), not at require time.
# • Harder to swap implementations for testing (consider dependency injection).

puts
puts '=' * 60
puts 'APPROACH 2: Manual private_class_method :new'
puts '=' * 60

class AppConfig2
  private_class_method :new

  attr_accessor :theme, :language

  def self.instance
    @instance ||= new # lazy initialization, not thread-safe
  end

  def initialize
    @theme    = 'dark'
    @language = 'en'
  end
end

# --- Demonstrate only one instance ---
c = AppConfig2.instance
d = AppConfig2.instance

puts "c.language = #{c.language}" # => en
puts "c.equal?(d) → #{c.equal?(d)}" # => true

# --- Shared state across references ---
c.theme = 'gruvbox'
puts "After c.theme = 'gruvbox':"
puts "  c.theme = #{c.theme}"            # => gruvbox
puts "  d.theme = #{d.theme}"            # => gruvbox

# --- Direct construction blocked, but send(:new) still works ---
begin
  AppConfig2.new
rescue NoMethodError => e
  puts "AppConfig2.new → #{e.message}" # private method `new' called
end

# NOTE: AppConfig2.send(:new) would still create a second instance.
# The Singleton module (approach 1) blocks this by overriding new.

# --- Drawbacks ---
# • @instance ||= new is NOT thread-safe; use a Mutex in multi-threaded code.
# • send(:new) bypasses the guard; don't rely on this for security.
# • Good choice when you want zero dependencies and single-threaded execution.

puts
puts '=' * 60
puts 'APPROACH 3: Module as a singleton namespace'
puts '=' * 60

# When you don't need instance semantics at all, a plain module with
# class-level ivars is the lightest-weight "global config" in Ruby.

module AppConfig3
  @theme    = 'dark'
  @language = 'en'

  class << self
    attr_accessor :theme, :language
  end
end

puts "AppConfig3.theme    = #{AppConfig3.theme}"      # => dark
puts "AppConfig3.language = #{AppConfig3.language}"   # => en

AppConfig3.theme = 'monokai'
puts "After AppConfig3.theme = 'monokai':"
puts "  AppConfig3.theme = #{AppConfig3.theme}"       # => monokai

# --- Drawbacks ---
# • Not a class — no #dup, #clone, #freeze, #inspect on a single object.
# • Cannot pass around as a single dependency (no instance to inject).
# • Global mutable state — same caveats as any singleton.
# • Best for: lightweight config, feature flags, environment globals.

puts
puts '=' * 60
puts 'SUMMARY'
puts '=' * 60
puts 'Approach 1 (Singleton module):  safest, thread-safe, zero boilerplate.'
puts 'Approach 2 (manual new-hiding): educational, no dependencies, not thread-safe.'
puts "Approach 3 (module namespace):  simplest — use when you don't need an object."
