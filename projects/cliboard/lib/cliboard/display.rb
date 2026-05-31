# frozen_string_literal: true

require 'time'

module Cliboard
  # Handles formatting and display of history items
  class Display
    attr_reader :pins

    # @param pins [PinnedItems, nil] pinned items reference
    def initialize(pins: nil)
      @pins = pins
    end

    # Format a single item
    # @param item [Hash] history item
    # @param index [Integer] display index
    # @param options [Hash] display options
    # @return [String] formatted line
    def format_item(item, index:, width: 80, show_time: true)
      text = truncate(item['text'], width)
      time = format_time(item['created_at'])
      pinned = pinned?(item)

      prefix = pinned ? "\e[33m📌\e[0m " : '  '
      num = index.to_s.rjust(3)

      if show_time
        "#{prefix}#{num} \e[90m#{time}\e[0m #{text}"
      else
        "#{prefix}#{num} #{text}"
      end
    end

    # Display history list
    # @param items [Array<Hash>] history items
    # @param options [Hash] display options
    def show_history(items, limit: nil)
      return show_empty('history') if items.empty?

      items = items.last(limit) if limit

      if @pins && !@pins.empty?
        show_section('Pinned', @pins.items, color: 33)
        puts
      end

      show_section('History', items.reverse_each.with_index.to_a.reverse)
    end

    # Display pinned items
    # @param items [Array<Hash>] pinned items
    def show_pins(items)
      return show_empty('pinned items') if items.empty?

      show_section('Pinned', items.each_with_index.to_a)
    end

    # Display search results
    # @param query [String] search query
    # @param items [Array<Hash>] matching items
    def show_search(query, items)
      return puts("No results for '#{query}'") if items.empty?

      puts "Results for '#{query}':"
      items.reverse_each.with_index do |item, idx|
        puts format_item(item, index: items.size - idx)
      end
    end

    private

    def show_section(title, items_indexed, color: 32)
      puts "\e[1m\e[#{color}m[ #{title} ]\e[0m"

      if items_indexed.first.is_a?(Array)
        items_indexed.each do |item, idx|
          puts format_item(item, index: items_indexed.size - idx)
        end
      else
        items_indexed.each_with_index do |item, idx|
          puts format_item(item, index: items_indexed.size - idx)
        end
      end
    end

    def show_empty(name)
      puts "No #{name}"
    end

    def truncate(text, width)
      return '' if text.nil?
      return text if text.length <= width

      text[0, width - 3] + '...'
    end

    def format_time(iso_string)
      return '' if iso_string.nil?

      time = Time.parse(iso_string)
      time.strftime('%H:%M')
    rescue ArgumentError
      ''
    end

    def pinned?(item)
      return false unless @pins

      @pins.pinned?(item['text'])
    end
  end
end
