#!/usr/bin/env ruby
# frozen_string_literal: true

# observer_pattern.rb — subjects notify registered observers on state change

class WeatherStation
  attr_reader :temperature, :humidity

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
    puts "\n[WeatherStation] #{@temperature}°C, #{@humidity}%"
    @observers.each { |o| o.update(self) }
  end
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
    puts ">>> ⚠️ HIGH TEMP ALERT: #{station.temperature}°C" if station.temperature > 35
    puts ">>> ⚠️ LOW HUMIDITY ALERT: #{station.humidity}%" if station.humidity < 20
  end
end

station = WeatherStation.new
station.attach(CurrentConditionsDisplay.new)
station.attach(StatisticsDisplay.new)
station.attach(AlertDisplay.new)
station.measurements_changed(25, 60)
station.measurements_changed(36, 45)

