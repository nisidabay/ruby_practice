#!/usr/bin/env ruby
# frozen_string_literal: true

# class_basics_video.rb — basic class with attr_accessor

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

video = Video.new
video.title = "Ruby Classes Tutorial"
video.play
video.pause
video.stop


# Thinking in Ruby
#
# A basic Ruby class: instance variables (@title) are declared by
# assignment, not in a schema. attr_accessor creates reader/writer
# methods. The class body is executable code — def, attr_accessor, and
# even method calls all run when the class is loaded. This dynamic
# nature is fundamental to Ruby's object model.
