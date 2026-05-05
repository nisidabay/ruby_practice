# frozen_string_literal: true

require 'fileutils'
require 'date'

module Rnuggets
  # Provides week-passed checking and date file management for nugget rotation.
  module DateTracker
    module_function

    # Check how many days have passed since the nugget was started.
    #
    # If seven or more days have elapsed, a warning panel is displayed and the
    # stored date file is removed so the timer resets on the next invocation.
    #
    # @param stored_date [Date] the reference date (typically Date.today)
    # @param message [String] warning message shown when a week has passed
    # @param dir_path [String] directory where the date file lives (default: ".")
    # @return [void]
    def check_week_passed(stored_date, message:, dir_path: ".")
      path = File.join(dir_path, "current_date.txt")
      FileUtils.mkdir_p(dir_path)

      # Write today's date if the file does not yet exist.
      unless File.exist?(path)
        File.write(path, Date.today.iso8601)
      end

      # Read the stored date from the file.
      current_date = begin
        Date.parse(File.read(path).strip)
      rescue ArgumentError, Date::Error
        # Corrupt or unparseable content — overwrite with today's date.
        today = Date.today.iso8601
        File.write(path, today)
        Date.parse(today)
      end

      days_passed = (current_date - stored_date).to_i.abs

      Display.draw_panel(
        message: "⏰ Days running this nugget: #{days_passed}",
        color: :bold_yellow,
        border_color: :blue
      )

      return unless days_passed >= 7

      Display.draw_panel(message: ":bomb: #{message}", color: :bold_yellow, border_color: :blue)
      remove_stored_date(dir_path: dir_path)
    end

    # Remove the stored date file, effectively resetting the nugget timer.
    #
    # @param dir_path [String] directory where the date file lives (default: ".")
    # @return [void]
    def remove_stored_date(dir_path: ".")
      path = File.join(dir_path, "current_date.txt")

      if File.exist?(path)
        File.delete(path)
        Display.draw_panel(message: "🔄 Reset nugget timer", color: :bold_yellow, border_color: :blue)
      else
        Display.draw_panel(message: ":bomb: Cannot remove nugget timer", color: :bold_yellow, border_color: :blue)
      end
    end
  end
end
