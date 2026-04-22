#!/usr/bin/env ruby

# Adapter Pattern — Make Incompatible Interfaces Work Together
# Core Idea: Convert the interface of a class into another interface clients expect.
# Adapter lets classes work together that couldn't otherwise because of incompatible interfaces.


# =============================================================================
# 1. THE TARGET INTERFACE
# =============================================================================
# This is what the client expects to work with.

class AudioPlayer
  def play(file_name)
    # Only supports mp3 natively
    if file_name.end_with?(".mp3")
      puts "Playing MP3: #{file_name}"
    else
      puts "Unsupported format: #{file_name}"
    end
  end
end


# =============================================================================
# 2. THE ADAPTEE
# =============================================================================
# This is the existing class with an incompatible interface.

class AdvancedMediaPlayer
  def play_vlc(file_name)
    puts "Playing VLC: #{file_name}"
  end

  def play_mp4(file_name)
    puts "Playing MP4: #{file_name}"
  end
end


# =============================================================================
# 3. THE ADAPTER
# =============================================================================
# This wraps the Adaptee and makes it compatible with the Target.

class MediaAdapter
  def initialize(file_type)
    @advanced_player = AdvancedMediaPlayer.new
    @file_type = file_type
  end

  def play(file_name)
    case @file_type
    when "vlc"
      @advanced_player.play_vlc(file_name)
    when "mp4"
      @advanced_player.play_mp4(file_name)
    else
      puts "Unknown format: #{@file_type}"
    end
  end
end


# =============================================================================
# 4. THE ADAPTED CLIENT
# =============================================================================
# This extends the original client to use the adapter.

class UniversalPlayer < AudioPlayer
  def play(file_name)
    if file_name.end_with?(".mp3")
      super
    elsif file_name.end_with?(".vlc")
      adapter = MediaAdapter.new("vlc")
      adapter.play(file_name)
    elsif file_name.end_with?(".mp4")
      adapter = MediaAdapter.new("mp4")
      adapter.play(file_name)
    else
      puts "Unknown format: #{file_name}"
    end
  end
end


# =============================================================================
# 5. REAL-WORLD EXAMPLE: Payment Gateway Adapter
# =============================================================================

# Legacy payment system (Adaptee)
class PayPalGateway
  def make_payment(amount, currency)
    puts "[PayPal] Processing #{amount} #{currency}..."
    { transaction_id: "PP-#{rand(10000)}", status: "success" }
  end

  def get_exchange_rate(from, to)
    puts "[PayPal] Getting exchange rate #{from} -> #{to}"
    1.1
  end
end

# Modern payment interface (Target)
class PaymentProcessor
  def process(amount, currency)
    raise NotImplementedError
  end

  def refund(transaction_id)
    raise NotImplementedError
  end
end

# Adapter to make PayPal work with modern interface
class PayPalAdapter < PaymentProcessor
  def initialize
    @paypal = PayPalGateway.new
  end

  def process(amount, currency)
    result = @paypal.make_payment(amount, currency)
    {
      id: result[:transaction_id],
      success: result[:status] == "success"
    }
  end

  def refund(transaction_id)
    puts "[PayPal] Refunding transaction #{transaction_id}"
    { success: true }
  end
end

# Another payment gateway (Stripe-like)
class StripeGateway
  def charge(card_number, amount, currency)
    puts "[Stripe] Charging card ending #{card_number[-4..-1]}: #{amount} #{currency}"
    { charge_id: "ch_#{rand(10000)}", paid: true }
  end

  def capture(charge_id)
    puts "[Stripe] Capturing charge #{charge_id}"
    { captured: true }
  end
end

# Adapter for Stripe
class StripeAdapter < PaymentProcessor
  def initialize
    @stripe = StripeGateway.new
    @pending_charges = {}
  end

  def process(amount, currency, card_number = "****1234")
    result = @stripe.charge(card_number, amount, currency)
    @pending_charges[result[:charge_id]] = result
    {
      id: result[:charge_id],
      success: result[:paid]
    }
  end

  def refund(transaction_id)
    puts "[Stripe] Refunding charge #{transaction_id}"
    { success: true }
  end

  def capture(transaction_id)
    @stripe.capture(transaction_id)
  end
end


# =============================================================================
# 6. CLASS ADAPTER VS OBJECT ADAPTER
# =============================================================================

# Class Adapter (uses inheritance - less flexible)
class ClassAdapter < AdvancedMediaPlayer
  def play(file_name)
    if file_name.end_with?(".vlc")
      play_vlc(file_name)
    elsif file_name.end_with?(".mp4")
      play_mp4(file_name)
    end
  end
end

# Object Adapter (uses composition - more flexible, preferred)
# This is what MediaAdapter does above


# =============================================================================
# HOW TO USE IT
# =============================================================================

puts "=== Adapter Pattern Demo ===\n\n"

# Basic media player example
puts "--- Media Player Adapter ---"
player = UniversalPlayer.new
player.play("song.mp3")   # Native support
player.play("movie.vlc")  # Via adapter
player.play("video.mp4")  # Via adapter
player.play("file.xyz")   # Unsupported

# Payment processor example
puts "\n--- Payment Gateway Adapter ---"
orders = [
  { amount: 99.99, currency: "USD", gateway: :paypal },
  { amount: 149.50, currency: "EUR", gateway: :stripe },
  { amount: 29.99, currency: "GBP", gateway: :paypal }
]

adapters = {
  paypal: PayPalAdapter.new,
  stripe: StripeAdapter.new
}

orders.each do |order|
  puts "\nProcessing order: #{order[:amount]} #{order[:currency]}"
  adapter = adapters[order[:gateway]]
  result = adapter.process(order[:amount], order[:currency])
  puts "Result: #{result}"
end

# Class adapter example
puts "\n--- Class Adapter (Inheritance-based) ---"
class_adapter = ClassAdapter.new
class_adapter.play("movie.vlc")
class_adapter.play("video.mp4")

puts "\n=== Key Takeaway ==="
puts "Adapter converts one interface to another."
puts "Object Adapter (composition) is preferred over Class Adapter (inheritance)."
puts "Common uses: Legacy system integration, third-party libraries, API wrappers."
