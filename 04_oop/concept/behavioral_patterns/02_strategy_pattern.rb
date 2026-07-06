#!/usr/bin/env ruby

# Problem: You want to swap algorithms at runtime without changing the class that uses them.
# Example: A shopping cart that can pay with Credit Card, PayPal, or Crypto - chosen by the user.
#
# Solution: Encapsulate each algorithm in a separate strategy class and swap them dynamically.
# Visibility: Strategies are interchangeable, context doesn't know which one it's using.

class CreditCardPayment
  def pay(amount)
    puts "💳 Processing credit card: $#{amount}"
    puts "Payment successful!"
  end
end

class PayPalPayment
  def pay(amount)
    puts "🅿️ Processing PayPal: $#{amount}"
    puts "Payment successful!"
  end
end

class CryptoPayment
  def pay(amount)
    puts "₿ Processing crypto: $#{amount}"
    puts "Payment successful!"
  end
end

class ShoppingCart
  def initialize
    @items = []
    @payment_method = nil
  end

  def add_item(name, price)
    @items << { name: name, price: price }
  end

  def total
    @items.sum { |item| item[:price] }
  end

  def set_payment(method)
    @payment_method = method
  end

  def checkout
    return puts "Error: No payment method set" unless @payment_method

    puts "--- Checkout ---"
    puts "Total: $#{total}"
    @payment_method.pay(total)
  end
end

# Usage: Create cart and swap payment strategies
cart = ShoppingCart.new
cart.add_item("Laptop", 999)
cart.add_item("Mouse", 29)

# Strategy 1: Credit Card
cart.set_payment(CreditCardPayment.new)
cart.checkout

# Strategy 2: PayPal (swap at runtime)
cart.set_payment(PayPalPayment.new)
cart.checkout

# Strategy 3: Crypto
cart.set_payment(CryptoPayment.new)
cart.checkout

# Alternative: Lambda-based strategies for simple cases
# If your strategies are simple, use lambdas instead of full classes:

class SimpleShoppingCart
  def initialize
    @items = []
    @payment_proc = nil
  end

  def add_item(name, price)
    @items << { name: name, price: price }
  end

  def total
    @items.sum { |item| item[:price] }
  end

  def set_payment(&block)
    @payment_proc = block
  end

  def checkout
    return puts "Error: No payment method set" unless @payment_proc

    puts "--- Checkout ---"
    puts "Total: $#{total}"
    @payment_proc.call(total)
  end
end

puts "\n--- Lambda-based Strategy Pattern ---"

cart = SimpleShoppingCart.new
cart.add_item("Keyboard", 75)
cart.add_item("Monitor", 250)

# Set payment strategies as blocks at runtime
cart.set_payment { |amount| puts "💳 Card: $#{amount} - Approved!" }
cart.checkout

cart.set_payment { |amount| puts "🅿️ PayPal: $#{amount} - Processing..." }
cart.checkout

cart.set_payment { |amount| puts "₿ Crypto: $#{amount} - Mining transaction..." }
cart.checkout

# Thinking in Ruby
#
# The Strategy pattern in Ruby can use full classes OR lambdas — the
# ShoppingCart class accepts any object responding to .pay(amount).
# Ruby's duck typing makes the pattern simpler than in statically-typed
# languages: no Strategy interface required, just objects that implement
# the expected method. The lambda variant shows the lightweight
# alternative for simple strategies.
