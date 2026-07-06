#!/usr/bin/env ruby
# frozen_string_literal: true

# 03_class_methods_self_syntax.rb — factory methods on the class itself

# WITHOUT class methods — callers construct every object manually:
#
#   dev  = Config.new("localhost", 5432)
#   prod = Config.new("prod-db.internal", 5432)
#   # callers must know the internal values — brittle
#
# WITH class methods — the class knows its own sensible defaults:

class Config
  attr_reader :host, :port

  def initialize(host, port)
    @host = host
    @port = port
  end

  def self.development
    new("localhost", 5432)
  end

  def self.production
    new("prod-db.internal", 5432)
  end

  def to_s
    "postgres://#{host}:#{port}"
  end
end

puts Config.development  # => postgres://localhost:5432
puts Config.production   # => postgres://prod-db.internal:5432

# Thinking in Ruby
#
# def self.method defines a class method — a method on the Class object
# itself. These serve as factory methods (Config.development) that
# encapsulate construction logic. In Ruby, "class methods" are really
# singleton methods on the class object, consistent with "everything is
# an object."
