# frozen_string_literal: true

require 'time'

module Cliboard
  # Manages clipboard history with timestamps and deduplication
  class History
    attr_reader :items, :max_size

    # @param storage [Storage] persistence backend
    # @param max_size [Integer] maximum items to keep
    def initialize(storage:, max_size: 100)
      @storage = storage
      @max_size = max_size
      @items = load_items
    end

    # Add item to history (deduplicates)
    # @param text [String] clipboard content
    # @return [Hash] the added item
    def add(text)
      return if text.nil? || text.empty?

      # Remove duplicates
      @items.reject! { |item| item['text'] == text }

      # Add new item
      item = build_item(text)
      @items << item

      # Trim to max size
      @items = @items.last(@max_size)

      persist
      item
    end

    # Get item by index (1-based)
    # @param index [Integer] item number
    # @return [Hash, nil] the item or nil
    def get(index)
      @items[index - 1]
    end

    # Search history
    # @param query [String] search term
    # @return [Array<Hash>] matching items
    def search(query)
      return @items if query.nil? || query.empty?

      @items.select do |item|
        item['text'].downcase.include?(query.downcase)
      end
    end

    # Clear all history
    def clear
      @items = []
      persist
    end

    # Get recent items
    # @param limit [Integer] max items to return
    # @return [Array<Hash>]
    def recent(limit = nil)
      limit ? @items.last(limit) : @items
    end

    # Count items
    # @return [Integer]
    def size
      @items.size
    end

    # Check if empty
    # @return [Boolean]
    def empty?
      @items.empty?
    end

    private

    def load_items
      @storage.load
    end

    def persist
      @storage.save(@items)
    end

    def build_item(text)
      {
        'text' => text,
        'created_at' => Time.now.iso8601
      }
    end
  end

  # Manages pinned items separately from history
  class PinnedItems
    attr_reader :items

    # @param storage [Storage] persistence backend
    def initialize(storage:)
      @storage = storage
      @items = load_items
    end

    # Pin an item
    # @param text [String] text to pin
    # @return [Hash] the pinned item
    def pin(text)
      return if text.nil? || text.empty?
      return if pinned?(text)

      item = build_item(text)
      @items << item
      persist
      item
    end

    # Unpin by index (1-based)
    # @param index [Integer] item number
    # @return [Hash, nil] removed item
    def unpin(index)
      removed = @items.delete_at(index - 1)
      persist if removed
      removed
    end

    # Check if text is pinned
    # @param text [String]
    # @return [Boolean]
    def pinned?(text)
      @items.any? { |item| item['text'] == text }
    end

    # Get item by index
    # @param index [Integer]
    # @return [Hash, nil]
    def get(index)
      @items[index - 1]
    end

    # Count items
    # @return [Integer]
    def size
      @items.size
    end

    # Check if empty
    # @return [Boolean]
    def empty?
      @items.empty?
    end

    private

    def load_items
      @storage.load
    end

    def persist
      @storage.save(@items)
    end

    def build_item(text)
      {
        'text' => text,
        'created_at' => Time.now.iso8601
      }
    end
  end
end
