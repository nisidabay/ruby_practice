#!/usr/bin/env ruby
# frozen_string_literal: true

# Problem: Your script needs proper logging — levels, timestamps, output to file or stdout.
# Example: A backup script that logs INFO during normal operation and ERROR on failures.
#
# Solution: Logger (stdlib) — leveled, formatted, multi-destination logging.
# Visibility: Logger is part of Ruby's standard library. `require 'logger'`.

require 'logger'

# Basic logger to stdout
logger = Logger.new($stdout)
logger.level = Logger::INFO  # ignore DEBUG messages

logger.debug('This will not appear')   # below INFO level
logger.info('Backup started')          # appears
logger.warn('Disk space low')          # appears
logger.error('Backup failed: disk full')  # appears
logger.fatal('System halted')          # appears

# Usage: Log to a file
# logger = Logger.new('app.log', 'daily')  # rotate daily

# Usage: Custom format
logger.formatter = proc do |severity, time, _progname, msg|
  "[#{time.strftime('%H:%M:%S')}] #{severity}: #{msg}\n"
end
logger.info('With custom format')

# This could also be done like this:
# puts with manual formatting (no levels, no file output):
#
#   puts "[#{Time.now}] Backup started"
#
# Logger gives you levels (filter noise), automatic timestamps,
# file rotation, and multiple outputs — all for free.
