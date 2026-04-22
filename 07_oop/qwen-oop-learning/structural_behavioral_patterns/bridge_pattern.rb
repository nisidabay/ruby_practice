#!/usr/bin/env ruby

# Bridge Pattern — Separate Abstraction from Implementation
# Core Idea: Decouple an abstraction from its implementation so the two can vary independently.
# Use composition instead of inheritance to avoid class explosion.


# =============================================================================
# 1. THE IMPLEMENTATION INTERFACE
# =============================================================================
# This defines what the abstraction can do with the implementation.

class Device
  def turn_on; end
  def turn_off; end
  def volume_up; end
  def volume_down; end
  def channel_up; end
  def channel_down; end

  attr_reader :volume, :channel, :is_on
end


# =============================================================================
# 2. CONCRETE IMPLEMENTATIONS
# =============================================================================
# Different devices with different behaviors.

class TV < Device
  def initialize
    @volume = 50
    @channel = 1
    @is_on = false
  end

  def turn_on
    @is_on = true
    puts "  [TV] Powered on"
  end

  def turn_off
    @is_on = false
    puts "  [TV] Powered off"
  end

  def volume_up
    @volume = [@volume + 5, 100].min
    puts "  [TV] Volume: #{@volume}"
  end

  def volume_down
    @volume = [@volume - 5, 0].max
    puts "  [TV] Volume: #{@volume}"
  end

  def channel_up
    @channel += 1
    puts "  [TV] Channel: #{@channel}"
  end

  def channel_down
    @channel = [@channel - 1, 1].max
    puts "  [TV] Channel: #{@channel}"
  end
end

class Radio < Device
  def initialize
    @volume = 30
    @channel = 88.0  # FM frequency
    @is_on = false
  end

  def turn_on
    @is_on = true
    puts "  [Radio] Powered on"
  end

  def turn_off
    @is_on = false
    puts "  [Radio] Powered off"
  end

  def volume_up
    @volume = [@volume + 5, 100].min
    puts "  [Radio] Volume: #{@volume}"
  end

  def volume_down
    @volume = [@volume - 5, 0].max
    puts "  [Radio] Volume: #{@volume}"
  end

  def channel_up
    @channel = [@channel + 0.5, 108.0].min
    puts "  [Radio] Frequency: #{@channel} FM"
  end

  def channel_down
    @channel = [@channel - 0.5, 87.5].max
    puts "  [Radio] Frequency: #{@channel} FM"
  end
end


# =============================================================================
# 3. THE ABSTRACTION
# =============================================================================
# This holds a reference to the implementation (the bridge).

class RemoteControl
  def initialize(device)
    @device = device
  end

  def power
    if @device.is_on
      @device.turn_off
    else
      @device.turn_on
    end
  end

  def volume_up
    @device.volume_up
  end

  def volume_down
    @device.volume_down
  end

  def channel_up
    @device.channel_up
  end

  def channel_down
    @device.channel_down
  end

  def device_info
    type = @device.class.name
    status = @device.is_on ? "ON" : "OFF"
    puts "  Device: #{type}, Status: #{status}"
  end
end


# =============================================================================
# 4. EXTENDED ABSTRACTION
# =============================================================================
# Add features without changing implementations.

class AdvancedRemote < RemoteControl
  def mute
    puts "  [Remote] Muting..."
    # Store volume before mute
    @muted_volume = @device.volume
    # Set volume to 0 (would need device support)
    8.times { @device.volume_down }
  end

  def unmute
    puts "  [Remote] Unmuting..."
    # Restore volume (simplified)
    8.times { @device.volume_up }
  end

  def channel_list
    puts "  [Remote] Available channels:"
    5.times do
      @device.channel_up
    end
  end

  def favorite_channel(num)
    puts "  [Remote] Jumping to favorite channel #{num}"
    # Could implement direct channel access
  end
end


# =============================================================================
# 5. REAL-WORLD EXAMPLE: Database Abstraction
# =============================================================================

