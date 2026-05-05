#!/usr/bin/env ruby
# frozen_string_literal: true

# private_class_method.rb — singleton with private .new

class SecretVault
  MASTER_KEY = 'sesame'.freeze

  private_class_method :new

  def self.open_special_vault(key)
    if key == MASTER_KEY
      vault = new
      puts '🔓 Vault opened successfully!'
      vault
    else
      puts '☠ Invalid key! Access denied'
      nil
    end
  end

  def contents
    'Gold coins, ancient scrolls, and a map to Atlantis'.freeze
  end

  def lock
    puts '🔒 Vault is now locked'
  end
end

vault = SecretVault.open_special_vault('sesame')
if vault
  puts "Contents: #{vault.contents}"
  vault.lock
end

SecretVault.open_special_vault('let me in')  # => nil + denied msg

