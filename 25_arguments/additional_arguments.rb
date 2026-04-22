#!/usr/bin/env ruby

def describe_hero(name, *super_powers)
  puts "Name: #{name}"
  super_powers.each do |power|
    puts "Super power: #{power}"
  end
  puts ""
end

describe_hero("Batman")
describe_hero("Flash", "speed")
describe_hero("Superman", "can fly", "x-ray vision", "invulnerable")

