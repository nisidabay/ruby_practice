# Advanced Features - & Operator and Anonymous Parameters

# The & Operator: Two Directions

# 1. Block → Proc (capture in parameter)
def store(&block)
  block  # Now a Proc object
end

# 2. Proc → Block (pass to method)
numbers = [1, 2, 3, 4, 5]

# Convert Proc to block
double = Proc.new { |x| x * 2 }
p numbers.map(&double)  # [2, 4, 6, 8, 10]

# Convert symbol to Proc (shorthand)
p numbers.map(&:to_s)    # ["1", "2", "3", "4", "5"]
# Same as: numbers.map { |x| x.to_s }

# Anonymous Block Parameters (Ruby 2.7+/3.0+)

# Ruby 3.0+: `it` parameter (preferred for single arg)
p [1, 2, 3].map { it ** 2 }  # [1, 4, 9]

# Ruby 2.7+: Numbered parameters (for multiple args)
p({a: 1, b: 2}.map { "#{_1} = #{_2}" })  # ["a = 1", "b = 2"]

# `it` is a "soft keyword" - can still be used as variable
it = 5
p it  # 5

# Cannot mix `it` with explicit parameters
