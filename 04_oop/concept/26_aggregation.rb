#!/usr/bin/env ruby

class Player
  attr_accessor :name, :position

  def initialize(name, position)
    @name = name
    @position = position
  end

  def play
    "#{@name} is playing #{position}"
  end
end

class Team
  attr_accessor :name, :players

  def initialize(name)
    @name = name
    @players = []
  end

  def add_player(player)
    @players << player
  end

  def to_s
    "Team: #{@name}. Members: #{roster}"
  end

  private

  def roster
    players.map(&:name).join(', ')
  end
end

carlos = Player.new('Carlos', 'Defender')
sergio = Player.new('Sergio', 'Forward')

madrid = Team.new('Madrid')
granada = Team.new('Granada')
madrid.add_player(sergio)
granada.add_player(carlos)

puts madrid
puts granada

# Thinking in Ruby
#
# Aggregation: a Team has Player objects created independently. Players
# can exist across multiple teams or be reassigned. The Team's #to_s
# method calls a private #roster helper that maps over players — showing
# how private methods encapsulate formatting logic within the class.
