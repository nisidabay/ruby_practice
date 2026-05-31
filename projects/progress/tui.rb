# frozen_string_literal: true

require "curses"
require "shellwords"

# TUI - Interactive terminal UI for browsing modified files
#
# This class creates a full-screen interactive TUI using Ruby's
# built-in curses library. Modeled after Bubble Tea TUIs.
#
# Key concepts:
#   - Curses: Ruby's built-in terminal UI library
#   - Window: Screen area for drawing
#   - Keypad: Enables arrow keys and special keys
#   - Input loop: Read keys, update state, redraw
#
# Keybindings:
#   j/down - scroll down
#   k/up   - scroll up
#   q      - quit
#
class TUI
  def initialize(files, options = {})
    @files = files
    @from_date = options[:from_date]
    @to_date = options[:to_date]
    @scroll_offset = 0
    @selected_index = 0
  end

  def run
    # Handle no files case
    if @files.empty?
      puts "No files found for the specified date range."
      return
    end

    Curses.init_screen
    Curses.noecho
    Curses.cbreak
    Curses.stdscr.keypad(true)
    Curses.curs_set(0) # Hide cursor

    begin
      draw
      input_loop
    ensure
      Curses.close_screen
    end
  end

  private

  def input_loop
    loop do
      key = Curses.getch
      case key
      when Curses::Key::DOWN, ?j
        scroll_down
      when Curses::Key::UP, ?k
        scroll_up
      when ?e
        open_in_editor
      when ?q, 27 # q or ESC
        break
      end
      draw
    end
  end

  def open_in_editor
    return if @files.empty?

    selected_file = @files[@selected_index]
    return unless selected_file

    # Close curses temporarily
    Curses.close_screen

    # Open in nvim (or fallback to vim)
    editor = ENV["EDITOR"] || "nvim"
    system("#{editor} #{Shellwords.escape(selected_file[:path])}")

    # Reopen curses after editor closes
    Curses.init_screen
    Curses.noecho
    Curses.cbreak
    Curses.stdscr.keypad(true)
    Curses.curs_set(0)
  end

  def scroll_down
    return if @selected_index >= @files.length - 1
    @selected_index += 1

    # Adjust scroll if cursor goes below visible area
    max_visible = Curses.lines - 4 # Account for header and footer
    if @selected_index >= @scroll_offset + max_visible
      @scroll_offset = @selected_index - max_visible + 1
    end
  end

  def scroll_up
    return if @selected_index <= 0
    @selected_index -= 1

    # Adjust scroll if cursor goes above visible area
    if @selected_index < @scroll_offset
      @scroll_offset = @selected_index
    end
  end

  def draw
    Curses.clear

    draw_header
    draw_files
    draw_footer

    Curses.refresh
  end

  def draw_header
    # Title with date range and file count
    date_range = if @from_date == @to_date
                   @from_date.strftime("%Y-%m-%d")
                 else
                   "#{@from_date} to #{@to_date}"
                 end
    header = " PROGRESS - #{date_range} (#{@files.length} files) "

    Curses.setpos(0, 0)
    Curses.attron(Curses::A_REVERSE) do
      Curses.addstr(header.ljust(Curses.cols))
    end
  end

  def draw_files
    max_visible = Curses.lines - 4 # Account for header and footer

    visible_files = @files[@scroll_offset, max_visible] || []

    visible_files.each_with_index do |file, idx|
      actual_row = idx + 1

      # Convert path to relative
      relative = file[:path].sub(ENV["HOME"], "~")

      # Truncate if too long
      max_path_width = Curses.cols - 25
      display_path = relative.length > max_path_width ?
                     "..." + relative[-(max_path_width - 3)..] :
                     relative

      time_str = file[:mtime].strftime("%Y-%m-%d %H:%M")

      # Highlight selected line
      Curses.setpos(actual_row, 0)
      if idx + @scroll_offset == @selected_index
        Curses.attron(Curses::A_REVERSE) do
          Curses.addstr(" #{display_path.ljust(Curses.cols - 21)}#{time_str} ")
        end
      else
        Curses.addstr(" #{display_path.ljust(Curses.cols - 21)}#{time_str} ")
      end
    end
  end

  def draw_footer
    # Show keybindings at bottom
    footer = " j/k: scroll  e: edit  q: quit "

    Curses.setpos(Curses.lines - 1, 0)
    Curses.attron(Curses::A_REVERSE) do
      Curses.addstr(footer.ljust(Curses.cols))
    end
  end
end