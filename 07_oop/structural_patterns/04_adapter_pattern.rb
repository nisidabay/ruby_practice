#!/usr/bin/env ruby
# frozen_string_literal: true

# adapter_pattern.rb — make incompatible interfaces work together

class AudioPlayer
  def play(file_name)
    if file_name.end_with?(".mp3")
      puts "Playing MP3: #{file_name}"
    else
      puts "Unsupported: #{file_name}"
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
    @player = AdvancedMediaPlayer.new
    @file_type = file_type
  end

  def play(file_name)
    case @file_type
    when "vlc" then @player.play_vlc(file_name)
    when "mp4" then @player.play_mp4(file_name)
    end
  end
end

class UniversalPlayer < AudioPlayer
  def play(file_name)
    if file_name.end_with?(".mp3")
      super
    elsif file_name.end_with?(".vlc")
      MediaAdapter.new("vlc").play(file_name)
    elsif file_name.end_with?(".mp4")
      MediaAdapter.new("mp4").play(file_name)
    else
      puts "Unknown format: #{file_name}"
    end
  end
end

player = UniversalPlayer.new
player.play("song.mp3")
player.play("movie.vlc")
player.play("video.mp4")
player.play("file.xyz")

