#!/usr/bin/env ruby
# frozen_string_literal: true

# Video
# This file contains Ruby code for video.

class Video
  attr_accessor :time, :title

  def initialize(title: nil, time: nil)
    @title = title
    @time = time
  end

  def play
    validate_title!
    puts "video playing #{@title}"
  end

  def pause
    validate_title!
    puts "video paused #{@title}"
  end

  def stop
    validate_title!
    puts "video stopped #{@title}"
  end

  private

  def validate_title!
    # Tip: Using .to_s handles nil and strings in one go
    return unless @title.to_s.strip.empty?

    raise ArgumentError, 'Video title cannot be nil or empty'
  end
end
