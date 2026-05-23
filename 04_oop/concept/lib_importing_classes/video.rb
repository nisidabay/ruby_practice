#!/usr/bin/env ruby
# frozen_string_literal: true

# video.rb — imported class for require_relative demos

class Video
  attr_accessor :title, :time

  def initialize(title: nil, time: nil)
    @title = title
    @time = time
  end

  def play
    validate!
    puts "▶ Playing: #{@title}"
  end

  def pause
    validate!
    puts "⏸ Paused: #{@title}"
  end

  def stop
    validate!
    puts "⏹ Stopped: #{@title}"
  end

  private

  def validate!
    return unless @title.to_s.strip.empty?
    raise ArgumentError, 'Title cannot be empty'
  end
end

