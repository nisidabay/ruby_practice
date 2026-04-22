#!/usr/bin/env ruby

# Proxy Pattern — Control Access to an Object
# Core Idea: Provide a surrogate or placeholder for another object to control access to it.
# Proxy adds a layer of indirection that can add functionality like lazy loading, access control, or logging.


# =============================================================================
# 1. THE SUBJECT INTERFACE
# =============================================================================
# Common interface for both RealSubject and Proxy.

class Database
  def query(sql); end
  def execute(sql); end
  def close; end
end


# =============================================================================
# 2. REAL SUBJECT
# =============================================================================
# The actual object that does the work.

class RealDatabase < Database
  def initialize(connection_string)
    puts "  [RealDatabase] Connecting to #{connection_string}..."
    sleep(0.5)  # Simulate connection delay
    @connected = true
    puts "  [RealDatabase] Connected!"
  end

  def query(sql)
    puts "  [RealDatabase] Executing query: #{sql}"
    sleep(0.1)  # Simulate query time
    [{ id: 1, name: "Result" }]
  end

  def execute(sql)
    puts "  [RealDatabase] Executing: #{sql}"
    sleep(0.1)
    1  # rows affected
  end

  def close
    puts "  [RealDatabase] Closing connection"
    @connected = false
  end
end


# =============================================================================
# 3. PROXY - LAZY LOADING
# =============================================================================
# Delays creation of the real object until needed.

class DatabaseProxy < Database
  def initialize(connection_string)
    @connection_string = connection_string
    @real_database = nil
  end

  def real_database
    @real_database ||= RealDatabase.new(@connection_string)
  end

  def query(sql)
    real_database.query(sql)
  end

  def execute(sql)
    real_database.execute(sql)
  end

  def close
    real_database.close if @real_database
  end
end


# =============================================================================
# 4. PROXY - ACCESS CONTROL
# =============================================================================
# Checks permissions before allowing access.

class ProtectedDatabase < Database
  def initialize(real_db, user_role)
    @real_db = real_db
    @user_role = user_role
  end

  def query(sql)
    if @user_role == :admin || sql.start_with?("SELECT")
      @real_db.query(sql)
    else
      puts "  [Access Denied] Role #{@user_role} cannot execute: #{sql}"
    end
  end

  def execute(sql)
    if @user_role == :admin
      @real_db.execute(sql)
    else
      puts "  [Access Denied] Role #{@user_role} cannot execute: #{sql}"
    end
  end

  def close
    @real_db.close
  end
end


# =============================================================================
# 5. PROXY - CACHING
# =============================================================================
# Caches results to avoid repeated expensive operations.

class CachingDatabase < Database
  def initialize(real_db)
    @real_db = real_db
    @cache = {}
    @cache_hits = 0
    @cache_misses = 0
  end

  def query(sql)
    if @cache.key?(sql)
      @cache_hits += 1
      puts "  [Cache] Hit for: #{sql}"
      @cache[sql]
    else
      @cache_misses += 1
      puts "  [Cache] Miss for: #{sql}"
      result = @real_db.query(sql)
      @cache[sql] = result
      result
    end
  end

  def execute(sql)
    # Don't cache writes, invalidate related cache
    @cache.clear
    @real_db.execute(sql)
  end

  def close
    @real_db.close
  end

  def stats
    total = @cache_hits + @cache_misses
    hit_rate = total > 0 ? (100.0 * @cache_hits / total).round(1) : 0
    puts "\n[Cache Stats] Hits: #{@cache_hits}, Misses: #{@cache_misses}"
    puts "  Hit rate: #{hit_rate}%"
  end
end


# =============================================================================
# 6. PROXY - LOGGING
# =============================================================================
# Logs all operations for debugging/auditing.

class LoggingDatabase < Database
  def initialize(real_db)
    @real_db = real_db
    @log = []
  end

  def query(sql)
    log_operation("QUERY", sql)
    @real_db.query(sql)
  end

  def execute(sql)
    log_operation("EXECUTE", sql)
    @real_db.execute(sql)
  end

  def close
    log_operation("CLOSE", "")
    @real_db.close
  end

  def log_operation(type, sql)
    entry = "[#{Time.now.strftime("%H:%M:%S")}] #{type}: #{sql}"
    @log << entry
    puts "  [LOG] #{entry}"
  end

  def print_log
    puts "\n[Database Log]"
    @log.each { |entry| puts "  #{entry}" }
  end
end


# =============================================================================
# 7. VIRTUAL PROXY - Image Loading
# =============================================================================

class Image
  def display; end
  def width; end
  def height; end
end

