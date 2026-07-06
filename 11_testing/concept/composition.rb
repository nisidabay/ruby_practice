#!/usr/bin/env ruby
# frozen_string_literal: true

require 'minitest/autorun'

# composition.rb — Minitest tests for Car + Engine composition example

class Engine
  attr_accessor :type

  def initialize(type)
    @type = type
  end

  def to_s
    @type.to_s
  end
end

class Car
  attr_accessor :model, :engine

  def initialize(model, engine)
    @model = model
    @engine = engine
  end

  def to_s
    "New car: #{@model}. Engine: #{@engine}"
  end
end

class EngineTest < Minitest::Test
  def setup
    @engine = Engine.new('Electric')
  end

  def test_initialize_type
    assert_equal 'Electric', @engine.type
  end

  def test_type_setter
    @engine.type = 'Hybrid'
    assert_equal 'Hybrid', @engine.type
  end

  def test_to_s
    assert_equal 'Electric', @engine.to_s
    @engine.type = 'Gas'
    assert_equal 'Gas', @engine.to_s
  end
end

class CarTest < Minitest::Test
  def setup
    @engine = Engine.new('V8')
    @car = Car.new('Tesla', @engine)
  end

  def test_initialize
    assert_equal 'Tesla', @car.model
    assert_equal @engine, @car.engine
  end

  def test_model_setter
    @car.model = 'Ford'
    assert_equal 'Ford', @car.model
  end

  def test_engine_setter
    new_engine = Engine.new('Electric')
    @car.engine = new_engine
    assert_equal new_engine, @car.engine
  end

  def test_to_s
    assert_equal 'New car: Tesla. Engine: V8', @car.to_s
    @car.model = 'Toyota'
    @car.engine.type = 'Hybrid'
    assert_equal 'New car: Toyota. Engine: Hybrid', @car.to_s
  end
end

# Thinking in Ruby
#
# Minitest makes composition testing natural — each class has its own
# test class with focused setup. The Car + Engine relationship is tested
# independently (EngineTest, CarTest), then the integration through
# Car's setup. Ruby's attr_accessor means no getter/setter boilerplate;
# the tests read as plain assertions on plain objects.
