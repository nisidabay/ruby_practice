# Ruby Procs - Stored Blocks
# Procs are blocks turned into objects that can be stored and reused

# Creating Procs
my_proc = Proc.new { |x| x * 2 }
puts my_proc.call(5)

# Alternative syntax using proc keyword
my_proc2 = proc { |x| x * 2 }
puts my_proc2.call(5)

# Converting a block to Proc with &
def store_block(&block)
  block
end

stored = store_block { |x| x ** 2 }
puts stored.call(3)

# Argument Leniency - missing args become nil, extra args ignored
lenient = Proc.new { |a, b| [a, b] }
p lenient.call(1)        # [1, nil]
p lenient.call(1, 2, 3)  # [1, 2]

# Reusable validation with Procs
is_positive = Proc.new { |n| n > 0 }
p [1, -2, 3, -4].select(&is_positive)  # [1, 3]
p [5, -6, 7, -8].select(&is_positive)  # [5, 7]

# Return Behavior - return exits the enclosing method
def test_proc
  my_proc = Proc.new { return "From Proc" }
  my_proc.call
  "Method ended"  # Never reached!
end

puts test_proc

# Orphaned Procs - return after method ends raises LocalJumpError
def make_proc
  Proc.new { return 42 }
end

p = make_proc
begin
  p.call
rescue LocalJumpError => e
  puts "Error: #{e.message}"
end

# Use next instead of return in stored Procs
def make_safe_proc
  Proc.new { next 42 }
end

p = make_safe_proc
puts p.call  # 42

# Callback System with Procs
class Button
  def initialize
    @callbacks = []
  end

  def on_click(&callback)
    @callbacks << callback
  end

  def click
    @callbacks.each(&:call)
  end
end

btn = Button.new
btn.on_click { puts "Clicked!" }
btn.on_click { puts "Button pressed" }
btn.click
