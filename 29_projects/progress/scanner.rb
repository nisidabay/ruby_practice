# frozen_string_literal: true

require "time"
require "find"

# Scanner - finds files modified within a date range
#
# Scans $HOME for text files, skipping hidden directories.
#
# Key concepts:
#   - Dir.glob: recursively finds files
#   - File.mtime: gets modification time as Time object
#   - Hidden check: skip files/dirs starting with .
#
class Scanner
  # Text file extensions to include
  TEXT_EXTENSIONS = %w[
    md txt rb sh py js ts json yaml yml html css
    c h cpp hpp java go rs php sql conf ini
    org wiki tex bib
  ].freeze

  # Scan $HOME for text files modified within date range
  #
  # @param from_date [Date, nil] start date (inclusive)
  # @param to_date [Date, nil] end date (inclusive)
  # @param directory [String, nil] override directory (default: $HOME)
  # @return [Array<Hash>] array of {path:, mtime:} hashes, sorted by mtime descending
  #
  def self.scan(from_date: nil, to_date: nil, directory: nil)
    home = File.expand_path(directory || "~")
    files = []

    Find.find(home) do |path|
      # Skip hidden files and directories
      if path.split("/").any? { |part| part.start_with?(".") && part != "." }
        Find.prune
        next
      end

      next unless File.file?(path)
      next unless text_file?(path)

      mtime = File.mtime(path)
      file_date = mtime.to_date

      # Filter by date range if specified
      next if from_date && file_date < from_date
      next if to_date && file_date > to_date

      files << { path: path, mtime: mtime }
    end

    # Sort by modification time, newest first
    files.sort_by { |f| f[:mtime] }.reverse
  end

  # Check if file is a text file by extension
  def self.text_file?(path)
    ext = File.extname(path).delete_prefix(".").downcase
    TEXT_EXTENSIONS.include?(ext)
  end
end