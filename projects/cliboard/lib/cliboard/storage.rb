# frozen_string_literal: true

require 'json'
require 'fileutils'

module Cliboard
  # Handles persistent storage as JSON files
  class Storage
    attr_reader :path

    # @param path [String] file path for storage
    def initialize(path)
      @path = File.expand_path(path)
      FileUtils.mkdir_p(File.dirname(@path))
    end

    # Load data from file
    # @return [Array, Hash] parsed data
    def load
      return default_data unless File.exist?(@path)

      JSON.parse(File.read(@path))
    rescue JSON::ParserError
      default_data
    end

    # Save data to file
    # @param data [Array, Hash] data to save
    def save(data)
      File.write(@path, JSON.pretty_generate(data))
    end

    # Clear all data
    def clear
      save(default_data)
    end

    # Check if storage exists
    # @return [Boolean]
    def exist?
      File.exist?(@path)
    end

    private

    def default_data
      []
    end
  end

  # Specialized storage for key-value config
  class ConfigStorage < Storage
    private

    def default_data
      { 'max_history' => 100 }
    end
  end
end
