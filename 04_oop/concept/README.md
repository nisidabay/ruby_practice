# OOP — Practice Suite

Classes, objects, inheritance, composition, mixins, and metaprogramming.

## Quick Start

```bash
# Core class mechanics
ruby 12_define_class_cookie.rb          # Simplest possible class
ruby 09_class_basics_video.rb           # Basic class with attr_accessor
ruby 01_attr_accessor_basic.rb          # Auto-generate getters/setters
ruby 13_instance_methods_cake.rb        # Defining instance methods
ruby 14_to_s_method_computer.rb         # Custom string representation

# Advanced attributes
ruby 15_manual_getters_airplane.rb      # Manual getters (normally use attr_reader)
ruby 16_attr_reader_accessor_transaction.rb  # Mix read-only + read-write
ruby 17_custom_setters_product.rb       # Validated write access
ruby 02_custom_setters_validation.rb    # Custom setters with validation

# Inheritance & super
ruby 04_inheritance_animal_dog.rb       # Child inherits + specializes
ruby 21_super_keyword_patterns.rb       # Four super patterns

# Class methods
ruby 03_class_methods_self_syntax.rb    # def self.method
ruby 06_class_methods_class_block.rb    # class << self block
ruby 23_class_methods_sushi_order.rb    # Class methods + class variable
ruby 28_private_class_method.rb         # Singleton with private .new
```

## Learning Path

### Class Basics (~30 min)

| Script | Concept |
|---|---|
| `12_define_class_cookie.rb` | Simplest possible class |
| `09_class_basics_video.rb` | `attr_accessor`, initialize |
| `01_attr_accessor_basic.rb` | Auto-generate getters/setters |
| `13_instance_methods_cake.rb` | Defining instance methods |
| `14_to_s_method_computer.rb` | Custom `to_s` |

### Attributes & Validation (~25 min)

| Script | Concept |
|---|---|
| `15_manual_getters_airplane.rb` | Manual getters (normally use `attr_reader`) |
| `16_attr_reader_accessor_transaction.rb` | Mix read-only + read-write |
| `17_custom_setters_product.rb` | Validated write access |
| `02_custom_setters_validation.rb` | Custom setters with validation rules |
| `18_keyword_arguments_restaurant.rb` | Keyword args with defaults in initialize |

### Inheritance & Relationships (~30 min)

| Script | Concept |
|---|---|
| `04_inheritance_animal_dog.rb` | Child class inherits + specializes |
| `21_super_keyword_patterns.rb` | Four `super` patterns |
| `25_composition.rb` | Has-a: owned objects |
| `26_aggregation.rb` | Has-a: passed-in objects |
| `05_aggregation_department_professor.rb` | Objects passed from outside |
| `07_composition_report_generator.rb` | Child created inside parent |

### Class Methods & Variables (~25 min)

| Script | Concept |
|---|---|
| `03_class_methods_self_syntax.rb` | Factory methods on the class |
| `06_class_methods_class_block.rb` | `class << self` block |
| `23_class_methods_sushi_order.rb` | Class methods + `@@class_var` |
| `11_class_variables_customer_count.rb` | `@@var` shared across all instances |
| `27-1_class_instances_variables.rb` | Class instance vars vs class vars |
| `28_private_class_method.rb` | Singleton with private `.new` |

### Modules & Mixins (~20 min)

| Script | Concept |
|---|---|
| `08_modules_loggable_mixin.rb` | Sharing behavior via `include` |
| `19_monkey_patching.rb` | Adding methods to existing classes |

### Metaprogramming (~30 min)

| Script | Concept |
|---|---|
| `method_missing_define_method.rb` | `method_missing` + `respond_to_missing?` — catch undefined calls |
| `define_method.rb` | `define_method` — create methods at runtime from data |
| `10_public_send_dynamic_calls.rb` | `send()` calls methods by string/symbol |
| `30_send_dynamic_dispatch.rb` | Dynamic method dispatch |
| `29_method_missing.rb` | Intercept calls to undefined methods |
| `34_singleton_class.rb` | Methods on ONE object, not the whole class |

### Ruby Built-ins (~25 min)

| Script | Concept |
|---|---|
| `31_comparable.rb` | Implement `<=>`, get `< > >= <= between?` free |
| `32_enumerable_deep_dive.rb` | Implement `each`, get 50+ methods free |
| `33_forwardable.rb` | Delegation without boilerplate |
| `35_at_exit.rb` | Cleanup hooks that run on program exit |
| `36_file_program_name.rb` | `__FILE__` and `$PROGRAM_NAME` |

## Common Patterns

```ruby
# Basic class
class Cookie
  attr_accessor :flavor, :size
  def initialize(flavor:, size: :medium)
    @flavor = flavor
    @size = size
  end
end

# Inheritance with super
class Dog < Animal
  def speak
    "#{super} woof!"                     # call parent's speak
  end
end

# send() dynamic dispatch
obj.send(:method_name, *args)

# Comparable — define <=>, get everything
class Version
  include Comparable
  attr_reader :major, :minor
  def <=>(other)
    [major, minor] <=> [other.major, other.minor]
  end
end
```

## Now Build Your Own

Design a `ReportCard` class with classes for `Student` and `Course`.
A student has many courses. A course has a name and grade.
Add a method to `ReportCard` that computes GPA. Use composition,
not inheritance.
