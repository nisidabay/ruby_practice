#!/usr/bin/env ruby
# frozen_string_literal: true

# structs.rb — Struct reference (lightweight data class)

# Basic
Person = Struct.new(:first_name, :last_name, :age) do
  def full_name
    "#{first_name} #{last_name}"
  end

  def adult?
    age >= 18
  end

  def celebrate_birthday!
    self.age += 1
    puts "Happy Birthday, #{first_name}! You are now #{age}."
  end

  def initials
    "#{first_name[0]}#{last_name[0]}".upcase
  end
end

user = Person.new('Jane', 'Doe', 17)
puts user.full_name    # => Jane Doe
puts user.adult?       # => false
user.celebrate_birthday!
puts user.adult?       # => true
puts user.initials     # => JD

# Access
p user[:first_name]    # => "Jane" (by key)
p user[0]              # => "Jane" (by index)
p user.first_name      # => "Jane" (dot notation)
p Person.members       # => [:first_name, :last_name, :age]
p user.values          # => ["Bob", "Smith", 26]
p user.to_a            # => ["Bob", "Smith", 26]
p user.to_h            # => {:first_name=>"Bob", :last_name=>"Smith", :age=>26}

# Iteration
user.each_pair { |attr, value| puts "#{attr}: #{value}" }
user.each_with_index { |val, i| puts "#{user.members[i]}[#{i}] = #{val}" }

# Equality (values, not identity)
user2 = Person.new('Bob', 'Smith', 26)
p user == user2   # => true
p user.eql?(user2) # => true

# Dig (nested structs)
Address = Struct.new(:city, :country)
Company = Struct.new(:name, :address)
hq = Company.new('Acme', Address.new('Madrid', 'Spain'))
p hq.dig(:address, :city)     # => "Madrid"

# keyword_init (Ruby 3.0+)
Point = Struct.new(:x, :y, keyword_init: true)
p1 = Point.new(x: 10, y: 20)
p p1.inspect  # => #<struct Point x=10, y=20>

# Thinking in Ruby
#
# Struct is Ruby's lightweight data class — define attributes once, get
# reader/writer, == by value, to_a, to_h, each_pair, dig, and
# keyword_init (Ruby 3+) for free. It's the answer to "I need a simple
# data container without writing a full class." The block form also
# accepts method definitions.
