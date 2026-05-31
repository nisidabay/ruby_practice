# frozen_string_literal: true

# Formatter - displays results in different formats
#
# This class takes scanned files and formats them for output.
# It supports two formats: TUI (grouped by directory) and JSON.
#
# Key concepts:
#   - Grouping by directory: Hash.group_by pattern
#   - Formatting time: strftime
#   - Relative paths: sub with regex
#   - JSON output: to_json
#
class Formatter
  # Format files for TUI display (grouped by directory)
  #
  # @param files [Array<Hash>] array of {path:, mtime:} hashes
  # @return [String] formatted output ready for display
  #
  # The output groups files by their top-level directory and shows
  # relative paths to keep things readable.
  #
  # Example output:
  #   vimwiki/
  #     index.md               2024-04-25 14:32
  #     projects/example.md    2024-04-25 11:00
  #
  #   dotfiles/
  #     .bashrc               2024-04-25 10:15
  #
  def self.format_tui(files)
    return "No files found for the specified date range." if files.empty?

    # Group files by top-level directory
    groups = group_by_directory(files)

    lines = []
    groups.each do |dir, entries|
      # Directory header
      lines << "#{dir}/"
      entries.each do |entry|
        lines << format_file(entry, dir)
      end
      lines << ""  # blank line between groups
    end

    lines.join("\n")
  end

  # Format files as JSON
  #
  # @param files [Array<Hash>] array of {path:, mtime:} hashes
  # @return [String] JSON string
  #
  def self.format_json(files)
    require "json"
    data = files.map do |f|
      {
        path: f[:path],
        modified: f[:mtime].strftime("%Y-%m-%d %H:%M")
      }
    end
    JSON.pretty_generate(data)
  end

  private

  # Group files by their top-level directory
  #
  # @param files [Array<Hash>] array of {path:, mtime:} hashes
  # @return [Hash] {directory => [entries]}
  #
  def self.group_by_directory(files)
    groups = {}

    files.each do |file|
      # Convert to relative path from home
      relative = file[:path].sub(ENV["HOME"], "~")

      # Get top-level directory (e.g., ~/vimwiki/... -> vimwiki)
      dir = relative.split("/")[1] || "unknown"

      groups[dir] ||= []
      groups[dir] << {
        relative_path: relative.sub("~/" + dir + "/", ""),
        mtime: file[:mtime]
      }
    end

    groups
  end

  # Format a single file entry
  #
  # @param entry [Hash] {relative_path:, mtime:}
  # @param dir [String] directory name
  # @return [String] formatted line
  #
  def self.format_file(entry, dir)
    path = entry[:relative_path]
    time = entry[:mtime].strftime("%Y-%m-%d %H:%M")

    # Align dates to 25th column
    "  #{path.ljust(25)} #{time}"
  end
end