#!/usr/bin/env ruby

# Observer pattern
#
# Use it when a change to one object requires changing others, and you
# don't know exactly how many others need to change.
#
# - When a user signs up (send an email, update the marketing list, log
#   the action).
# - A shopping cart where adding an item needs to update the total price,
#   tax, and item count displayed on screen.
# - A weather extension showing temperature warnings.

# The Broadcaster
class WeatherStation
  THRESHOLD = %w[Cold Pleasant Hot Extreme_hot Warning]

  def initialize
    @observers = []
    @temperature = nil
  end

  # The Subscription
  def add_observers(&block)
    @observers << block
  end

  # The Notification
  def temperature=(temp)
    @temperature = temp
    threshold_message = get_threshold_message(temp)
    @observers.each { |observer| observer.call(temp, threshold_message) }
  end

  private

  def get_threshold_message(temp)
    case temp
    when 35..Float::INFINITY
      THRESHOLD[4] # Extreme_hot
    when 30...35
      THRESHOLD[3] # Warning
    when 25...30
      THRESHOLD[2] # Hot
    when 15...25
      THRESHOLD[1] # Pleasant
    when 0...15
      THRESHOLD[0] # Cold
    else
      THRESHOLD[0] # Cold (below 0)
    end
  end
end

# Usage with blocks (very Ruby!)
# The Broadcaster
station = WeatherStation.new
# The Listener
station.add_observers { |t, _msg| puts "🖥️ Dashboard: #{t}°C" }
station.add_observers do |_t, msg|
  puts "\t⚠️ Extreme caution!: #{msg}" if %w[Cold Hot Extreme_hot Warning].include?(msg)
end

# The Notifications
station.temperature = 25
station.temperature = 37
station.temperature = 15
station.temperature = 5
