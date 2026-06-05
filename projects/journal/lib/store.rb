#!/usr/bin/env ruby
# frozen_string_literal: true

require 'json'
require_relative 'entry'

# Store reads/writes journal entries as a flat JSON array.
# No pagination here — that's a CLI concern.
class Store
  def self.load(path)
    return [] unless File.exist?(path)

    raw = JSON.parse(File.read(path))
    raw.map do |hash|
      # JSON keys are strings; Entry expects symbols.
      Entry.new(
        id: hash['id'].to_i,
        timestamp: hash['timestamp'].to_s,
        topic: hash['topic'].to_s,
        body: hash['body'].to_s
      )
    end
  end

  def self.save(path, entries)
    data = entries.map(&:to_h)
    File.write(path, JSON.pretty_generate(data))
  end

  # Highest existing id, or 0 if the journal is empty.
  def self.max_id(path)
    entries = load(path)
    entries.empty? ? 0 : entries.map(&:id).max
  end
end
