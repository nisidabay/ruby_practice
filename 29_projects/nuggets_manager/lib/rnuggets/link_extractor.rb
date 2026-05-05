# frozen_string_literal: true

module Rnuggets
  # Extracts +link:+ patterns from text snippets and offers to open them with
  # the system handler (+xdg-open+).
  module LinkExtractor
    module_function

    LINK_REGEX = /^link:\s*(.+)$/

    # Scan +text_snippet+ for +link:+ lines and prompt the user before opening
    # each resolved path with +xdg-open+.
    #
    # @param text_snippet [String] the snippet text to scan
    # @return [void]
    def open_link_with_xdg_open(text_snippet)
      matches = text_snippet.scan(LINK_REGEX).flatten

      matches.each do |match|
        path = match.strip.gsub(/"/, "")
        expanded = File.expand_path(path)

        unless File.exist?(expanded)
          puts "Link '#{expanded}' does not exist."
          next
        end

        print "This nugget has a link. Do you want to open it? [y/N] "
        answer = $stdin.gets.strip.downcase

        next unless %w[y yes].include?(answer)

        begin
          system("xdg-open", expanded)
        rescue Errno::ENOENT
          puts "Failed to open link '#{expanded}' with xdg-open. Command not found."
        rescue SystemCallError => e
          puts "Failed to open link '#{expanded}' with xdg-open. Error: #{e.message}"
        end
      end
    end
  end
end
