# frozen_string_literal: true

module Rnuggets
  # Pure ANSI display helpers for rendering panels, rules, and screen control.
  # No external gems — only standard library and raw escape codes.
  module Display
    module_function

    ANSI = {
      yellow:       "\e[33m",
      red:          "\e[31m",
      blue:         "\e[34m",
      green:        "\e[32m",
      bold_yellow:  "\e[1;33m",
      bold_red:     "\e[1;31m",
      bold_blue:    "\e[1;34m",
      bold_green:   "\e[1;32m"
    }.freeze

    RESET = "\e[0m"

    BOX_TR = "┌"
    BOX_TL = "┐"
    BOX_BR = "└"
    BOX_BL = "┘"
    BOX_H  = "─"
    BOX_V  = "│"

    TERMINAL_WIDTH = 80

    # Draw a bordered panel with Unicode box-drawing characters.
    # Supports multi-line messages — each line renders as its own row
    # inside the box. Lines are padded to the width of the longest line
    # (capped at TERMINAL_WIDTH - 4).
    #
    # @param message [String] text to display inside the panel (may contain \n)
    # @param color [Symbol] ANSI color key for the message text
    # @param border_color [Symbol] ANSI color key for the border (default: :red)
    def draw_panel(message:, color:, border_color: :red)
      border_ansi = ANSI.fetch(border_color, ANSI[:red])
      text_ansi   = ANSI.fetch(color, ANSI[:green])

      lines = message.to_s.split("\n")
      max_line = lines.map(&:length).max || 0
      inner_width = [max_line, TERMINAL_WIDTH - 4].min
      fmt = "%-#{inner_width}s"

      top = "#{BOX_TR}#{BOX_H * (inner_width + 2)}#{BOX_TL}"
      bot = "#{BOX_BR}#{BOX_H * (inner_width + 2)}#{BOX_BL}"

      puts "#{border_ansi}#{top}#{RESET}"
      lines.each do |line|
        truncated = line.length > inner_width ? line[0, inner_width] : line
        text = "#{BOX_V} #{text_ansi}#{fmt % truncated}#{RESET} #{BOX_V}"
        puts "#{border_ansi}#{text}#{RESET}"
      end
      puts "#{border_ansi}#{bot}#{RESET}"
    end

    # Draw a header line with a horizontal rule, mimicking console.rule().
    #
    # @param message [String] text displayed in bold green, flush left
    def draw_line(message)
      msg = message.to_s
      left = "─── #{msg} "
      fill_len = TERMINAL_WIDTH - left.length
      fill_len = 1 if fill_len < 1

      puts "\e[1;32m#{left}#{BOX_H * fill_len}\e[0m"
    end

    # Clear the terminal screen.
    def clear_screen
      system("clear")
    end
  end
end
