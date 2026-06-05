#!/usr/bin/env ruby
# frozen_string_literal: true

# Entry — immutable value object for a single journal entry.
class Entry
  attr_reader :id, :timestamp, :topic, :body

  def initialize(id:, timestamp:, topic:, body:)
    @id = id
    @timestamp = timestamp
    @topic = topic
    @body = body
  end

  def to_h
    { id: @id, timestamp: @timestamp, topic: @topic, body: @body }
  end

  def display_line(width = 80)
    ts = @timestamp[0..15] # "YYYY-MM-DD HH:MM"
    "#{id.to_s.rjust(3)}  #{ts}  #{@topic[0..20].ljust(22)}  #{@body[0..width - 32]}"
  end

  def matches?(query)
    @topic.downcase.include?(query.downcase) ||
      @body.downcase.include?(query.downcase)
  end
end
