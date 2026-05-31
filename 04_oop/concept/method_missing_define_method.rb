#!/usr/bin/env ruby
# frozen_string_literal: true

# method_missing_define_method.rb — respond dynamically to unknown calls
# method_missing catches calls to undefined methods — define_method creates methods at runtime.

class ConfigReader
  def initialize(data)
    @data = data
  end

  def method_missing(name, *args)
    if @data.key?(name.to_s)
      @data[name.to_s]
    else
      super
    end
  end

  def respond_to_missing?(name, include_private = false)
    @data.key?(name.to_s) || super
  end
end

config = ConfigReader.new("host" => "db.internal", "port" => 5432)
puts config.host   # No method defined — method_missing catches it
puts config.port
p config.respond_to?(:host)  # true (respond_to_missing? handles it)
p config.respond_to?(:zZz)   # false
