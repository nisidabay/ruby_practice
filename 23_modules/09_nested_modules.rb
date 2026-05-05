#!/usr/bin/env ruby
# frozen_string_literal: true

# nested_modules.rb — organizing classes under namespaces with ::

module SmartHome
  module Lighting
    class Bulb
      def turn_on
        puts 'The light bulb is now ON.'
      end
    end
  end

  module Heating
    class Thermostat
      def set_temperature(degrees)
        puts "Heating up... Temperature is now #{degrees} degrees."
      end
    end
  end
end

living_room = SmartHome::Lighting::Bulb.new
living_room.turn_on

thermostat = SmartHome::Heating::Thermostat.new
thermostat.set_temperature(72)

# Alternative syntax: module A::B (creates B inside A without nesting)
module SmartHome::Entertainment
  class Speaker
    def play
      puts "Playing music..."
    end
  end
end
SmartHome::Entertainment::Speaker.new.play

