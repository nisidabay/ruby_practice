#!/usr/bin/env ruby

# Memento Pattern — Save and Restore Object State
# Core Idea: Capture an object's internal state without violating encapsulation,
# so it can be restored later. Useful for undo, checkpoints, or snapshots.


# =============================================================================
# 1. THE MEMENTO
# =============================================================================
# Stores the internal state of the Originator. Should be immutable.

class EditorMemento
  def initialize(content, cursor_position, file_name)
    @content = content
    @cursor_position = cursor_position
    @file_name = file_name
  end

  # Read-only access for Originator to restore state
  attr_reader :content, :cursor_position, :file_name

  def to_s
    "Memento[#{file_name}, cursor: #{cursor_position}, content: #{content[0..20]}...]"
  end
end


# =============================================================================
# 2. THE ORIGINATOR
# =============================================================================
# Creates mementos to capture its state, and uses them to restore.

class TextEditor
  def initialize
    @content = ""
    @cursor_position = 0
    @file_name = "untitled"
  end

  def type(text)
    @content.insert(@cursor_position, text)
    @cursor_position += text.length
    puts "[Typed: \"#{text}\" -> cursor: #{@cursor_position}]"
  end

  def backspace
    if @cursor_position > 0
      @cursor_position -= 1
      @content = @content[0...@cursor_position] + @content[@cursor_position + 1..-1]
      puts "[Backspace -> cursor: #{@cursor_position}]"
    end
  end

  def move_cursor(position)
    @cursor_position = [[0, position].max, @content.length].min
    puts "[Cursor moved to: #{@cursor_position}]"
  end

  def save
    memento = EditorMemento.new(@content.dup, @cursor_position, @file_name.dup)
    puts "[Saved state: #{memento}]"
    memento
  end

  def restore(memento)
    @content = memento.content.dup
    @cursor_position = memento.cursor_position
    @file_name = memento.file_name.dup
    puts "[Restored state: #{memento}]"
  end

  def rename(new_name)
    @file_name = new_name
    puts "[Renamed to: #{@file_name}]"
  end

  def display
    puts "  File: #{@file_name}"
    puts "  Content: \"#{@content}\""
    puts "  Cursor: #{@cursor_position}"
  end
end


# =============================================================================
# 3. THE CARETAKER
# =============================================================================
# Manages mementos without examining their contents.

class History
  def initialize
    @mementos = []
    @current_index = -1
  end

  def save_state(memento)
    # Remove any forward history (user did new action after undo)
    @mementos = @mementos[0..@current_index]
    @mementos << memento
    @current_index = @mementos.length - 1
    puts "[History: saved snapshot ##{@current_index + 1}]"
  end

  def undo
    return nil if @current_index < 0

    @current_index -= 1
    memento = @mementos[@current_index]
    puts "[History: undo to snapshot ##{@current_index + 1}]"
    memento
  end

  def redo
    return nil if @current_index >= @mementos.length - 1

    @current_index += 1
    memento = @mementos[@current_index]
    puts "[History: redo to snapshot ##{@current_index + 1}]"
    memento
  end

  def can_undo?
    @current_index > 0
  end

  def can_redo?
    @current_index < @mementos.length - 1
  end

  def history_info
    puts "[History: #{@mementos.length} snapshots, currently at ##{@current_index + 1}]"
  end
end


# =============================================================================
# HOW TO USE IT
# =============================================================================

puts "=== Memento Pattern Demo ===\n\n"

editor = TextEditor.new
history = History.new

puts "--- Initial Editing ---"
editor.rename("notes.txt")
editor.type("Hello")
history.save_state(editor.save)

editor.type(" World")
history.save_state(editor.save)

editor.type("!")
history.save_state(editor.save)

puts "\n--- Current State ---"
editor.display
history.history_info

puts "\n--- Undo Operations ---"
if (memento = history.undo)
  editor.restore(memento)
end
editor.display

if (memento = history.undo)
  editor.restore(memento)
end
editor.display

puts "\n--- Make New Change (clears redo stack) ---"
editor.type("!!!")
history.save_state(editor.save)
editor.display

puts "\n--- Try Redo (should fail - forward history cleared) ---"
if (memento = history.redo)
  editor.restore(memento)
else
  puts "[No redo available]"
end

puts "\n--- Full Undo/Redo Cycle ---"
# Reset for demo
editor = TextEditor.new
history = History.new

editor.type("A")
history.save_state(editor.save)

editor.type("B")
history.save_state(editor.save)

editor.type("C")
history.save_state(editor.save)

puts "\nContent: #{editor.instance_variable_get(:@content)}"

puts "\nUndo twice:"
history.undo
editor.restore(history.undo) if history.can_undo?
puts "Content: #{editor.instance_variable_get(:@content)}"

puts "\nRedo twice:"
editor.restore(history.redo) if history.can_redo?
editor.restore(history.redo) if history.can_redo?
puts "Content: #{editor.instance_variable_get(:@content)}"

puts "\n=== Key Takeaway ==="
puts "Memento captures state without exposing internal structure."
puts "Caretaker manages history without knowing what's in the memento."
puts "This is how text editors implement undo/redo!"
