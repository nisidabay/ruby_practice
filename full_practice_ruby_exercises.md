# Comprehensive Ruby Practice Exercises

This document provides a series of exercises covering various fundamental Ruby concepts, structured to align with common learning paths. Each section corresponds to a conceptual area, offering problems to help solidify understanding and practical application.

---

## 1. Ruby Basics (Comments, Input/Output)

### Exercise 1.1: Hello World with User Input
**Problem:**
Write a Ruby program that prompts the user for their name using `gets.chomp` and then prints a personalized greeting message to the console.

**Example Usage:**
```ruby
# When the user inputs "Alice"
# Expected program output:
# Hello, Alice!
```

**Expected Output (Illustrative - assumes user input "Alice"):**
```
What is your name? Alice
Hello, Alice!
```

### Exercise 1.2: Simple Calculator - Addition
**Problem:**
Create a program that asks the user for two numbers, converts them to integers, adds them together, and then prints the sum.

**Example Usage:**
```ruby
# When the user inputs "5" and then "3"
# Expected program output:
# The sum is: 8
```

**Expected Output (Illustrative - assumes user input "5" and "3"):**
```
Enter the first number: 5
Enter the second number: 3
The sum is: 8
```

---

## 2. Strings and Text Manipulation

### Exercise 2.1: String Reversal
**Problem:**
Write a Ruby method named `reverse_string` that takes one `String` argument and returns a new string with the characters in reverse order.

**Example Usage:**
```ruby
puts reverse_string("hello")
puts reverse_string("Ruby")
```

**Expected Output:**
```
olleh
ybuR
```

### Exercise 2.2: Palindrome Checker
**Problem:**
Write a Ruby method named `is_palindrome?` that takes a `String` argument and returns `true` if it is a palindrome (reads the same forwards and backward, ignoring case and non-alphanumeric characters), and `false` otherwise.

**Example Usage:**
```ruby
puts is_palindrome?("Madam")
puts is_palindrome?("A man, a plan, a canal: Panama")
puts is_palindrome?("hello")
puts is_palindrome?("racecar")
```

**Expected Output:**
```
true
true
false
true
```

---

## 3. Numbers and Math

### Exercise 3.1: Even/Odd Checker
**Problem:**
Write a Ruby method named `is_even?` that takes an `Integer` as an argument. It should return `true` if the number is even, and `false` if it is odd.

**Example Usage:**
```ruby
puts is_even?(4)
puts is_even?(7)
puts is_even?(0)
```

**Expected Output:**
```
true
false
true
```

### Exercise 3.2: Area of a Circle
**Problem:**
Write a Ruby method named `circle_area` that takes a `Float` or `Integer` representing the radius of a circle as an argument. The method should calculate and return the area of the circle (π * r^2). Use `Math::PI` for the value of Pi.

**Example Usage:**
```ruby
puts circle_area(5)
puts circle_area(1.5)
```

**Expected Output (approximately):**
```
78.53981633974483
7.0685834705770345
```

---

## 4. Control Flow

### Exercise 4.1: Number Sign Classification
**Problem:**
Write a Ruby method named `get_number_sign` that takes an integer `value` as an argument. The method should return the string `"Positive"` if `value` is greater than 0, `"Negative"` if `value` is less than 0, and `"Zero"` if `value` is 0.

**Example Usage:**
```ruby
puts get_number_sign(10)
puts get_number_sign(-5)
puts get_number_sign(0)
```

**Expected Output:**
```
Positive
Negative
Zero
```

### Exercise 4.2: Grade Assigner
**Problem:**
Write a Ruby method named `assign_grade` that takes an integer `score` (between 0 and 100) as an argument. Use a `case` statement to return a letter grade based on the following scale:
- 90-100: "A"
- 80-89: "B"
- 70-79: "C"
- 60-69: "D"
- Below 60: "F"

**Example Usage:**
```ruby
puts assign_grade(95)
puts assign_grade(82)
puts assign_grade(70)
puts assign_grade(55)
```

**Expected Output:**
```
A
B
C
F
```

### Exercise 4.3: Print Numbers Up To N
**Problem:**
Write a Ruby method named `print_up_to` that takes a positive integer `n` as an argument. The method should print all integers from 1 up to `n`, each on a new line. Use a `while` loop.

**Example Usage:**
```ruby
print_up_to(3)
puts "---"
print_up_to(5)
```

**Expected Output:**
```
1
2
3
---
1
2
3
4
5
```

---

## 5. Methods

### Exercise 5.1: Custom Greeter
**Problem:**
Write a Ruby method named `greet` that takes a `name` (String) and an optional `greeting` (String, default to "Hello") as arguments. The method should print the personalized greeting.

**Example Usage:**
```ruby
greet("Alice")
greet("Bob", "Hi")
greet("Charlie", "Good morning")
```

**Expected Output:**
```
Hello, Alice!
Hi, Bob!
Good morning, Charlie!
```

### Exercise 5.2: Method with Block Execution
**Problem:**
Write a Ruby method named `execute_twice` that accepts a block. The method should execute the provided block two times.

**Example Usage:**
```ruby
execute_twice { puts "Block ran once!" }
puts "---"
execute_twice do
  puts "Another block execution"
  puts "This is the second line."
end
```

**Expected Output:**
```
Block ran once!
Block ran once!
---
Another block execution
This is the second line.
Another block execution
This is the second line.
```

---

<h2>6. Collections (Arrays, Hashes, Structs)</h2>

