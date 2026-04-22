#!/usr/bin/env ruby

# Singleton Pattern — Ensure Only One Instance Exists
# Core Idea: Ensure a class has only one instance and provide a global point of access to it.
# Useful for shared resources like database connections, configuration, or logging.


# =============================================================================
# 1. CLASSIC SINGLETON (Thread-Safe)
# =============================================================================

class Logger
  private_class_method :new

  def self.instance
    @instance ||= new
  end

  def initialize
    @logs = []
    puts "  [Logger] Created singleton instance"
  end

  def log(message)
    entry = "[#{Time.now.strftime("%H:%M:%S")}] #{message}"
    @logs << entry
    puts "  #{entry}"
  end

  def logs
    @logs.dup
  end

  def clear
    @logs.clear
  end
end


# =============================================================================
# 2. CONFIGURATION SINGLETON
# =============================================================================

class Configuration
  private_class_method :new

  def self.instance
    @instance ||= new
  end

  def initialize
    @settings = {
      app_name: "MyApp",
      version: "1.0.0",
      debug: false,
      max_connections: 100
    }
    puts "  [Configuration] Loaded settings"
  end

  def get(key)
    @settings[key]
  end

  def set(key, value)
    @settings[key] = value
    puts "  [Configuration] Set #{key} = #{value}"
  end

  def all
    @settings.dup
  end

  def load_from_file(path)
    puts "  [Configuration] Loading from #{path}"
    # In real code: YAML.load_file(path)
  end
end


# =============================================================================
# 3. DATABASE CONNECTION POOL (Singleton + Pool)
# =============================================================================

class DatabaseConnection
  private_class_method :new

  def self.instance
    @instance ||= new
  end

  def initialize
    @connected = false
    @query_count = 0
    puts "  [Database] Initializing connection pool"
  end

  def connect
    return if @connected
    puts "  [Database] Connecting to database..."
    sleep(0.1)
    @connected = true
    puts "  [Database] Connected!"
  end

  def query(sql)
    connect unless @connected
    @query_count += 1
    puts "  [Database] Executing query ##{@query_count}: #{sql}"
    []
  end

  def disconnect
    puts "  [Database] Disconnecting..."
    @connected = false
  end

  def stats
    { connected: @connected, queries: @query_count }
  end
end


# =============================================================================
# 4. MULTI-SINGLETON (Limited Instances)
# =============================================================================

class ThreadPool
  private_class_method :new

  def self.instance(size = 4)
    @instances ||= {}
    @instances[size] ||= new(size)
  end

  def initialize(size)
    @size = size
    @workers = []
    puts "  [ThreadPool] Created pool with #{size} workers"
  end

  def submit(task)
    puts "  [ThreadPool] Submitting task: #{task}"
    # In real code: assign to worker
  end

  attr_reader :size
end


# =============================================================================
# 5. REGISTRY PATTERN (Alternative to Singleton)
# =============================================================================
# Often better than singleton - explicit dependencies

class ServiceRegistry
  def initialize
    @services = {}
  end

  def register(name, service)
    @services[name] = service
    puts "  [Registry] Registered #{name}"
  end

  def get(name)
    @services[name] or raise "Service not found: #{name}"
  end

  def has?(name)
    @services.key?(name)
  end
end

# Global registry instance (but explicit)
$registry = ServiceRegistry.new


# =============================================================================
# HOW TO USE IT
# =============================================================================

puts "=== Singleton Pattern Demo ===\n\n"

# Logger singleton
puts "--- Logger Singleton ---"
logger1 = Logger.instance
logger2 = Logger.instance

puts "logger1.object_id: #{logger1.object_id}"
puts "logger2.object_id: #{logger2.object_id}"
puts "Same instance? #{logger1.object_id == logger2.object_id}"

logger1.log("Application started")
logger2.log("User logged in")

puts "\nTotal logs: #{logger1.logs.length}"

# Configuration singleton
puts "\n--- Configuration Singleton ---"
config = Configuration.instance
puts "App name: #{config.get(:app_name)}"
puts "Version: #{config.get(:version)}"

config.set(:debug, true)
puts "Debug mode: #{config.get(:debug)}"

# Database singleton
puts "\n--- Database Connection Singleton ---"
db1 = DatabaseConnection.instance
db2 = DatabaseConnection.instance

puts "Same instance? #{db1.object_id == db2.object_id}"

db1.query("SELECT 1")
db2.query("SELECT 2")

puts "Stats: #{db1.stats}"

# Multiple singleton instances (by size)
puts "\n--- Multi-Singleton (Thread Pools) ---"
pool4 = ThreadPool.instance(4)
pool8 = ThreadPool.instance(8)
pool4_again = ThreadPool.instance(4)

puts "Pool(4) object_id: #{pool4.object_id}"
puts "Pool(8) object_id: #{pool8.object_id}"
puts "Pool(4) again object_id: #{pool4_again.object_id}"
puts "Same pool(4)? #{pool4.object_id == pool4_again.object_id}"

# Registry pattern (better alternative)
puts "\n--- Registry Pattern (Singleton Alternative) ---"
$registry.register(:logger, Logger.instance)
$registry.register(:config, Configuration.instance)
$registry.register(:db, DatabaseConnection.instance)

puts "Has logger? #{$registry.has?(:logger)}"
puts "Has db? #{$registry.has?(:db)}"
puts "Has cache? #{$registry.has?(:cache)}"

# Get services explicitly
logger = $registry.get(:logger)
logger.log("Retrieved from registry")

puts "\n=== Key Takeaway ==="
puts "Singleton ensures only one instance exists globally."
puts "Use for: shared resources, configuration, logging, caching."
puts "Warning: Can make testing harder. Consider dependency injection instead."
