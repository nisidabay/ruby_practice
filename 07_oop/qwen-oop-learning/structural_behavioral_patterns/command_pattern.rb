#!/usr/bin/env ruby

# Command Pattern — Encapsulate Requests as Objects
# Core Idea: Turn a request into a stand-alone object that contains all information
# about the request. This allows parameterizing methods with different requests,
# queue requests, log them, or support undo/redo operations.


# =============================================================================
# 1. THE COMMAND INTERFACE
# =============================================================================
# All commands must implement execute and undo.

class Command
  def execute
    raise NotImplementedError, "Subclasses must implement execute()"
  end

  def undo
    raise NotImplementedError, "Subclasses must implement undo()"
  end
end


# =============================================================================
# 2. THE RECEIVER
# =============================================================================
# This is the object that actually performs the work.

class TextEditor
  def initialize
    @text = ""
    @clipboard = ""
  end

  def write(text)
    @text += text
    puts "  [Text: \"#{@text}\"]"
  end

  def select_all
    @selected = @text
    puts "  [Selected: \"#{@selected}\"]"
  end

  def copy
    @clipboard = @selected if @selected
    puts "  [Copied to clipboard: \"#{@clipboard}\"]"
  end

  def paste
    @text += @clipboard
    puts "  [Pasted: \"#{@text}\"]"
  end

  def delete
    @text = @text.gsub(@selected, "") if @selected
    @selected = nil
    puts "  [Deleted. Text: \"#{@text}\"]"
  end

  attr_reader :text
end


# =============================================================================
# 3. CONCRETE COMMANDS
# =============================================================================
# Each command encapsulates a specific action and its undo.

class WriteCommand < Command
  def initialize(editor, text)
    @editor = editor
    @text = text
  end

  def execute
    @editor.write(@text)
  end

  def undo
    # Remove the text we added
    @editor.instance_variable_set(:@text, @editor.text.sub(@text, ""))
    puts "  [Undid write. Text: \"#{@editor.text}\"]"
  end
end

class PasteCommand < Command
  def initialize(editor)
    @editor = editor
    @previous_state = nil
  end

  def execute
    @previous_state = @editor.text
    @editor.paste
  end

  def undo
    @editor.instance_variable_set(:@text, @previous_state)
    puts "  [Undid paste. Text: \"#{@editor.text}\"]"
  end
end

class DeleteCommand < Command
  def initialize(editor)
    @editor = editor
    @previous_state = nil
    @selected = nil
  end

  def execute
    @previous_state = @editor.text
    @editor.select_all
    @selected = @editor.instance_variable_get(:@selected)
    @editor.delete
  end

  def undo
    @editor.instance_variable_set(:@text, @previous_state)
    puts "  [Undid delete. Text: \"#{@editor.text}\"]"
  end
end


# =============================================================================
# 4. THE INVOKER
# =============================================================================
# This class manages command execution and history (for undo/redo).

class CommandHistory
  def initialize
    @history = []
    @redo_stack = []
  end

  def execute_command(command)
    command.execute
    @history << command
    @redo_stack.clear  # Clear redo on new action
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


# =============================================================================
# HOW TO USE IT
# =============================================================================

puts "=== Command Pattern Demo ===\n\n"

# Create receiver and invoker
editor = TextEditor.new
history = CommandHistory.new

puts "--- Editing Session ---"
history.execute_command(WriteCommand.new(editor, "Hello "))
history.execute_command(WriteCommand.new(editor, "World"))
history.execute_command(WriteCommand.new(editor, "!"))

puts "\n--- Undo Operations ---"
history.undo  # Undo last write
history.undo  # Undo second write

puts "\n--- Redo Operations ---"
history.redo  # Redo second write
history.redo  # Redo last write

puts "\n--- Using Editor's Built-in Operations ---"
editor.instance_variable_set(:@selected, "World")
history.execute_command(DeleteCommand.new(editor))

puts "\n--- Undo Delete ---"
history.undo

puts "\n=== Key Takeaway ==="
puts "Commands are objects. They can be queued, logged, or undone."
puts "This is how text editors implement Ctrl+Z / Ctrl+Y."
