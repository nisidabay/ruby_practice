#!/usr/bin/env ruby

# Facade Pattern — Simplified Interface to a Complex Subsystem
# Core Idea: Provide a unified interface to a set of interfaces in a subsystem.
# Facade defines a higher-level interface that makes the subsystem easier to use.


# =============================================================================
# 1. THE COMPLEX SUBSYSTEM
# =============================================================================
# Multiple classes with complex interactions.

class AudioMixer
  def on
    puts "  [AudioMixer] Powered on"
  end

  def off
    puts "  [AudioMixer] Powered off"
  end

  def set_volume(level)
    puts "  [AudioMixer] Volume set to #{level}%"
  end

  def set_frequency(freq)
    puts "  [AudioMixer] Frequency set to #{freq}Hz"
  end
end

class VideoProcessor
  def initialize
    @brightness = 50
    @contrast = 50
    @resolution = "1080p"
  end

  def on
    puts "  [VideoProcessor] Initialized"
  end

  def off
    puts "  [VideoProcessor] Shut down"
  end

  def set_brightness(level)
    @brightness = level
    puts "  [VideoProcessor] Brightness: #{@brightness}%"
  end

  def set_contrast(level)
    @contrast = level
    puts "  [VideoProcessor] Contrast: #{@contrast}%"
  end

  def set_resolution(res)
    @resolution = res
    puts "  [VideoProcessor] Resolution: #{@resolution}"
  end
end

class StreamingService
  def initialize
    @connected = false
    @buffering = false
  end

  def connect(url)
    puts "  [StreamingService] Connecting to #{url}..."
    @connected = true
    puts "  [StreamingService] Connected!"
  end

  def disconnect
    puts "  [StreamingService] Disconnecting..."
    @connected = false
  end

  def start_streaming
    @buffering = true
    puts "  [StreamingService] Buffering..."
    sleep(0.1)
    @buffering = false
    puts "  [StreamingService] Streaming started"
  end

  def stop_streaming
    puts "  [StreamingService] Streaming stopped"
  end

  def set_quality(quality)
    puts "  [StreamingService] Quality: #{quality}"
  end
end

class SubtitleDecoder
  def load(file)
    puts "  [SubtitleDecoder] Loading #{file}..."
  end

  def enable(language)
    puts "  [SubtitleDecoder] #{language} subtitles enabled"
  end

  def disable
    puts "  [SubtitleDecoder] Subtitles disabled"
  end
end

class NetworkRouter
  def check_connection
    puts "  [NetworkRouter] Checking connection..."
    true
  end

  def prioritize_traffic(type)
    puts "  [NetworkRouter] Prioritizing #{type} traffic"
  end
end


# =============================================================================
# 2. THE FACADE
# =============================================================================
# Simplified interface that coordinates the subsystem.

class HomeTheaterFacade
  def initialize
    @audio = AudioMixer.new
    @video = VideoProcessor.new
    @streaming = StreamingService.new
    @subtitles = SubtitleDecoder.new
    @network = NetworkRouter.new
  end

  def watch_movie(url, quality = "HD")
    puts "\n[HomeTheater] Preparing to watch movie...\n"
    
    # Complex setup hidden from client
    @network.check_connection
    @network.prioritize_traffic("streaming")
    
    @video.on
    @video.set_brightness(60)
    @video.set_contrast(70)
    @video.set_resolution(quality == "4K" ? "2160p" : "1080p")
    
    @audio.on
    @audio.set_volume(75)
    @audio.set_frequency(44100)
    
    @streaming.connect(url)
    @streaming.set_quality(quality)
    @streaming.start_streaming
    
    puts "[HomeTheater] Ready! Enjoy your movie!\n"
  end

  def enable_subtitles(file, language = "English")
    @subtitles.load(file)
    @subtitles.enable(language)
  end

  def disable_subtitles
    @subtitles.disable
  end

  def end_movie
    puts "\n[HomeTheater] Shutting down...\n"
    @streaming.stop_streaming
    @streaming.disconnect
    @audio.off
    @video.off
    puts "[HomeTheater] System off\n"
  end

  def quick_start(url)
    # Even simpler method for common use case
    watch_movie(url, "HD")
  end
end


# =============================================================================
# 3. REAL-WORLD EXAMPLE: Database Facade
# =============================================================================

class DBConnection
  def open(config)
    puts "  [DB] Opening connection to #{config[:host]}..."
  end

  def close
    puts "  [DB] Closing connection"
  end

  def execute(sql)
    puts "  [DB] Executing: #{sql}"
    []
  end
