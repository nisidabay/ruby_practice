#!/usr/bin/env ruby

# Strategy Pattern — Swap Algorithms at Runtime
# Core Idea: Define a family of algorithms, encapsulate each one, and make them
# interchangeable. The client can choose or swap strategies without changing
# the context class.


# =============================================================================
# 1. THE STRATEGY INTERFACE
# =============================================================================
# All strategies must implement this interface.

class PaymentStrategy
  def pay(amount)
    raise NotImplementedError, "Subclasses must implement pay()"
  end
end


# =============================================================================
# 2. CONCRETE STRATEGIES
# =============================================================================
# Each strategy implements a different payment method.

class CreditCardStrategy < PaymentStrategy
  def initialize(card_number, cvv)
    @card_number = card_number
    @cvv = cvv
  end

  def pay(amount)
    puts "Processing credit card payment: $#{amount}"
    puts "Card: ****-****-****-#{@card_number[-4..-1]}"
    puts "Payment successful!"
  end
end

class PayPalStrategy < PaymentStrategy
  def initialize(email)
    @email = email
  end

  def pay(amount)
    puts "Processing PayPal payment: $#{amount}"
    puts "Account: #{@email}"
    puts "Payment successful!"
  end
end

class CryptoStrategy < PaymentStrategy
  def initialize(wallet_address)
    @wallet_address = wallet_address
  end

  def pay(amount)
    puts "Processing crypto payment: $#{amount}"
    puts "Wallet: #{@wallet_address[0..8]}..."
    puts "Payment successful!"
  end
end


# =============================================================================
# 3. THE CONTEXT
# =============================================================================
# This class uses a strategy. The strategy can be swapped at runtime.

class ShoppingCart
  def initialize
    @items = []
    @payment_strategy = nil
  end

  def add_item(name, price)
    @items << { name: name, price: price }
    puts "Added: #{name} ($#{price})"
  end

  def total
    @items.sum { |item| item[:price] }
  end

  # Key feature: swap strategy anytime
  def set_payment_strategy(strategy)
    @payment_strategy = strategy
  end

  def checkout
    return puts "Error: No payment strategy set" unless @payment_strategy

    puts "\n--- Checkout ---"
    puts "Total: $#{total}"
    @payment_strategy.pay(total)
  end
end


# =============================================================================
# HOW TO USE IT
# =============================================================================

puts "=== Strategy Pattern Demo ===\n\n"

# Create cart
cart = ShoppingCart.new
cart.add_item("Laptop", 999)
cart.add_item("Mouse", 29)

# Strategy 1: Credit Card
puts "\n--- Using Credit Card ---"
cart.set_payment_strategy(CreditCardStrategy.new("1234567812345678", "123"))
cart.checkout

# Strategy 2: PayPal (swap at runtime)
puts "\n--- Using PayPal ---"
cart.set_payment_strategy(PayPalStrategy.new("user@example.com"))
cart.checkout

# Strategy 3: Crypto
puts "\n--- Using Crypto ---"
cart.set_payment_strategy(CryptoStrategy.new("1A1zP1eP5QGefi2DMPTfTL5SLmv7DivfNa"))
cart.checkout

puts "\n=== Key Takeaway ==="
puts "The ShoppingCart didn't change - only the strategy did."
puts "This is composition over inheritance in action."
