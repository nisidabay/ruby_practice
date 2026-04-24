#!/usr/bin/env ruby
# frozen_string_literal: true

# Problem: You want to create a simple class with attributes and behavior.
# Example: A Video that has a title and can play, pause, and stop.
#
# Solution: Define a class with attr_accessor for attributes and instance methods for behavior.
# Visibility: Attributes are public (read/write), methods are public.

class Video
  attr_accessor :title

  def play
    puts "▶ Playing: #{title}"
  end

  def pause
    puts "⏸ Paused: #{title}"
  end

  def stop
    puts "⏹ Stopped: #{title}"
  end
end

# Usage: Create instance and call methods
video = Video.new
video.title = "Ruby Classes Tutorial"
video.play
video.pause
video.stop

# This could also be done like this:
# If you want read-only attributes, use attr_reader instead:
#
# class Video
#   attr_reader :title
#
#   def initialize(title)
#     @title = title
#   end
# end
#
# video = Video.new("Ruby Classes Tutorial")
# video.play
