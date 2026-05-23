#!/usr/bin/env ruby
# frozen_string_literal: true

# 08_mixins.rb — share instance AND class methods from one module

# Non-idiomatic: explicit extend
module Loggable
  module ClassMethods
    def log_prefix
      "[SERVICE]"
    end
  end

  def log(message)
    puts "#{self.class.log_prefix} #{message}"
  end
end

class PaymentService
  include Loggable
  extend Loggable::ClassMethods
end

PaymentService.log_prefix           # => "[SERVICE]"
PaymentService.new.log("Charged")   # => "[SERVICE] Charged"

# Idiomatic Ruby: self.included hook auto-extends ClassMethods
module Loggable
  def self.included(base)
    base.extend(ClassMethods)
  end

  module ClassMethods
    def log_prefix
      "[SERVICE]"
    end
  end

  def log(message)
    puts "#{self.class.log_prefix} #{message}"
  end
end

class NotificationService
  include Loggable  # single line handles both!
end

NotificationService.log_prefix          # => "[SERVICE]"
NotificationService.new.log("Sent")     # => "[SERVICE] Sent"
