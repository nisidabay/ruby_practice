#!/usr/bin/env ruby
# frozen_string_literal: true

# Problem: Build a real CLI tool that combines logging, secure tokens, and safe shell execution.
# Example: A deployment script that logs to syslog, generates secure secrets, and runs commands safely.
#
# Solution: Combine Logger + SecureRandom + Shellwords + English in one practical script.
# Visibility: All stdlib — no gems needed.

require 'logger'
require 'securerandom'
require 'shellwords'
require 'English'

# Setup: logger to stdout with custom format
logger = Logger.new($stdout)
logger.formatter = proc { |sev, time, _prog, msg| "[#{time.strftime('%H:%M:%S')}] #{sev}: #{msg}\n" }

# Step 1: Generate a secure deployment token
token = SecureRandom.urlsafe_base64(32)
logger.info("Deployment token generated: #{token[0..7]}...")

# Step 2: Build a safe shell command
target_dir = '/var/www/my app'  # space in path — dangerous!
command = Shellwords.shelljoin(['rsync', '-av', 'build/', target_dir])
logger.info("Running: #{command}")

# Step 3: Execute and check result
success = system(command)
if $CHILD_STATUS.success?  # English alias for $?
  logger.info('Deployment successful')
else
  logger.error("Deployment failed with status #{$CHILD_STATUS.exitstatus}")
end

# Usage: This pattern — log, secure, escape, check — is the foundation
# of every production Ruby script.

# This could also be done like this:
# Without these tools (fragile):
#
#   puts "Running rsync..."
#   system("rsync -av build/ #{target_dir}")  # breaks on spaces!
#   if $?.success?  # cryptic!
#
# Logger + SecureRandom + Shellwords + English = production-ready scripts.
#
# Thinking in Ruby
#
# This script demonstrates Ruby's "compose stdlib" philosophy — four standard
# libraries working together to build a production-grade CLI tool without a
# single external dependency. Logger for structured output, SecureRandom for
# secrets, Shellwords for safe command execution, and English for readable
# globals. This is the Ruby way: build real, secure tools using only what ships
# with the language.
