# Metaprogramming — Practice Suite

Ruby's most distinctive feature: writing code that writes code, inspects code,
or modifies code at runtime. This is the foundation of Rails, RSpec, and most
Ruby DSLs.

> **Prerequisites:** Groups 04 (OOP), 06 (blocks/procs), and 07 (modules).
> Group 04 covers the basics: `method_missing`, `define_method`, `send`,
> `class << self`. This group builds on those — no duplication.

## Quick Start

```bash
# Eval family — run code inside objects and classes
ruby 01_instance_eval.rb                 # Change self to any object
ruby 02_class_eval.rb                    # Open a class from outside
ruby 03_instance_exec.rb                 # Eval with block arguments

# Accessors — reach into objects dynamically
ruby 04_instance_variable_get_set.rb     # Read/write ivars by name
ruby 05_const_get_set.rb                 # Dynamic constant lookup
ruby 06_binding_eval.rb                  # Capture scope, eval strings

# Method manipulation — rename, inspect, wrap
ruby 07_alias_method.rb                  # Rename or alias methods
ruby 08_method_objects.rb                # Methods as first-class objects
ruby 09_ancestors.rb                     # The method lookup chain
ruby 10_prepend.rb                       # Insert module BEFORE the class
ruby 11_refine_using.rb                  # Safe, scoped monkey patching

# Putting it together
ruby 12_mini_dsl.rb                      # Build a tiny configuration DSL
```

## Learning Path

### Eval Family (~25 min)

| Script | Concept |
|---|---|
| `01_instance_eval.rb` | `instance_eval` — change self to an object, access its internals |
| `02_class_eval.rb` | `class_eval` / `module_eval` — add methods from outside |
| `03_instance_exec.rb` | `instance_exec` / `class_exec` — eval with block arguments |

### Accessors (~20 min)

| Script | Concept |
|---|---|
| `04_instance_variable_get_set.rb` | `instance_variable_get` / `set` — direct ivar access |
| `05_const_get_set.rb` | `const_get` / `const_set` / `const_defined?` — constant manipulation |
| `06_binding_eval.rb` | `binding` + `eval` — string evaluation with captured context |

### Method Manipulation (~30 min)

| Script | Concept |
|---|---|
| `07_alias_method.rb` | `alias_method` / `remove_method` / `undef_method` |
| `08_method_objects.rb` | `Method` and `UnboundMethod` — callable method references |
| `09_ancestors.rb` | `ancestors` chain + `instance_method(:name).owner` |
| `10_prepend.rb` | `prepend` — insert module before class in lookup chain |
| `11_refine_using.rb` | `refine` / `using` — safe, scoped monkey patching |

### Putting It Together (~15 min)

| Script | Concept |
|---|---|
| `12_mini_dsl.rb` | Mini DSL: `instance_eval` + `method_missing` + `define_method` |

## Common Patterns

```ruby
# instance_eval — run code inside an object
config.instance_eval { @options[:debug] = true }

# class_eval — add methods to an existing class
Config.class_eval { def debug?; @options[:debug] == true; end }

# prepend — wrap a method with logging
module LoggingConfig
  def debug?
    puts "[LOG] Checking..."
    super  # calls the original
  end
end
Config.prepend(LoggingConfig)

# refine/using — safe monkey patching
module ConfigRefinements
  refine Config do
    def debug?; @options[:debug] == 1; end
  end
end
using ConfigRefinements  # only active in this scope
```

## Now Build Your Own

Create a `MethodTracer` module that uses `prepend` to log every method call
on any class. When a class prepends `MethodTracer`, every public method should
print `[TRACE] ClassName#method_name called` before running.

Hint: Use `instance_methods(false)` to get the class's own methods, then
`define_method` inside `prepended` callback to wrap each one.
