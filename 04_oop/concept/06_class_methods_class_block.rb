#!/usr/bin/env ruby
# frozen_string_literal: true

# 06_class_methods_class_block.rb — grouping class methods with class << self

# WITHOUT class << self — prefix every method with self.:
#
#   class Config
#     def self.default; new("localhost", 5432); end
#     def self.test;    new("test-db", 5433);   end
#     def self.prod;    new("prod-db", 5432);   end
#   end
#   # repetitive self. on every line
#
# WITH class << self — group them:

class Config
  attr_reader :host, :port

  def initialize(host, port)
    @host = host
    @port = port
  end

  class << self
    def default
      new("localhost", 5432)
    end

    def test
      new("test-db", 5433)
    end

    def prod
      new("prod-db", 5432)
    end
  end

  def to_s
    "postgres://#{host}:#{port}"
  end
end

puts Config.default
puts Config.test
puts Config.prod
