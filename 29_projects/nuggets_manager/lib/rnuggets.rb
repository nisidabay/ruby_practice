#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative 'rnuggets/display'
require_relative 'rnuggets/shell'
require_relative 'rnuggets/link_extractor'
require_relative 'rnuggets/date_tracker'
require_relative 'rnuggets/nugget'
require_relative 'rnuggets/cli'

module Rnuggets
  VERSION = '1.0.0'
end

Rnuggets::CLI.new.run(ARGV) if __FILE__ == $0