# Implementation: Different database drivers
class DatabaseDriver
  def connect; end
  def disconnect; end
  def query(sql); end
  def execute(sql); end
end

class MySQLDriver < DatabaseDriver
  def connect
    puts "  [MySQL] Connecting to database..."
  end

  def disconnect
    puts "  [MySQL] Disconnecting..."
  end

  def query(sql)
    puts "  [MySQL] Query: #{sql}"
    [{ id: 1, name: "Result" }]
  end

  def execute(sql)
    puts "  [MySQL] Execute: #{sql}"
    1  # rows affected
  end
end

class PostgreSQLDriver < DatabaseDriver
  def connect
    puts "  [PostgreSQL] Connecting to database..."
  end

  def disconnect
    puts "  [PostgreSQL] Disconnecting..."
  end

  def query(sql)
    puts "  [PostgreSQL] Query: #{sql}"
    [{ id: 1, name: "Result" }]
  end

  def execute(sql)
    puts "  [PostgreSQL] Execute: #{sql}"
    1  # rows affected
  end
end

# Abstraction: Database operations
class Database
  def initialize(driver)
    @driver = driver
  end

  def connect
    @driver.connect
  end

  def disconnect
    @driver.disconnect
  end

  def find_by_id(id)
    @driver.query("SELECT * FROM table WHERE id = #{id}")
  end

  def insert(table, data)
    columns = data.keys.join(", ")
    values = data.values.map { |v| "'#{v}'" }.join(", ")
    @driver.execute("INSERT INTO #{table} (#{columns}) VALUES (#{values})")
  end
end

# Extended abstraction with caching
class CachedDatabase < Database
  def initialize(driver)
    super
    @cache = {}
  end

  def find_by_id(id)
    if @cache.key?(id)
      puts "  [Cache] Hit for id=#{id}"
      @cache[id]
    else
      puts "  [Cache] Miss for id=#{id}"
      result = super
      @cache[id] = result
      result
    end
  end

  def invalidate_cache
    @cache.clear
    puts "  [Cache] Cleared"
  end
end


# =============================================================================
# HOW TO USE IT
# =============================================================================

puts "=== Bridge Pattern Demo ===\n\n"

# Remote control example
puts "--- Remote Control Bridge ---"

# Same remote, different devices
tv_remote = RemoteControl.new(TV.new)
radio_remote = RemoteControl.new(Radio.new)

puts "\nUsing TV:"
tv_remote.device_info
tv_remote.power
tv_remote.volume_up
tv_remote.channel_up

puts "\nUsing Radio:"
radio_remote.device_info
radio_remote.power
radio_remote.volume_up
radio_remote.channel_up

# Advanced remote with same devices
puts "\n--- Advanced Remote ---"
advanced_tv = AdvancedRemote.new(TV.new)
advanced_tv.power
advanced_tv.mute
advanced_tv.unmute
advanced_tv.channel_list

# Database example
puts "\n--- Database Bridge ---"
mysql_db = CachedDatabase.new(MySQLDriver.new)
postgres_db = CachedDatabase.new(PostgreSQLDriver.new)

puts "\nMySQL operations:"
mysql_db.connect
mysql_db.find_by_id(1)  # Cache miss
mysql_db.find_by_id(1)  # Cache hit
mysql_db.insert("users", { name: "Alice", email: "alice@example.com" })
mysql_db.disconnect

puts "\nPostgreSQL operations:"
postgres_db.connect
postgres_db.find_by_id(42)
postgres_db.insert("products", { name: "Widget", price: "9.99" })
postgres_db.disconnect

puts "\n=== Key Takeaway ==="
puts "Bridge separates abstraction (Remote) from implementation (Device)."
puts "You can add new remotes without changing devices, and vice versa."
puts "Without Bridge: N×M classes. With Bridge: N + M classes."
puts "This is composition over inheritance at a structural level."
