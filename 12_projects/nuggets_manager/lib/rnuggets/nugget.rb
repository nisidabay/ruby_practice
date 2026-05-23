# frozen_string_literal: true

require 'fileutils'

module Rnuggets
  # Core class managing nugget operations — file discovery, selection, and
  # snippet management.
  class Nugget
    attr_reader :script_dir, :default_nugget, :nuggets_dict, :table_dict,
                :sentences, :remind, :total_nuggets
    attr_accessor :chosen_nugget

    # Display info about the currently selected nugget and its snippet count.
    def show_selected_nugget
      selected_nugget = _read_selected_nugget_name
      count = _count_nugget_lines
      Display.draw_panel(message: "Default nugget is [#{selected_nugget}] with [#{count}] snippets",
                         color: :bold_yellow, border_color: :blue)
    end

    def initialize(remind: true)
      # Resolves to the project root (parent of lib/) where .txt files live.
      @script_dir = File.expand_path('../..', __dir__)
      @default_nugget = File.join(@script_dir, 'default_nugget.txt')
      @remind = remind
      @nuggets_dict = {}
      @table_dict = {}
      @sentences = []
      @chosen_nugget = ''

      FileUtils.touch(@default_nugget) unless File.exist?(@default_nugget)

      _add_files_to_nuggets_dict
    end

    # ── Public CRUD methods ──────────────────────────────────────────────

    # Present a sorted list of nuggets via fzf for the user to pick from.
    # Populates @table_dict with the index-to-key mapping.
    #
    # @param header [String, nil] Optional header text for fzf.
    # @return [String, nil] The raw fzf selection string, or nil if cancelled.
    def show_available_nuggets(header: nil)
      sorted = @nuggets_dict.keys.sort
      options = sorted.each_with_index.map do |name, index|
        "#{index + 1} - #{name}"
      end

      options.each do |opt|
        num = opt.split(' - ', 2).first.to_i
        name = opt.split(' - ', 2).last
        @table_dict[num] = name
      end

      Shell.choose_with_fzf(options, header: header)
    end

    # Delete a nugget: user picks via fzf, confirms, then removes the file.
    def delete_nugget
      number = _get_nugget_number(header: 'Delete selected nugget')

      if number.nil?
        puts 'cancelled'
        return
      end

      unless _exist_nugget_number(number)
        Display.draw_panel(message: "There is no nugget number #{number}",
                           color: :bold_yellow, border_color: :red)
        exit 1
      end

      nugget_path = _get_nugget_file(number)

      return unless _ask_user('Delete nugget?')

      FileUtils.rm_f(nugget_path)
      Display.draw_panel(message: "Selected nugget #{nugget_path} has been deleted",
                         color: :bold_yellow, border_color: :blue)
    end

    # Edit a nugget: user picks via fzf, then opens in $EDITOR / nvim.
    def edit_nugget
      number = _get_nugget_number(header: 'Edit a nugget')

      return if number.nil?

      unless _exist_nugget_number(number)
        Display.draw_panel(message: "There is no nugget number #{number}",
                           color: :bold_yellow, border_color: :red)
        exit 1
      end

      nugget_path = _get_nugget_file(number)

      unless File.exist?(nugget_path)
        Display.draw_panel(message: "Nugget file not found: #{nugget_path}",
                           color: :bold_yellow, border_color: :red)
        exit 1
      end

      editor = ENV['EDITOR'] || 'nvim'
      system(editor, nugget_path)
      Display.draw_panel(
        message: "Nugget: #{File.basename(nugget_path, '.txt')} has been edited",
        color: :bold_yellow, border_color: :blue
      )
    end

    # Create a new nugget: prompt for name, open vim to edit, confirm creation.
    def new_nugget
      Display.draw_panel(
        message: 'Type the nugget name to create without extension',
        color: :bold_yellow, border_color: :blue
      )
      print '--> Enter new nugget name without extension: '
      name = $stdin.gets.strip

      if name.empty?
        Display.draw_panel(message: "Couldn't create nugget",
                           color: :bold_yellow, border_color: :red)
        return
      end

      new_path = File.join(@script_dir, "#{name}.txt")
      system('vim', new_path)

      if File.exist?(new_path)
        Display.draw_panel(message: "Nugget: #{name}.txt has been created",
                           color: :bold_yellow, border_color: :blue)
      else
        Display.draw_panel(message: "Couldn't create nugget",
                           color: :bold_yellow, border_color: :red)
      end
    end

    # Merge all non-excluded nugget files into a single ALL_NUGGETS.txt file.
    def merge_all_nuggets
      all_nuggets_path = File.join(@script_dir, 'ALL_NUGGETS.txt')

      File.delete(all_nuggets_path) if File.exist?(all_nuggets_path)

      excluded = %w[default_nugget ALL_NUGGETS nugget_title reminder_nuggets
                    current_date]

      File.open(all_nuggets_path, 'w', encoding: 'utf-8') do |outfile|
        Dir.glob(File.join(@script_dir, '*.txt')).each do |path|
          next if excluded.include?(File.basename(path, '.txt'))

          outfile.write(File.read(path, encoding: 'utf-8'))
        end
      end

      Display.draw_panel(
        message: "Merged all nuggets files in 'ALL_NUGGETS'",
        color: :bold_yellow, border_color: :green
      )
    end

    # Search across nugget files. Groups matches by file, shows a numbered
    # picker, then opens the chosen file in $EDITOR at the first match line.
    def find_in_nuggets
      Display.draw_line('Search in nuggets')

      print 'Enter search term: '
      term = $stdin.gets.strip

      if term.empty?
        Display.draw_panel(message: 'No search term provided',
                           color: :bold_yellow, border_color: :red)
        return
      end

      # Group matches by file: { basename => [[line_num, text], ...] }
      matches_by_file = {}
      Dir.glob(File.join(@script_dir, '*.txt')).each do |path|
        basename = File.basename(path, '.txt')
        next if %w[default_nugget nugget_title reminder_nuggets ALL_NUGGETS
                   current_date].include?(basename)

        File.readlines(path, encoding: 'utf-8').each_with_index do |line, idx|
          next unless line.downcase.include?(term.downcase)

          matches_by_file[basename] ||= []
          matches_by_file[basename] << [idx + 1, line.strip]
        end
      end

      if matches_by_file.empty?
        Display.draw_panel(message: "No matches found for '#{term}'",
                           color: :bold_yellow, border_color: :red)
        return
      end

      # Sort by match count descending
      sorted = matches_by_file.sort_by { |_, v| -v.size }

      total = sorted.sum { |_, v| v.size }
      Display.draw_panel(
        message: "Found #{total} match(es) for '#{term}' in #{sorted.size} file(s)",
        color: :bold_yellow, border_color: :blue
      )

      # Show grouped results
      puts ''
      sorted.each_with_index do |(basename, matches), idx|
        puts "  #{idx + 1}) #{basename}.txt (#{matches.size} match#{matches.size == 1 ? '' : 'es'})"
        matches.first(3).each do |line_no, text|
          display = text.length > 60 ? "#{text[0, 57]}..." : text
          puts "       :#{line_no}  #{display}"
        end
        puts '' if matches.size > 3
      end

      # Prompt to open a file
      print "Open file [1-#{sorted.size}, q]: "
      choice = $stdin.gets.strip
      return if choice.downcase == 'q'

      index = choice.to_i
      return unless index >= 1 && index <= sorted.size

      basename, matches = sorted[index - 1]
      path = File.join(@script_dir, "#{basename}.txt")
      first_line = matches.first[0]
      editor = ENV['EDITOR'] || 'nvim'

      if editor == 'nvim'
        system(editor, "+#{first_line}", path)
      else
        system(editor, path)
      end
    end

    # Select a nugget via fzf, create a symlink to it, and show a snippet.
    def select_specific_nugget
      number = _get_nugget_number(header: 'Choose a nugget')
      return if number.nil?

      @chosen_nugget = _get_nugget_file(number)
      _create_nugget_link

      nugget_text = _show_nugget(random_nugget: false)
      _remind_this_nugget(nugget_text)
    rescue ArgumentError, KeyError => e
      Display.draw_panel(message: "Invalid nugget: #{e.message}",
                         color: :bold_yellow, border_color: :red)
    end

    # Pick a random nugget, set it as default, display a random snippet.
    def select_random_nugget
      return if @nuggets_dict.empty?

      random_name = @nuggets_dict.keys.sample
      @chosen_nugget = @nuggets_dict[random_name]
      _create_nugget_link

      nugget_text = _show_nugget(random_nugget: true)
      _remind_this_nugget(nugget_text) if @remind
    end

    # Default run: show nugget of the day with week-passed check.
    def run_nuggets
      script_date = Date.today

      if File.symlink?(@default_nugget)
        @chosen_nugget = @default_nugget
        Display.draw_panel(
          message: "Selected nugget is: #{File.basename(File.realpath(@default_nugget), '.txt')}",
          color: :bold_yellow, border_color: :blue
        )
      else
        select_specific_nugget
        return
      end

      if @remind
        nugget_text = _show_nugget(random_nugget: false)
        _remind_this_nugget(nugget_text)
      else
        _show_nugget(random_nugget: false)
      end

      Rnuggets::DateTracker.check_week_passed(
        script_date,
        message: 'A week passed. Change nugget!',
        dir_path: @script_dir
      )
    end

    private

    # Create or replace the default_nugget.txt symlink pointing to @chosen_nugget.
    def _create_nugget_link
      FileUtils.ln_sf(@chosen_nugget, @default_nugget)
      _save_selected_nugget_name
      Display.draw_panel(
        message: "Selected nugget is: #{_read_selected_nugget_name}",
        color: :bold_yellow, border_color: :blue
      )
    rescue Errno::ENOENT => e
      Display.draw_panel(message: "Missing files: #{e.message}",
                         color: :bold_yellow, border_color: :red)
    end

    def _add_files_to_nuggets_dict
      skip_names = %w[default_nugget nugget_title reminder_nuggets ALL_NUGGETS
                      current_date]

      Dir.glob(File.join(@script_dir, '*.txt')).each do |path|
        basename = File.basename(path, '.txt')
        next if skip_names.include?(basename)

        @nuggets_dict[basename] = path
      end

      @total_nuggets = @nuggets_dict.size

      return unless @total_nuggets.zero?

      Display.draw_panel(message: 'No nugget files found!',
                         color: :bold_yellow, border_color: :red)
      exit 1
    end

    def _read_selected_nugget_name
      path = File.join(@script_dir, 'nugget_title')

      File.write(path, '', encoding: 'utf-8') unless File.exist?(path)

      File.read(path, encoding: 'utf-8').strip
    end

    def _save_selected_nugget_name
      name = File.basename(@chosen_nugget, '.txt')
      File.write(File.join(@script_dir, 'nugget_title'), name, encoding: 'utf-8')
    end

    def _exist_nugget_number(num)
      num >= 1 && num <= @total_nuggets
    end

    def _ask_user(action)
      print "Do you want to #{action} [y/N] "
      answer = $stdin.gets.strip.downcase
      %w[y yes].include?(answer)
    end

    def _get_nugget_file(index)
      nugget_key = @table_dict[index]

      if nugget_key.nil?
        Display.draw_panel(message: "Invalid nugget index: #{index}",
                           color: :bold_yellow, border_color: :red)
        exit 1
      end

      @nuggets_dict[nugget_key]
    end

    # Present nuggets via fzf and parse the selected number.
    #
    # @param header [String, nil] Optional header text for fzf.
    # @return [Integer, nil] The selected nugget number, or nil if cancelled.
    def _get_nugget_number(header: nil)
      selection = show_available_nuggets(header: header)
      return nil if selection.nil? || selection.empty?

      selection.split(' - ', 2).first.strip.to_i
    rescue ArgumentError
      nil
    end

    # Read the default nugget file, split on triple-bullet separators,
    # and return the resulting chunks.
    #
    # @return [Array<String>]
    # @raise [SystemExit] if the file does not exist
    def _create_snippets_chunks
      text = File.read(@default_nugget, encoding: 'utf-8').strip
      text.split('•••')
    rescue Errno::ENOENT
      Display.draw_panel(message: 'No nugget to display. Choose a nugget with \'option -c\'',
                         color: :bold_yellow, border_color: :red)
      exit 1
    end

    # Pick a random snippet index from the default nugget's chunks.
    # Stores the cleaned chunks in @sentences.
    #
    # @return [Integer] random index into @sentences
    def _extract_snippet_from_nugget
      chunks = _create_snippets_chunks
      @sentences = chunks.map(&:lstrip).reject(&:empty?)

      if @sentences.empty?
        Display.draw_panel(message: 'No snippets found in this nugget file',
                           color: :bold_yellow, border_color: :red)
        exit 1
      end

      rand(@sentences.length)
    rescue ArgumentError
      Display.draw_panel(message: 'No snippets found in this nugget file',
                         color: :bold_yellow, border_color: :red)
      exit 1
    end

    # Count how many snippet chunks exist in the default nugget.
    #
    # @return [Integer]
    def _count_nugget_lines
      chunks = _create_snippets_chunks
      sentences = chunks.map(&:lstrip).reject(&:empty?)
      sentences.length
    end

    # Display a snippet from the chosen (or default) nugget file.
    # When +random_nugget+ is true the header reads "Random nugget of the day".
    #
    # @param random_nugget [Boolean] flag for header wording
    # @return [String] the displayed nugget text
    def _show_nugget(random_nugget: false)
      snippet_title = File.basename(@chosen_nugget, '.txt')

      if snippet_title == 'default_nugget'
        snippet_title = _read_selected_nugget_name
      end

      header_text = if random_nugget
                      "Random nugget of the day from: #{snippet_title}"
                    else
                      "Nugget of the day from: #{snippet_title}"
                    end

      Display.draw_line(header_text)

      cite_number = _extract_snippet_from_nugget
      nugget_text = @sentences[cite_number] || ''
      nugget_text = nugget_text.gsub('`', '\\`')

      Display.draw_panel(message: nugget_text, color: :bold_yellow, border_color: :blue)

      nugget_text
    end

    # Offer to persist +nugget_text+ into reminder_nuggets.txt, then
    # scan for link: directives and offer to open them.
    #
    # @param nugget_text [#to_s] snippet text to save / scan
    # @return [void]
    def _remind_this_nugget(nugget_text)
      nugget_text = nugget_text.to_s

      if _ask_user("Save nugget in 'reminder_nuggets'?")
        reminder_file = File.join(@script_dir, 'reminder_nuggets.txt')
        File.open(reminder_file, 'a', encoding: 'utf-8') do |f|
          f.write("\n•••#{nugget_text}")
        end
        Display.draw_panel(message: 'Nugget saved in reminder_nuggets.txt',
                           color: :bold_yellow, border_color: :blue)
      end

      Rnuggets::LinkExtractor.open_link_with_xdg_open(nugget_text)
    end
  end
end
