#!/usr/bin/env ruby

# Problem: You need to make incompatible interfaces work together.
# Example: An audio player that only plays MP3 needs to support VLC and MP4 formats via a third-party library.
#
# Solution: Create an adapter that wraps the incompatible interface and converts it to what the client expects.
# Visibility: Adapter implements the target interface, client doesn't know it's using an adapted class.

class AudioPlayer
  def play(file_name)
    if file_name.end_with?(".mp3")
      puts "Playing MP3: #{file_name}"
    else
      puts "Unsupported format: #{file_name}"
    end
  end
end

class AdvancedMediaPlayer
  def play_vlc(file_name)
    puts "Playing VLC: #{file_name}"
  end

  def play_mp4(file_name)
    puts "Playing MP4: #{file_name}"
  end
end

class MediaAdapter
  def initialize(file_type)
    @advanced_player = AdvancedMediaPlayer.new
    @file_type = file_type
  end

  def play(file_name)
    case @file_type
    when "vlc"
      @advanced_player.play_vlc(file_name)
    when "mp4"
      @advanced_player.play_mp4(file_name)
    else
      puts "Unknown format: #{@file_type}"
    end
  end
end

class UniversalPlayer < AudioPlayer
  def play(file_name)
    if file_name.end_with?(".mp3")
      super
    elsif file_name.end_with?(".vlc")
      adapter = MediaAdapter.new("vlc")
      adapter.play(file_name)
    elsif file_name.end_with?(".mp4")
      adapter = MediaAdapter.new("mp4")
      adapter.play(file_name)
    else
      puts "Unknown format: #{file_name}"
    end
  end
end

# Usage: Create player that supports multiple formats via adapter
player = UniversalPlayer.new
player.play("song.mp3")    # Native support
player.play("movie.vlc")   # Via adapter
player.play("video.mp4")   # Via adapter
player.play("file.xyz")    # Still unsupported

# This could also be done like this:
# For simple cases, add methods directly to the existing class:
#
# class AudioPlayer
#   def play(file_name)
#     case file_name
#     when /\.mp3$/ then puts "Playing MP3: #{file_name}"
#     when /\.vlc$/ then puts "Playing VLC: #{file_name}"
#     when /\.mp4$/ then puts "Playing MP4: #{file_name}"
#     else puts "Unsupported: #{file_name}"
#     end
#   end
# end
