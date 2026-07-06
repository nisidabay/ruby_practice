#!/usr/bin/env ruby
# frozen_string_literal: true

# Problem: You need cryptographically random values — tokens, passwords, UUIDs.
# Example: Generate an API key that can't be guessed.
#
# Solution: SecureRandom (stdlib) — uses OS entropy, not Ruby's pseudo-random rand.
# Visibility: `require 'securerandom'`. Never use `rand` for security.

require 'securerandom'

# Random hex string (good for API keys)
api_key = SecureRandom.hex(16)  # 32 hex chars
puts "API key: #{api_key}"

# URL-safe base64 (good for tokens in URLs)
token = SecureRandom.urlsafe_base64(24)  # 32 chars, no + or /
puts "Token: #{token}"

# UUID v4 (random)
uuid = SecureRandom.uuid
puts "UUID: #{uuid}"

# Random number from a range
code = SecureRandom.random_number(100_000..999_999)
puts "6-digit code: #{code}"

# Usage: Random bytes
bytes = SecureRandom.random_bytes(8)
puts "Random bytes: #{bytes.unpack1('H*')}"  # hex representation

# This could also be done like this:
# rand — NOT cryptographically secure:
#
#   api_key = rand(36**32).to_s(36)  # predictable!
#
# rand uses a PRNG — given the same seed, same output. SecureRandom
# uses /dev/urandom (OS entropy) — unpredictable even with the same seed.
#
# Thinking in Ruby
#
# Ruby draws a clear line between "random" and "secure" — rand() for games and
# simulations, SecureRandom for cryptography. This separation is critical because
# developers who reach for rand() for security tokens won't accidentally produce
# predictable output. SecureRandom wraps OS-level entropy directly, giving Ruby
# scripts access to the same cryptographic primitives that power HTTPS and SSH.