end

class DBTransaction
  def begin
    puts "  [Transaction] Beginning transaction"
  end

  def commit
    puts "  [Transaction] Committing"
  end

  def rollback
    puts "  [Transaction] Rolling back"
  end
end

class DBCache
  def get(key)
    puts "  [Cache] Getting: #{key}"
    nil
  end

  def set(key, value)
    puts "  [Cache] Setting: #{key}"
  end

  def clear
    puts "  [Cache] Cleared"
  end
end

class Database
  def initialize
    @connection = DBConnection.new
    @transaction = DBTransaction.new
    @cache = DBCache.new
  end

  def connect(config = { host: "localhost", port: 5432 })
    @connection.open(config)
  end

  def disconnect
    @connection.close
  end

  def query(sql, use_cache: true)
    if use_cache
      cached = @cache.get(sql)
      return cached if cached
    end

    @transaction.begin
    result = @connection.execute(sql)
    @transaction.commit
    @cache.set(sql, result) if use_cache
    result
  end

  def transactional(&block)
    @transaction.begin
    begin
      yield self
      @transaction.commit
    rescue => e
      @transaction.rollback
      raise e
    end
  end
end


# =============================================================================
# 4. REAL-WORLD EXAMPLE: Email Facade
# =============================================================================

class SMTPClient
  def connect(server, port)
    puts "  [SMTP] Connecting to #{server}:#{port}"
  end

  def authenticate(user, pass)
    puts "  [SMTP] Authenticating as #{user}"
  end

  def send(from, to, subject, body)
    puts "  [SMTP] Sending email from #{from} to #{to}"
  end

  def disconnect
    puts "  [SMTP] Disconnecting"
  end
end

class TemplateEngine
  def render(template, data)
    puts "  [Template] Rendering #{template}"
    "Rendered content with #{data.keys.join(", ")}"
  end
end

class AttachmentHandler
  def attach(file)
    puts "  [Attachments] Adding #{file}"
  end

  def validate_size(size)
    puts "  [Attachments] Validating size: #{size} bytes"
    size < 25_000_000
  end
end

class EmailService
  def initialize
    @smtp = SMTPClient.new
    @templates = TemplateEngine.new
    @attachments = AttachmentHandler.new
  end

  def send_email(to, subject, template, data, attachments: [])
    @smtp.connect("smtp.example.com", 587)
    @smtp.authenticate("user@example.com", "password")

    content = @templates.render(template, data)

    attachments.each do |file|
      size = begin
        File.size(file)
      rescue
        1000
      end
      if @attachments.validate_size(size)
        @attachments.attach(file)
      end
    end

    @smtp.send("user@example.com", to, subject, content)
    @smtp.disconnect

    puts "[EmailService] Email sent to #{to}\n"
  end

  def quick_email(to, subject, body)
    send_email(to, subject, :simple, { body: body })
  end
end


# =============================================================================
# HOW TO USE IT
# =============================================================================

puts "=== Facade Pattern Demo ===\n\n"

# Home theater example
puts "--- Home Theater Facade ---"
theater = HomeTheaterFacade.new

# Without facade, client would need to coordinate 5+ classes
# With facade, it's one simple call
theater.watch_movie("https://netflix.com/movie/123", "4K")
theater.enable_subtitles("movie.srt", "Spanish")
theater.end_movie

# Quick start for common case
theater.quick_start("https://youtube.com/watch/456")

# Database example
puts "\n--- Database Facade ---"
db = Database.new
db.connect

# Complex operations simplified
result = db.query("SELECT * FROM users WHERE active = true")
puts "Found #{result.length} users"

# Transactional operations
db.transactional do |txn|
  txn.query("INSERT INTO users (name) VALUES ('Alice')")
  txn.query("UPDATE accounts SET balance = balance - 100 WHERE id = 1")
  txn.query("UPDATE accounts SET balance = balance + 100 WHERE id = 2")
end

db.disconnect

# Email example
puts "\n--- Email Facade ---"
email = EmailService.new
email.quick_email("friend@example.com", "Hello!", "Just wanted to say hi!")

puts "\n=== Key Takeaway ==="
puts "Facade provides a simple interface to complex subsystems."
puts "Clients don't need to know about multiple classes and their interactions."
puts "Common uses: API wrappers, initialization helpers, simplified interfaces."
