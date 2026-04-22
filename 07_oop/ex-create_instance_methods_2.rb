# Define a Cake class. It will have 3 instance methods.
#    - A bake method that returns the string "Baking the cake"
#    - A slice method that returns the string "Slicing the cake"
#    - A sell method that return the string "Sold the cake"
class Cake
  def bake
    "Baking the cake"
  end
  def slice
    "Slicing the cake"
  end
  def sell
    "Sold the cake"
  end
end

cake = Cake.new
p cake.bake
p cake.slice
p cake.sell