class RealImage < Image
  def initialize(filename)
    @filename = filename
    puts "  [RealImage] Loading #{@filename}..."
    sleep(0.3)  # Simulate loading from disk
    @width = 1920
    @height = 1080
    puts "  [RealImage] Loaded #{@filename} (#{@width}x#{@height})"
  end

  def display
    puts "  [Image] Displaying #{@filename}"
  end

  attr_reader :width, :height
end

class ImageProxy < Image
  def initialize(filename)
    @filename = filename
    @real_image = nil
  end

  def real_image
    @real_image ||= RealImage.new(@filename)
  end

  def display
    real_image.display
  end

  def width
    # Can provide metadata without loading full image
    @real_image ? @real_image.width : 1920  # Default/placeholder
  end

  def height
    @real_image ? @real_image.height : 1080
  end
end


# =============================================================================
# 8. REMOTE PROXY - API Client
# =============================================================================

class WeatherAPI
  def get_temperature(city); end
  def get_forecast(city); end
end

class RealWeatherAPI < WeatherAPI
  def get_temperature(city)
    puts "  [API] Fetching temperature for #{city}..."
    sleep(0.2)
    temp = rand(10..35)
    puts "  [API] #{city}: #{temp}°C"
    temp
  end

  def get_forecast(city)
    puts "  [API] Fetching forecast for #{city}..."
    sleep(0.2)
    { sunny: rand(0..10) > 5 }
  end
end

class RemoteWeatherProxy < WeatherAPI
  def initialize
    @api = RealWeatherAPI.new
    @cache = {}
  end

  def get_temperature(city)
    if @cache.key?(city) && (Time.now - @cache[city][:time]) < 300  # 5 min cache
      puts "  [Proxy] Using cached temperature for #{city}"
      @cache[city][:temp]
    else
      temp = @api.get_temperature(city)
      @cache[city] = { temp: temp, time: Time.now }
      temp
    end
  end

  def get_forecast(city)
    @api.get_forecast(city)
  end
end


# =============================================================================
# HOW TO USE IT
# =============================================================================

puts "=== Proxy Pattern Demo ===\n\n"

# Lazy loading proxy
puts "--- Lazy Loading Proxy ---"
proxy = DatabaseProxy.new("postgresql://localhost/mydb")
puts "Proxy created (database not connected yet)"

puts "\nFirst query (triggers connection):"
proxy.query("SELECT * FROM users")

puts "\nSecond query (connection already established):"
proxy.query("SELECT * FROM posts")

# Access control proxy
puts "\n--- Access Control Proxy ---"
real_db = RealDatabase.new("postgresql://localhost/mydb")
admin_db = ProtectedDatabase.new(real_db, :admin)
user_db = ProtectedDatabase.new(real_db, :user)

puts "\nAdmin operations:"
admin_db.query("SELECT * FROM users")
admin_db.execute("DELETE FROM logs")

puts "\nRegular user operations:"
user_db.query("SELECT * FROM users")
user_db.execute("DELETE FROM logs")  # Denied

# Caching proxy
puts "\n--- Caching Proxy ---"
real_db = RealDatabase.new("postgresql://localhost/mydb")
cached_db = CachingDatabase.new(real_db)

cached_db.query("SELECT * FROM users")
cached_db.query("SELECT * FROM users")  # Cached
cached_db.query("SELECT * FROM posts")
cached_db.query("SELECT * FROM users")  # Still cached
cached_db.stats

# Logging proxy
puts "\n--- Logging Proxy ---"
real_db = RealDatabase.new("postgresql://localhost/mydb")
logging_db = LoggingDatabase.new(real_db)

logging_db.query("SELECT 1")
logging_db.execute("UPDATE users SET active = true")
logging_db.query("SELECT * FROM logs")
logging_db.print_log

# Virtual proxy (images)
puts "\n--- Virtual Proxy (Image Loading) ---"
proxy = ImageProxy.new("photo.jpg")
puts "Proxy created (image not loaded)"

puts "\nGetting dimensions (no loading needed):"
puts "Dimensions: #{proxy.width}x#{proxy.height}"

puts "\nDisplaying (triggers loading):"
proxy.display

# Remote proxy
puts "\n--- Remote Proxy (API with Caching) ---"
weather = RemoteWeatherProxy.new

weather.get_temperature("NYC")
weather.get_temperature("NYC")  # Cached
weather.get_temperature("NYC")  # Cached
weather.get_temperature("LA")   # New city

puts "\n=== Key Takeaway ==="
puts "Proxy controls access to an object, adding functionality transparently."
puts "Types: Lazy Loading, Access Control, Caching, Logging, Remote, Virtual."
puts "Common uses: ORM lazy loading, API clients, access control, caching layers."
