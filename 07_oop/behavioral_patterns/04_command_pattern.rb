#!/usr/bin/env ruby

# Problem: You want to support undo/redo operations or queue requests as objects.
# Example: A text editor where every action (write, delete, paste) can be undone and redone.
#
# Solution: Encapsulate each request as a command object with execute and undo methods.
# Visibility: Commands are standalone objects, invoker manages execution history.

class TextEditor
  def initialize
    @text = ""
  end

  def write(text)
    @text += text
    puts "  [Text: \"#{@text}\"]"
  end

  def delete_last
    @text = @text[0...-1]
    puts "  [Text: \"#{@text}\"]"
  end

  attr_reader :text
end

class WriteCommand
  def initialize(editor, text)
    @editor = editor
    @text = text
  end

  def execute
    @editor.write(@text)
  end

  def undo
    # Remove the exact text we added
    current = @editor.text
    if current.end_with?(@text)
      @editor.instance_variable_set(:@text, current[0...-@text.length])
      puts "  [Undid write: removed \"#{@text}\"]"
    end
  end
end

class CommandHistory
  def initialize
    @history = []
    @redo_stack = []
  end

  def execute(command)
    command.execute
    @history << command
    @redo_stack.clear
  end

  def undo
    return puts "  [Nothing to undo]" if @history.empty?

    command = @history.pop
    @redo_stack << command
    command.undo
  end

  def redo
    return puts "  [Nothing to redo]" if @redo_stack.empty?

    command = @redo_stack.pop
    @history << command
    command.execute
  end
end

# Usage: Create editor and history, then execute commands
editor = TextEditor.new
history = CommandHistory.new

puts "--- Editing Session ---"
history.execute(WriteCommand.new(editor, "Hello "))
history.execute(WriteCommand.new(editor, "World"))
history.execute(WriteCommand.new(editor, "!"))

puts "\n--- Undo Operations ---"
history.undo  # Removes "!"
history.undo  # Removes "World"

puts "\n--- Redo Operations ---"
history.redo  # Restores "World"
history.redo  # Restores "!"

# Alternative: Memento pattern for simple undo (store state snapshots)
# For simple undo, store previous state instead of command objects:

class SimpleTextEditor
  def initialize
    @text = ""
    @history = []
  end

  def write(text)
    @history << @text.dup  # Save state before change
    @text += text
    puts "  [Text: \"#{@text}\"]"
  end

  def delete_last
    @history << @text.dup
    @text = @text[0...-1]
    puts "  [Text: \"#{@text}\"]"
  end

  def undo
    return puts "  [Nothing to undo]" if @history.empty?

    @text = @history.pop
    puts "  [Undone! Text: \"#{@text}\"]"
  end

  attr_reader :text
end

puts "\n--- Memento-style Undo ---"
editor = SimpleTextEditor.new

editor.write("Hello ")
editor.write("World")
editor.write("!")

puts "\n--- Undo Operations ---"
editor.undo
editor.undo
editor.undo
