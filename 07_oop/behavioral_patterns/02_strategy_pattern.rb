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

# This could also be done like this:
# If your strategies are simple, use lambdas instead of full classes:
#
# credit_card = ->(amount) { puts "💳 Card: $#{amount}" }
# paypal = ->(amount) { puts "🅿️ PayPal: $#{amount}" }
#
# cart.set_payment(credit_card)
# cart.checkout
