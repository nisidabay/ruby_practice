# Ruby Module Patterns - Study Guide

This directory contains examples of different Ruby module patterns. Each file demonstrates a specific approach to organizing and sharing code with modules.

---

## 📚 Pattern Overview

| Pattern | File | Module.method | obj.method | Class.method | Use Case |
|---------|------|---------------|------------|--------------|----------|
| **self. methods** | `standalone_module.rb` | ✓ Public | N/A | N/A | Simple namespacing |
| **module_function** | `standalone_module.rb` | ✓ Public | ✗ Private | N/A | Hidden helpers |
| **include** | `include_module.rb` | N/A | ✓ Public* | N/A | Instance mixins |
| **extend self** | `extend_class.rb` | ✓ Public | ✓ Public | ✓ Public | Utilities + mixins |
| **extend** | `extend_class.rb` | N/A | N/A | ✓ Public | Class methods |
| **module_function hybrid** | `module_function_hybrid_pattern.rb` | ✓ Public | ✗ Private | ✗ Private | Three-way access |
| **extend self vs module_function** | `module_function_public_method.rb` | ✓ Public | ✓ Public | ✓ Public | Visibility comparison |
| **Comprehensive tests** | `module_test_suit.rb` | All patterns | All patterns | All patterns | Test suite |

\* With `module_function`, included methods become **private**

---

## 🔍 Pattern Details

### 1. self. Methods (Standalone Toolbox)

**File**: `standalone_module.rb`

```ruby
module LengthConversions
  def self.miles_to_feet(miles)
    miles * 5280
  end
end

LengthConversions.miles_to_feet(100)  # ✓ Works
```

**Characteristics**:
- Simplest pattern
- Methods only available on module
- Cannot be mixed into classes
- Pure namespacing

---

### 2. module_function (Hybrid Visibility)

**File**: `standalone_module.rb`, `include_module.rb`

```ruby
module LengthConversions
  def miles_to_feet(miles)
    miles * 5280
  end
  module_function :miles_to_feet
end

LengthConversions.miles_to_feet(100)  # ✓ Public
obj.miles_to_feet(100)                # ✗ Private (NoMethodError)
obj.send(:miles_to_feet, 100)         # ✓ Forced
```

**Characteristics**:
- Public on module
- Private when included/extended
- Forces encapsulation
- Perfect for helper methods

---

### 3. extend self (Public Everywhere)

**File**: `extend_class.rb`

```ruby
module LengthConversions
  extend self
  
  def miles_to_feet(miles)
    miles * 5280
  end
end

LengthConversions.miles_to_feet(100)  # ✓ Public
obj.miles_to_feet(100)                # ✓ Public (after include)
Class.miles_to_feet(100)              # ✓ Public (after extend)
```

**Characteristics**:
- Cleaner than `def self.` for every method
- Methods stay public when mixed in
- Good for utilities
- Single source of truth

---

### 4. include (Instance Mixins)

**File**: `include_module.rb`

```ruby
module Greeter
  def say_hello
    'Hello!'
  end
end

class Person
  include Greeter
end

Person.new.say_hello  # ✓ Instance method
```

**Characteristics**:
- Adds instance methods
- Most common pattern
- Used by Enumerable, Comparable
- Sharing behavior across classes

---

### 5. extend (Class Methods)

**File**: `extend_class.rb`

```ruby
module Greeter
  def say_hello
    'Hello!'
  end
end

class Animal
  extend Greeter
end

Animal.say_hello      # ✓ Class method
Animal.new.say_hello  # ✗ NoMethodError
```

**Characteristics**:
- Adds class methods
- Instances don't get the methods
- Good for factory methods, configuration

---

### 6. module_function Hybrid (Three-Way Access)

**File**: `module_function_hybrid_pattern.rb`

```ruby
module Calculator
  def add(a, b)
    a + b
  end
  module_function :add
end

class MyCalc
  extend Calculator   # Private class methods
  include Calculator  # Private instance methods
  
  def self.calculate(a, b)
    add(a, b)  # ✓ Can call internally
  end
  
  def calculate(a, b)
    add(a, b)  # ✓ Can call internally
  end
end

Calculator.add(2, 3)           # ✓ Public
MyCalc.calculate(2, 3)         # ✓ Internal use
MyCalc.new.calculate(2, 3)     # ✓ Internal use
MyCalc.add(2, 3)               # ✗ Private!
MyCalc.new.add(2, 3)           # ✗ Private!
```

**Characteristics**:
- Most powerful pattern
- Three access levels from one definition
- Module = public API
- Class/Instance = internal helpers

---

### 7. include Enumerable (Custom Collections)

**File**: `module_test_suit.rb`

```ruby
class MyArray
  include Enumerable
  
  def initialize(arr)
    @array = arr
  end
  
  def each(&)
    @array.each(&)
  end
end

MyArray.new([1,2,3]).map { |x| x * 2 }  # ✓ [2, 4, 6]
```

**Characteristics**:
- Implement `#each`, get 40+ methods free
- map, select, reject, find, all?, any?, etc.
- Ruby's enumeration protocol
- Don't Repeat Yourself

---

## 🎯 When to Use Each Pattern

| Your Goal | Pattern | Example |
|-----------|---------|---------|
| Simple namespace | `self.` methods | `Math.sqrt()`, `File.exist?()` |
| Utility toolbox | `extend self` | `StringUtils.format()` |
| Share instance behavior | `include` | `include Comparable`, `include Enumerable` |
| Add class methods | `extend` | `extend Forwardable` |
| Public module, private helpers | `module_function` | Validation, conversion helpers |
| Clean API + encapsulation | `module_function hybrid` | Framework design |
| Custom collection | `include Enumerable` | Custom data structures |

---

## 📊 Visibility Comparison

| Pattern | On Module | On Instance | On Class |
|---------|-----------|-------------|----------|
| `self.` methods | ✓ Public | N/A | N/A |
| `extend self` | ✓ Public | ✓ Public | ✓ Public |
| `module_function` | ✓ Public | ✗ Private | ✗ Private |
| `include` | N/A | ✓ Public | N/A |
| `extend` | N/A | N/A | ✓ Public |

---

## 🔑 Key Insights

1. **Modules are toolboxes** - They hold methods but can't be instantiated
2. **Visibility matters** - Choose pattern based on who should access methods
3. **include vs extend** - Instance vs Class methods
4. **extend self vs module_function** - Public vs Private when mixed
5. **Enumerable is powerful** - Implement `each`, get everything else free

---

## 🧪 Running Tests

```bash
# Run individual files
ruby standalone_module.rb
ruby include_module.rb
ruby extend_class.rb
ruby module_function_public_method.rb
ruby module_function_hybrid_pattern.rb

# Run comprehensive test suite
ruby module_test_suit.rb
```

Expected output: `✔️ All tests passed!`

---

## 📖 Related Wiki Pages

- `~/vimwiki/Apuntes-Ruby-modules.md` - Deep dive into modules
- `~/vimwiki/Apuntes-Ruby-oop-patterns.md` - Object-oriented patterns
- `~/vimwiki/Apuntes-Ruby-classes.md` - Complete class guide

---

## 💡 Pro Tips

1. **Start simple** - Use `include` for most cases
2. **Use extend self** for utility modules you want both ways
3. **Use module_function** when you want to hide helpers
4. **Always implement each** when making custom collections
5. **Test visibility** - Make sure methods are accessible where you need them

---

**Last Updated**: 2026-04-24  
**Ruby Version**: 3.4.8
