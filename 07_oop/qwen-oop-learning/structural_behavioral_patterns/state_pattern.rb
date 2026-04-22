#!/usr/bin/env ruby

# State Pattern — Objects That Change Behavior by State
# Core Idea: Allow an object to alter its behavior when its internal state
# changes. The object will appear to change its class.


# =============================================================================
# 1. THE STATE INTERFACE
# =============================================================================
# All states must implement these methods.

class PlayerState
  def play(player); end
  def pause(player); end
  def stop(player); end
  def next(player); end
  def previous(player); end

  def name
    self.class.name.split("::").last
  end
end


# =============================================================================
# 2. CONCRETE STATES
# =============================================================================
# Each state defines different behavior for the same actions.

class StoppedState < PlayerState
  def play(player)
    puts "  [Starting playback]"
    player.state = PlayingState.new
  end

  def pause(player)
    puts "  [Can't pause - already stopped]"
  end

  def stop(player)
    puts "  [Already stopped]"
  end

  def next(player)
    puts "  [Can't skip - player stopped]"
  end

  def previous(player)
    puts "  [Can't go back - player stopped]"
  end
end

class PlayingState < PlayerState
  def play(player)
    puts "  [Already playing]"
  end

  def pause(player)
    puts "  [Pausing playback]"
    player.state = PausedState.new
  end

  def stop(player)
    puts "  [Stopping playback]"
    player.state = StoppedState.new
  end

  def next(player)
    puts "  [Skipping to next track]"
    # Could transition to PlayingState with new track
  end

  def previous(player)
    puts "  [Going to previous track]"
  end
end

class PausedState < PlayerState
  def play(player)
    puts "  [Resuming playback]"
    player.state = PlayingState.new
  end

  def pause(player)
    puts "  [Already paused]"
  end

  def stop(player)
    puts "  [Stopping playback]"
    player.state = StoppedState.new
  end

  def next(player)
    puts "  [Can't skip while paused]"
  end

  def previous(player)
    puts "  [Can't go back while paused]"
  end
end


# =============================================================================
# 3. THE CONTEXT
# =============================================================================
# This class delegates behavior to its current state.

class MusicPlayer
  def initialize
    @state = StoppedState.new
    @current_track = 0
    @playlist = ["Song A", "Song B", "Song C", "Song D"]
  end

  def state=(new_state)
    @state = new_state
    puts "  [State changed to: #{@state.name}]"
  end

  attr_reader :state

  def play
    puts "\n>> Play button pressed"
    @state.play(self)
  end

  def pause
    puts "\n>> Pause button pressed"
    @state.pause(self)
  end

  def stop
    puts "\n>> Stop button pressed"
    @state.stop(self)
  end

  def next
    puts "\n>> Next button pressed"
    @state.next(self)
  end

  def previous
    puts "\n>> Previous button pressed"
    @state.previous(self)
  end

  def current_track_info
    puts "\n[Now Playing: #{@playlist[@current_track]}]"
  end
end


# =============================================================================
# HOW TO USE IT
# =============================================================================

puts "=== State Pattern Demo ===\n\n"

player = MusicPlayer.new

puts "--- Initial State: Stopped ---"
player.play       # Stopped -> Playing
player.play       # Already playing
player.pause      # Playing -> Paused
player.pause      # Already paused
player.play       # Paused -> Playing
player.next       # Skip track
player.stop       # Playing -> Stopped
player.play       # Stopped -> Playing
player.previous   # Go back

puts "\n=== Key Takeaway ==="
puts "The MusicPlayer's behavior changes based on its state."
puts "No giant if/else or case statements needed!"
puts "Each state is its own class with clear responsibilities."
