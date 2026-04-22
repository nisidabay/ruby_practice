#!/usr/bin/env ruby

# Chain of Responsibility Pattern — Pass Requests Along a Handler Chain
# Core Idea: Pass a request along a chain of handlers. Each handler decides
# whether to process the request or pass it to the next handler.


# =============================================================================
# 1. THE HANDLER INTERFACE
# =============================================================================
# All handlers must implement handle and set_next.

class Handler
  def initialize
    @next_handler = nil
  end

  def set_next(handler)
    @next_handler = handler
    handler
  end

  def handle(request)
    if @next_handler
      @next_handler.handle(request)
    else
      puts "  [Request '#{request}' could not be handled]"
    end
  end
end


# =============================================================================
# 2. CONCRETE HANDLERS
# =============================================================================
# Each handler processes what it can, or passes to the next.

class LoggingHandler < Handler
  def handle(request)
    puts "[LOG] Received request: #{request}"
    super
  end
end

class AuthenticationHandler < Handler
  def handle(request)
    if request.start_with?("auth:")
      token = request.sub("auth:", "")
      if valid_token?(token)
        puts "  [AUTH] Token '#{token}' is valid - granting access"
        return
      else
        puts "  [AUTH] Token '#{token}' is invalid - rejecting"
        return
      end
    end
    super
  end

  private

  def valid_token?(token)
    ["valid123", "admin456", "user789"].include?(token)
  end
end

class AuthorizationHandler < Handler
  def handle(request)
    if request.start_with?("admin:")
      token = request.sub("admin:", "")
      if admin_token?(token)
        puts "  [AUTHZ] Admin access granted for '#{token}'"
        return
      else
        puts "  [AUTHZ] Admin access denied for '#{token}'"
        return
      end
    end
    super
  end

  private

  def admin_token?(token)
    token.start_with?("admin")
  end
end

class RateLimitHandler < Handler
  def initialize(max_requests = 5)
    super()
    @request_count = 0
    @max_requests = max_requests
  end

  def handle(request)
    @request_count += 1
    if @request_count > @max_requests
      puts "  [RATE LIMIT] Exceeded limit (#{@request_count}/#{@max_requests}) - rejecting '#{request}'"
      return
    end
    puts "  [RATE LIMIT] Request #{@request_count}/#{@max_requests}: '#{request}'"
    super
  end
end

class CacheHandler < Handler
  def initialize
    super()
    @cache = {}
  end

  def handle(request)
    if @cache.key?(request)
      puts "  [CACHE] Hit for '#{request}' - returning cached response"
      return
    end
    puts "  [CACHE] Miss for '#{request}' - computing response"
    @cache[request] = "Response for #{request}"
    super
  end
end

class BusinessLogicHandler < Handler
  def handle(request)
    puts "  [BUSINESS] Processing request: #{request}"
    puts "  [BUSINESS] Request completed successfully!"
    # This is the end of the chain - request is handled
  end
end


# =============================================================================
# 3. REQUEST OBJECT (Optional but useful for complex requests)
# =============================================================================

class Request
  attr_reader :type, :data, :priority

  def initialize(type, data, priority = :normal)
    @type = type
    @data = data
    @priority = priority
  end

  def to_s
    "#{@type}: #{@data} (priority: #{@priority})"
  end
end


# =============================================================================
# 4. HANDLER WITH REQUEST OBJECT
# =============================================================================

class PriorityHandler < Handler
  def handle(request)
    if request.is_a?(Request) && request.priority == :high
      puts "  [PRIORITY] High priority request - fast tracking"
      # Handle immediately
      return
    end
    super
  end
end

class TypeHandler < Handler
  def handle(request)
    if request.is_a?(Request)
      case request.type
      when :query
        puts "  [TYPE] Processing query: #{request.data}"
        return
      when :command
        puts "  [TYPE] Executing command: #{request.data}"
        return
      end
    end
    super
  end
end


# =============================================================================
# HOW TO USE IT
# =============================================================================

puts "=== Chain of Responsibility Pattern Demo ===\n\n"

# Build the chain
puts "--- Building Handler Chain ---"
logging = LoggingHandler.new
auth = AuthenticationHandler.new
authz = AuthorizationHandler.new
rate_limit = RateLimitHandler.new(3)
cache = CacheHandler.new
business = BusinessLogicHandler.new

# Chain them together
logging.set_next(auth).set_next(authz).set_next(rate_limit).set_next(cache).set_next(business)

puts "\n--- Test 1: Valid Auth Request ---"
logging.handle("auth:valid123")

puts "\n--- Test 2: Invalid Auth Request ---"
logging.handle("auth:badtoken")

puts "\n--- Test 3: Admin Request ---"
logging.handle("admin:admin999")

puts "\n--- Test 4: Regular Request (goes through full chain) ---"
logging.handle("get:users")

puts "\n--- Test 5: Cache Hit ---"
logging.handle("get:users")  # Should hit cache

puts "\n--- Test 6: Rate Limit Exceeded ---"
logging.handle("get:posts")
logging.handle("get:comments")
logging.handle("get:likes")
logging.handle("get:shares")  # Should be rate limited

puts "\n=== Real-World Example: Support Ticket System ==="

class SupportHandler < Handler
  def handle(ticket)
    if ticket.is_a?(Hash) && ticket[:category] == @category
      puts "  [#{@category.upcase}] Handling ticket: #{ticket[:issue]}"
      puts "  [#{@category.upcase}] Resolution: #{ticket[:resolution]}"
      return
    end
    super
  end

  protected

  attr_reader :category
end

class TechSupport < SupportHandler
  def initialize
    super()
    @category = :technical
  end
end

class BillingSupport < SupportHandler
  def initialize
    super()
    @category = :billing
  end
end

class GeneralSupport < SupportHandler
  def initialize
    super()
    @category = :general
  end

  def handle(ticket)
    if ticket.is_a?(Hash)
      puts "  [GENERAL] Handling ticket: #{ticket[:issue]}"
      puts "  [GENERAL] Escalating to human agent"
      return
    end
    super
  end
end

# Build support chain
tech = TechSupport.new
billing = BillingSupport.new
general = GeneralSupport.new

tech.set_next(billing).set_next(general)

tickets = [
  { category: :technical, issue: "Can't login", resolution: "Reset password" },
  { category: :billing, issue: "Overcharged", resolution: "Issue refund" },
  { category: :general, issue: "Feature request", resolution: "Forward to product team" },
  { category: :unknown, issue: "???", resolution: "N/A" }
]

tickets.each do |ticket|
  puts "\nProcessing ticket: #{ticket[:category]} - #{ticket[:issue]}"
  tech.handle(ticket)
end

puts "\n=== Key Takeaway ==="
puts "Chain of Responsibility decouples sender from receivers."
puts "Each handler processes or passes along - no need to know the full chain."
puts "Common uses: middleware, event propagation, approval workflows."
