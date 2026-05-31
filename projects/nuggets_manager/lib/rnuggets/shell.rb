# frozen_string_literal: true

require 'open3'

module Rnuggets
  module Shell
    module_function

    # Execute a shell command and return its output or error message.
    # @param command [String] The shell command to execute.
    # @return [String] stdout on success, error message on failure.
    def run(command)
      stdout, stderr, status = Open3.capture3(command)
      status.success? ? stdout.strip : "Command failed with error: #{stderr.strip}"
    end

    # Pipe options to fzf and return the user's selection.
    # @param options [Array<String>] Options to display in fzf.
    # @param header [String, nil] Optional header text for fzf.
    # @return [String, nil] Selected option text, or nil if cancelled/missing fzf.
    def choose_with_fzf(options, header: nil)
      input = options.join("\n")
      cmd = ['fzf']
      cmd << '--header-first' << '--tac'
      cmd << "--header=#{header}" if header

      Open3.popen3(*cmd) do |stdin, stdout, _stderr, _thread|
        stdin.puts(input)
        stdin.close
        result = stdout.read.strip
        result.empty? ? nil : result
      end
    rescue Interrupt, Errno::ENOENT
      nil
    end

    # Open a file path with xdg-open.
    # @param path [String] Path to the file to open.
    # @return [Boolean] true if successful, false otherwise.
    def open_link(path)
      system('xdg-open', path.to_s)
    rescue Errno::ENOENT
      false
    end
  end
end