<h3>Exercise 6.1: Array Sum</h3>
<b>Problem:</b>
Write a Ruby method named `array_sum` that takes an `Array` of numbers as an argument. It should return the sum of all elements in the array. If the array is empty, it should return 0.

<b>Example Usage:</b>
```ruby
puts array_sum([1, 2, 3, 4, 5])
puts array_sum([10, -2, 0])
puts array_sum([])
```

<b>Expected Output:</b>
```
15
8
0
```

<h3>Exercise 6.2: Hash Lookup</h3>
<b>Problem:</b>
Create a `Hash` that maps product names (String) to their prices (Float). Write a Ruby method named `get_product_price` that takes a `product_name` (String) and the `products_hash` as arguments. It should return the price of the product. If the product is not found, it should return `"Product not found"`.

<b>Example Usage:</b>
```ruby
my_products = {
  "Apple" => 1.50,
  "Banana" => 0.75,
  "Orange" => 1.20
}

puts get_product_price("Apple", my_products)
puts get_product_price("Grape", my_products)
```

<b>Expected Output:</b>
```
1.5
Product not found
```

---

<h2>7. Object-Oriented Programming (OOP)</h2>

<h3>Exercise 7.1: Basic Dog Class</h3>
<b>Problem:</b>
Define a Ruby class named `Dog`. It should have `name` and `breed` attributes, which can be both read and written (`attr_accessor`). Implement a method `bark` that prints `"Woof!"` to the console.

<b>Example Usage:</b>
```ruby
my_dog = Dog.new
my_dog.name = "Fido"
my_dog.breed = "Golden Retriever"

puts "My dog's name is #{my_dog.name} and he is a #{my_dog.breed}."
my_dog.bark
```

<b>Expected Output:</b>
```
My dog's name is Fido and he is a Golden Retriever.
Woof!
```

<h3>Exercise 7.2: Class with Initializer</h3>
<b>Problem:</b>
Modify the `Dog` class from Exercise 7.1 to include an `initialize` method. The `initialize` method should accept `name` and `breed` as arguments, allowing you to create a `Dog` object with these attributes set at instantiation.

<b>Example Usage:</b>
```ruby
my_other_dog = Dog.new("Max", "Labrador")

puts "My other dog's name is #{my_other_dog.name} and he is a #{my_other_dog.breed}."
my_other_dog.bark
```

<b>Expected Output:</b>
```
My other dog's name is Max and he is a Labrador.
Woof!
```

---

<h2>8. Algorithms and Challenges</h2>

<h3>Exercise 8.1: Factorial Calculation</h3>
<b>Problem:</b>
Write a Ruby method named `factorial` that takes a non-negative integer `n` as an argument. The method should calculate and return the factorial of `n` (n!). The factorial of 0 is 1.

<b>Example Usage:</b>
```ruby
puts factorial(0)
puts factorial(1)
puts factorial(5) # 5 * 4 * 3 * 2 * 1
puts factorial(7)
```

<b>Expected Output:</b>
```
1
1
120
5040
```

<h3>Exercise 8.2: Fibonacci Sequence</h3>
<b>Problem:</b>
Write a Ruby method named `fibonacci` that takes a non-negative integer `n` as an argument. The method should return the `n`-th number in the Fibonacci sequence. The sequence starts with `fibonacci(0) = 0` and `fibonacci(1) = 1`.

<b>Example Usage:</b>
```ruby
puts fibonacci(0) # 0
puts fibonacci(1) # 1
puts fibonacci(2) # 1
puts fibonacci(6) # 0, 1, 1, 2, 3, 5, 8 (6th number, 0-indexed)
puts fibonacci(10)
```

<b>Expected Output:</b>
```
0
1
1
8
55
```

---

<h2>9. System Utilities</h2>

<h3>Exercise 9.1: Simple File Writer</h3>
<b>Problem:</b>
Write a Ruby program that prompts the user for a filename and then for some content. It should then write the provided content into the specified file.

<b>Example Usage:</b>
```bash
# User runs the script:
# ruby your_script.rb
# Program prompts:
# Enter filename: my_document.txt
# Enter content: This is some test content.
# Expected result: A file named 'my_document.txt' is created in the same directory
# with the content "This is some test content."
```

<b>Expected Output (File Content - for `my_document.txt`):</b>
```
This is some test content.
```

---

<h2>10. Importing Classes / Module Loading</h2>

<h3>Exercise 10.1: Using an External Class</h3>
<b>Problem:</b>
1.  Create a file named `lib/user.rb` inside your project. Define a class `User` within it, with an `initialize` method that takes `name` and a `greet` method that returns "Hello, [name]!".
2.  Create a separate file named `main.rb`. In `main.rb`, `require_relative` the `user.rb` file, then create an instance of `User` and call its `greet` method, printing the result.

<b>Example `lib/user.rb`:</b>
```ruby
# lib/user.rb
class User
  def initialize(name)
    @name = name
  end

  def greet
    "Hello, #{@name}!"
  end
end
```

<b>Example `main.rb`:</b>
```ruby
# main.rb
require_relative 'lib/user'

user = User.new("Bob")
puts user.greet
```

<b>Expected Output (from running `ruby main.rb`):</b>
```
Hello, Bob!
```

---

<h2>11. Basic "Hello World" (from lesson-1)</h2>

<h3>Exercise 11.1: First Ruby Program</h3>
<b>Problem:</b>
Write the simplest possible Ruby program that prints `"Hello, Ruby World!"` to the console.

<b>Example Usage:</b>
```ruby
# Run the script:
# ruby your_script.rb
```

<b>Expected Output:</b>
```
Hello, Ruby World!
```
