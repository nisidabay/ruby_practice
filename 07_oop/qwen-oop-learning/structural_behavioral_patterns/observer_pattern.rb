#!/usr/bin/env ruby

# Observer Pattern — Publish/Subscribe Event System
# Core Idea: Define a one-to-many dependency between objects. When one object
# (the Subject) changes state, all its dependents (Observers) are notified
# and updated automatically.


# =============================================================================
# 1. THE OBSERVER INTERFACE
# =============================================================================
# All observers must implement this interface.

class Observer
  def update(subject)
    raise NotImplementedError, "Subclasses must implement update()"
  end
end


# =============================================================================
# 2. THE SUBJECT (PUBLISHER)
# =============================================================================
# This class maintains a list of observers and notifies them of changes.

class WeatherStation
  def initialize
    @observers = []
    @temperature = 0
    @humidity = 0
    @pressure = 0
  end

  # Attach an observer (subscribe)
  def attach(observer)
    @observers << observer
    puts "[Observer attached]"
  end

  # Detach an observer (unsubscribe)
  def detach(observer)
    @observers.delete(observer)
    puts "[Observer detached]"
  end

  # Notify all observers
  def notify_observers
    @observers.each { |observer| observer.update(self) }
  end

  # State changes trigger notifications
  def measurements_changed(temp, humidity, pressure)
    @temperature = temp
    @humidity = humidity
    @pressure = pressure
    puts "\n[Measurements updated: #{@temperature}°C, #{@humidity}%, #{@pressure}hPa]"
    notify_observers
  end

  # Getters for observers to read state
  attr_reader :temperature, :humidity, :pressure
end


# =============================================================================
# 3. CONCRETE OBSERVERS
# =============================================================================
# Each observer reacts differently to the same event.

class CurrentConditionsDisplay < Observer
  def update(subject)
    puts "\n>>> Current Conditions:"
    puts "    Temperature: #{subject.temperature}°C"
    puts "    Humidity: #{subject.humidity}%"
  end
end

class StatisticsDisplay < Observer
  def initialize
    @temp_sum = 0
    @temp_count = 0
    @max_temp = -Float::INFINITY
    @min_temp = Float::INFINITY
  end

  def update(subject)
    temp = subject.temperature
    @temp_sum += temp
    @temp_count += 1
    @max_temp = temp if temp > @max_temp
    @min_temp = temp if temp < @min_temp

    puts "\n>>> Statistics:"
    puts "    Avg temp: #{(@temp_sum / @temp_count).round(1)}°C"
    puts "    Min/Max: #{@min_temp}°C / #{@max_temp}°C"
  end
end

class AlertDisplay < Observer
  def update(subject)
    alerts = []
    alerts << "HIGH TEMP ALERT!" if subject.temperature > 35
    alerts << "LOW HUMIDITY ALERT!" if subject.humidity < 20
    alerts << "STORM WARNING!" if subject.pressure < 980

    if alerts.any?
      puts "\n>>> ALERTS:"
      alerts.each { |alert| puts "    ⚠️  #{alert}" }
    end
  end
end


# =============================================================================
# HOW TO USE IT
# =============================================================================

puts "=== Observer Pattern Demo ===\n\n"

# Create the subject (weather station)
weather_station = WeatherStation.new

# Create observers (displays)
current_display = CurrentConditionsDisplay.new
stats_display = StatisticsDisplay.new
alert_display = AlertDisplay.new

# Subscribe observers
weather_station.attach(current_display)
weather_station.attach(stats_display)
weather_station.attach(alert_display)

# Simulate weather changes
puts "\n--- Simulating Weather Changes ---"
weather_station.measurements_changed(25, 60, 1013)
weather_station.measurements_changed(28, 55, 1010)
weather_station.measurements_changed(36, 45, 1005)  # Triggers temp alert
weather_station.measurements_changed(38, 15, 978)   # Triggers multiple alerts

# Unsubscribe an observer
puts "\n--- Detaching Statistics Display ---"
weather_station.detach(stats_display)

puts "\n--- New Measurement (stats won't update) ---"
weather_station.measurements_changed(30, 50, 1000)

puts "\n=== Key Takeaway ==="
puts "The WeatherStation doesn't know what the observers do."
puts "It just notifies them. Loose coupling!"
