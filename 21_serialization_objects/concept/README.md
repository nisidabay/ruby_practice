# Serialization & Objects — Practice Suite

Save and restore Ruby objects, introspect live memory, and use stdlib design
patterns: Observer, Singleton, Delegation, and dynamic objects.

> **Prerequisites:** Groups 04 (OOP), 05 (filesystem), 13 (data parsing).
> All stdlib — no gems needed.

## Quick Start

```bash
# Serialization
ruby 01_marshal.rb                      # Marshal — serialize Ruby objects to bytes

# Memory & References
ruby 02_objectspace.rb                  # ObjectSpace — count and find live objects
ruby 03_weakref.rb                      # WeakRef — references that don't prevent GC

# Dynamic Objects
ruby 04_openstruct.rb                   # OpenStruct — hash-like objects with method access

# Design Patterns (stdlib)
ruby 05_delegate.rb                     # DelegateClass — auto-delegate all methods
ruby 06_observable.rb                   # Observable — observer pattern mixin
ruby 07_singleton.rb                    # Singleton — enforce single instance
```

## Learning Path

### Serialization & Memory (~15 min)

| Script | Concept |
|---|---|
| `01_marshal.rb` | `Marshal.dump` / `load` — Ruby-native serialization |
| `02_objectspace.rb` | `ObjectSpace` — count, find, measure live objects |
| `03_weakref.rb` | `WeakRef` — references that let GC collect |

### Dynamic Objects (~10 min)

| Script | Concept |
|---|---|
| `04_openstruct.rb` | `OpenStruct` — method access to arbitrary attributes |

### Design Patterns (~25 min)

| Script | Concept |
|---|---|
| `05_delegate.rb` | `DelegateClass` — auto-delegate to wrapped object |
| `06_observable.rb` | `Observable` — notify observers on state change |
| `07_singleton.rb` | `Singleton` — one instance, global access |

## Common Patterns

```ruby
# Marshal — save/restore any Ruby object
bytes = Marshal.dump(data)
restored = Marshal.load(bytes)

# ObjectSpace — memory introspection
ObjectSpace.count_objects[:T_STRING]  # how many strings?
ObjectSpace.each_object(String) { |s| ... }

# WeakRef — cache that doesn't leak
cache[:key] = WeakRef.new(expensive_object)

# OpenStruct — quick dynamic objects
user = OpenStruct.new(name: 'Alice', age: 30)
user.name  # => Alice

# Observable — decoupled notifications
class Stock
  include Observable
  def price=(p); @price = p; changed; notify_observers(self); end
end
```

## Now Build Your Own

Build a `CacheStore` class that:
1. Uses `Marshal` to persist cache entries to disk
2. Uses `WeakRef` for in-memory cache (entries can be GC'd)
3. Uses `Observable` to notify when cache is cleared or updated
4. Falls back to recomputing when a WeakRef is collected
