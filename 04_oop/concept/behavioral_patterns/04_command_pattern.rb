#!/usr/bin/env ruby
# frozen_string_literal: true

# command_pattern.rb — encapsulate actions as objects for undo/redo

class TextEditor
  attr_accessor :text

  def initialize
    @text = ""
  end
end

class WriteCommand
  def initialize(editor, text)
    @editor = editor
    @text = text
  end

  def execute
    @editor.text += @text
    puts "  [Text: \"#{@editor.text}\"]"
  end

  def undo
    if @editor.text.end_with?(@text)
      @editor.text = @editor.text[0...-@text.length]
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
    return puts("  [Nothing to undo]") if @history.empty?
    cmd = @history.pop
    @redo_stack << cmd
    cmd.undo
  end

  def redo
    return puts("  [Nothing to redo]") if @redo_stack.empty?
    cmd = @redo_stack.pop
    @history << cmd
    cmd.execute
  end
end

editor = TextEditor.new
history = CommandHistory.new

puts "--- Editing ---"
history.execute(WriteCommand.new(editor, "Hello "))
history.execute(WriteCommand.new(editor, "World"))
history.execute(WriteCommand.new(editor, "!"))

puts "\n--- Undo ---"
history.undo
history.undo

puts "\n--- Redo ---"
history.redo
history.redo


# Thinking in Ruby
#
# The Command pattern encapsulates an action as an object with execute
# and undo. Ruby's blocks can also serve as lightweight commands — but
# the full class form supports undo/redo history stacks. The command
# history with separate undo and redo stacks is a clean Ruby
# implementation of a common editor pattern.
