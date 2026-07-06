#!/usr/bin/env ruby
# frozen_string_literal: true

# 06_tracepoint.rb — TracePoint: hook into Ruby's execution events
#
# TracePoint fires callbacks on interpreter events: method calls, returns,
# line execution, class definitions, exceptions, and more.
#
# WITHOUT TracePoint — no way to observe Ruby internals without modifying code:
#
#   # can't see method calls unless you wrap every method with logging
#
# WITH TracePoint — observe ANY Ruby code without touching it:

# Trace method calls on ONE class
class Calculator
  def add(a, b); a + b; end
  def subtract(a, b); a - b; end
end

trace = TracePoint.new(:call, :return) do |tp|
  case tp.event
  when :call
    puts "→ #{tp.defined_class}##{tp.method_id}(#{tp.self})"
  when :return
    puts "← #{tp.defined_class}##{tp.method_id} → #{tp.return_value}"
  end
end

calc = Calculator.new
trace.enable
calc.add(10, 5)
calc.subtract(10, 5)
trace.disable

# Other events you can trace:
#   :line     — every line executed (slow!)
#   :class    — class/module definition starts
#   :end      — class/module definition ends
#   :raise    — an exception was raised
#   :b_call, :b_return — block entry/exit
#   :c_call, :c_return — C-level method calls

# Use for: debuggers, profilers, coverage tools, tracing frameworks.
# Warning: TracePoint has overhead — don't use in production hot paths.

# Thinking in Ruby
#
# TracePoint is Ruby's metaprogramming superpower — it hooks into the
# interpreter itself (:call, :return, :line, :class, :raise events) and
# fires callbacks. No bytecode instrumentation, no AOP frameworks, no
# monkey-patching every method. It's how debug gems and profilers work
# under the hood. The power comes with a warning: TracePoint intercepts
# EVERY event of that type, so it has real performance cost. Use it for
# tools, not for production business logic.
