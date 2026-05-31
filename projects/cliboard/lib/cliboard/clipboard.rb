# frozen_string_literal: true

module Cliboard
  # Clipboard abstraction layer - handles Wayland and X11 clipboards
  class Clipboard
    class ClipboardNotAvailable < StandardError; end

    # Detect available clipboard backend
    def self.detect
      if wayland?
        new(wayland_commands)
      elsif x11?
        new(x11_commands)
      else
        raise ClipboardNotAvailable, 'No clipboard backend found. Install wl-clipboard or xclip.'
      end
    end

    def self.wayland?
      system('which wl-copy > /dev/null 2>&1')
    end

    def self.x11?
      system('which xclip > /dev/null 2>&1')
    end

    def self.wayland_commands
      { copy: 'wl-copy', paste: 'wl-paste' }
    end

    def self.x11_commands
      { copy: 'xclip -selection clipboard', paste: 'xclip -selection clipboard -o' }
    end

    def initialize(commands)
      @copy_cmd = commands[:copy]
      @paste_cmd = commands[:paste]
    end

    # Get current clipboard content
    # @return [String, nil] clipboard content or nil if empty/unavailable
    def get
      result = `#{@paste_cmd} 2>/dev/null`.strip
      result.empty? ? nil : result
    rescue StandardError
      nil
    end

    # Set clipboard content
    # @param text [String] text to copy
    # @return [Boolean] success
    def set(text)
      return false if text.nil? || text.empty?

      IO.popen(@copy_cmd, 'w') { |io| io.write(text) }
      true
    rescue StandardError
      false
    end

    # Check if clipboard has content
    # @return [Boolean]
    def empty?
      get.nil?
    end

    # Watch clipboard for changes
    # @yield [String] yields new clipboard content
    def watch
      last = get

      loop do
        sleep(0.5)
        current = get
        next if current.nil? || current == last

        yield current
        last = current
      end
    end
  end
end
