# Modules — Practice Suite

## What modules are for (plain English)

Modules have two jobs in Ruby:

1. **Namespacing** — preventing name clashes. Like folders for your code:
   `Auth::Token` won't collide with `Payments::Token`.

2. **Mixins** — sharing behavior without inheritance. Instead of a long
   parent chain, you compose a class from independent pieces:

   ```ruby
   class Payment
     include Loggable
     include Serializable
   end
   ```

   `Payment` gets logging from one module, serialization from another. No
   inheritance tree. This is composition — the same idea as classical OOP
   composition, but Ruby's flavor: behaviors are mixed directly into the
   class rather than held as separate objects you delegate to.

| Style | How it works | Trade-off |
|-------|-------------|-----------|
| Classical composition | Hold a reference, delegate | Explicit, but more code |
| Ruby mixin composition | `include` copies behavior in | Less code, but don't overdo it |

**Use modules to favor composition over inheritance.**

Namespacing, mixins, module_function, and the include/extend duality.

> **YAGNI for language guts:** If the language is showing you its internals —
> hooks, base, metaprogramming, the object model — skip it. Procedural code
> covers 90% of real work. You ain't gonna need it.

## Quick Start

```bash
# Module methods
ruby 01_standalone_methods.rb           # def self.method — callable on module
ruby 04_extend_self.rb                  # Module as standalone toolbox
ruby 05_module_function.rb              # Public on module, private when included

# Mixins
ruby 02_include_for_instances.rb        # include → instance methods
ruby 03_extend_for_class_methods.rb     # extend → class methods

# Namespacing
ruby 09_nested_modules.rb               # Organizing classes under namespaces

# Built-in modules
ruby 07_enumerable.rb                   # Implement each → get 50+ methods free
```

## Learning Path

### Standalone Modules (~25 min)

| Script | Concept |
|---|---|
| `01_standalone_methods.rb` | `def self.method` — callable on the module |
| `04_extend_self.rb` | Module as standalone toolbox |
| `05_module_function.rb` | Public on module, private when included in classes |

### Mixins (~30 min)

| Script | Concept |
|---|---|
| `02_include_for_instances.rb` | `include` adds instance methods |
| `03_extend_for_class_methods.rb` | `extend` adds class methods |

### Namespacing & Built-ins (~20 min)

| Script | Concept |
|---|---|
| `09_nested_modules.rb` | Organizing classes under namespaces with `::` |
| `07_enumerable.rb` | Implement `each` → get `map`, `select`, `reduce` for free |

## include vs extend vs module_function

| Mechanism | Adds to | Typical use |
|---|---|---|
| `include Mod` | Instance methods | Share behavior across instances |
| `extend Mod` | Class methods (singleton) | Add class-level utilities |
| `module_function :m` | Both: public on module, private in class | Math-like modules |
| `extend self` | All methods callable on module | Standalone toolbox |

## Common Patterns

```ruby
# include — instance methods
module Loggable
  def log(msg)
    puts "[#{self.class}] #{msg}"
  end
end

class Worker
  include Loggable
end

Worker.new.log("starting")              # [Worker] starting

# extend — class methods
module Finders
  def find(id)
    # ...
  end
end

class User
  extend Finders
end

User.find(1)

# module_function — both
module MathTools
  def square(n) = n * n
  module_function :square
end

MathTools.square(4)                     # => 16 (module level)

class Calculator
  include MathTools                     # square is private here
end

# Nested modules for namespacing
module MyApp
  module Auth
    class Token; end
  end
end

MyApp::Auth::Token.new
```
