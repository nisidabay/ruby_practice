#!/usr/bin/env ruby
# frozen_string_literal: true

# abstract_factory_pattern.rb — create families of related objects

class Button
  def render; end
  def click; end
end

class Checkbox
  def render; end
  def toggle; end
end

class WindowsButton < Button
  def render = puts("  [WinButton] Rendering...")
  def click  = puts("  [WinButton] Clicked!")
end

class WindowsCheckbox < Checkbox
  def render = puts("  [WinCheckbox] Rendering...")
  def toggle = puts("  [WinCheckbox] Toggled!")
end

class MacButton < Button
  def render = puts("  [MacButton] Rendering...")
  def click  = puts("  [MacButton] Clicked!")
end

class MacCheckbox < Checkbox
  def render = puts("  [MacCheckbox] Rendering...")
  def toggle = puts("  [MacCheckbox] Toggled!")
end

class GUIFactory
  def create_button; end
  def create_checkbox; end
end

class WindowsFactory < GUIFactory
  def create_button = WindowsButton.new
  def create_checkbox = WindowsCheckbox.new
end

class MacFactory < GUIFactory
  def create_button = MacButton.new
  def create_checkbox = MacCheckbox.new
end

factory = MacFactory.new
button = factory.create_button
checkbox = factory.create_checkbox
button.render
checkbox.render
button.click
checkbox.toggle


# Thinking in Ruby
#
# The Abstract Factory pattern creates families of related objects —
# GUIFactory defines create_button/create_checkbox, and WindowsFactory
# and MacFactory each produce a consistent product family. Ruby's blocks
# with short syntax (def create_button = WindowsButton.new) keep the
# factory implementations concise. The pattern ensures all UI components
# match the same look-and-feel.
