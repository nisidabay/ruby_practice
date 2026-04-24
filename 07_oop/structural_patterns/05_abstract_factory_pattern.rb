#!/usr/bin/env ruby

# Problem: You need to create families of related objects without specifying their concrete classes.
# Example: A cross-platform GUI that creates Windows, Mac, or Linux buttons/checkboxes/menus together.
#
# Solution: Use an abstract factory that defines methods for creating each object in the family.
# Visibility: Client uses the factory interface, doesn't know which concrete factory it's using.

class GUIFactory
  def create_button; end
  def create_checkbox; end
end

class WindowsButton
  def render
    puts "  [WindowsButton] Rendering Windows-style button"
  end

  def click
    puts "  [WindowsButton] Clicked with Windows animation"
  end
end

class WindowsCheckbox
  def render
    puts "  [WindowsCheckbox] Rendering Windows-style checkbox"
  end

  def toggle
    puts "  [WindowsCheckbox] Toggled with Windows style"
  end
end

class MacButton
  def render
    puts "  [MacButton] Rendering Mac-style button"
  end

  def click
    puts "  [MacButton] Clicked with Mac animation"
  end
end

class MacCheckbox
  def render
    puts "  [MacCheckbox] Rendering Mac-style checkbox"
  end

  def toggle
    puts "  [MacCheckbox] Toggled with Mac style"
  end
end

class WindowsFactory < GUIFactory
  def create_button
    WindowsButton.new
  end

  def create_checkbox
    WindowsCheckbox.new
  end
end

class MacFactory < GUIFactory
  def create_button
    MacButton.new
  end

  def create_checkbox
    MacCheckbox.new
  end
end

class Application
  def initialize(factory)
    @factory = factory
  end

  def render
    puts "[Application] Creating UI components:"
    @button = @factory.create_button
    @checkbox = @factory.create_checkbox
    @button.render
    @checkbox.render
  end

  def interact
    puts "\n[Application] User interactions:"
    @button.click
    @checkbox.toggle
  end
end

# Usage: Choose a factory based on platform, create consistent UI family
os = "mac"  # Could be: "windows", "mac"

factory = case os
          when "windows" then WindowsFactory.new
          when "mac" then MacFactory.new
          end

app = Application.new(factory)
app.render
app.interact

# This could also be done like this:
# For simple cases, use a parameterized factory:
#
# class UIFactory
#   def self.create_component(type, os)
#     case [type, os]
#     when [:button, "windows"] then WindowsButton.new
#     when [:button, "mac"] then MacButton.new
#     when [:checkbox, "windows"] then WindowsCheckbox.new
#     when [:checkbox, "mac"] then MacCheckbox.new
#     end
#   end
# end
