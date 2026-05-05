# frozen_string_literal: true

module Cliboard
  # Configuration management
  class Config
    attr_reader :data

    # @param storage [Storage] persistence backend
    def initialize(storage:)
      @storage = storage
      @data = storage.load
    end

    # Get config value
    # @param key [String] config key
    # @return [Object] value
    def get(key)
      @data[key]
    end

    # Set config value
    # @param key [String] config key
    # @param value [Object] value to set
    # @return [Object] the value
    def set(key, value)
      @data[key] = normalize_value(value)
      persist
      @data[key]
    end

    # List all config
    # @return [Hash]
    def to_h
      @data.dup
    end

    # Validate config key
    # @param key [String]
    # @return [Array<String>] valid keys
    def self.valid_keys
      %w[max_history]
    end

    # Check if key is valid
    # @param key [String]
    # @return [Boolean]
    def valid_key?(key)
      self.class.valid_keys.include?(key)
    end

    private

    def persist
      @storage.save(@data)
    end

    def normalize_value(value)
      case value
      when 'true' then true
      when 'false' then false
      when /^\d+$/ then value.to_i
      when /^\d+\.\d+$/ then value.to_f
      else value
      end
    end
  end
end
