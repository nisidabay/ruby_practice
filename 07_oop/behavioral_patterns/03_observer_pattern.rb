#!/usr/bin/env ruby

# Problem: You want objects to automatically react when another object changes state.
# Example: A weather station that updates multiple displays (current conditions, statistics, alerts) when measurements change.
#
# Solution: Use the observer pattern - subjects notify all registered observers when they change.
# Visibility: Observers subscribe/unsubscribe, subject doesn't know what they do.

class WeatherStation
  def initialize
    @observers = []
    @temperature = 0
    @humidity = 0
  end

  def attach(observer)
    @observers << observer
  end

  def detach(observer)
    @observers.delete(observer)
  end

  def measurements_changed(temp, humidity)
    @temperature = temp
    @humidity = humidity
    puts "\n[WeatherStation] Updated: #{@temperature}°C, #{@humidity}%"
    notify_observers
  end

  private

  def notify_observers
    @observers.each { |observer| observer.update(self) }
  end

  public

  attr_reader :temperature, :humidity
end

class CurrentConditionsDisplay
  def update(station)
    puts ">>> Current: #{station.temperature}°C, #{station.humidity}% humidity"
  end
end

class StatisticsDisplay
  def initialize
    @temp_sum = 0
    @temp_count = 0
  end

  def update(station)
    @temp_sum += station.temperature
    @temp_count += 1
    avg = (@temp_sum / @temp_count).round(1)
    puts ">>> Statistics: Avg temp #{avg}°C (from #{@temp_count} readings)"
  end
end

class AlertDisplay
  def update(station)
    if station.temperature > 35
      puts ">>> ⚠️ HIGH TEMP ALERT: #{station.temperature}°C"
    end
    if station.humidity < 20
      puts ">>> ⚠️ LOW HUMIDITY ALERT: #{station.humidity}%"
    end
  end
end

# Usage: Create subject and observers, then subscribe
station = WeatherStation.new

current = CurrentConditionsDisplay.new
stats = StatisticsDisplay.new
alerts = AlertDisplay.new

station.attach(current)
station.attach(stats)
station.attach(alerts)

# Changes trigger automatic notifications to all observers
station.measurements_changed(25, 60)
station.measurements_changed(28, 55)
station.measurements_changed(36, 45)  # Triggers temp alert

# Unsubscribe when no longer needed
station.detach(stats)
station.measurements_changed(30, 50)  # Stats won't update

# This could also be done like this:
# For simple cases, use blocks instead of full observer classes:
#
# station = WeatherStation.new
# station.attach { |s| puts "Temp: #{s.temperature}°C" }
# station.attach { |s| puts "Humidity: #{s.humidity}%" }
