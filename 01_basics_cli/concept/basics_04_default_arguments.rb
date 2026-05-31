#!/usr/bin/env ruby
# frozen_string_literal: true

def create_car(model, convertible: false)
  puts "Created #{model}"
  puts "Convertible #{convertible}" if convertible
  puts '-'
end

create_car('sedan')
create_car('sports car', convertible: true)
create_car('minivan', convertible: false)
