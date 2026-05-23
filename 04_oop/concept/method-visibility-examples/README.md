# Ruby Method Visibility - Educational Examples

A progressive series of focused examples teaching Ruby's method visibility: `public`, `protected`, and `private`.

## How to Use

Run files in order. Each file solves ONE specific problem with consistent examples (`BankAccount` throughout).

```bash
cd ~/temp/Ruby/method-visibility-examples
ruby 01_public_methods.rb
ruby 02_private_methods.rb
ruby 03_protected_methods.rb
ruby 04_visibility_comparison.rb
ruby 05_changing_visibility.rb
ruby 06_class_method_visibility.rb
```

## File Progression

| File | Problem | Solution |
|------|---------|----------|
| `01_public_methods.rb` | Methods callable from anywhere | Use `public` (the default) |
| `02_private_methods.rb` | Helper methods for internal use only | Use `private` (no explicit receiver) |
| `03_protected_methods.rb` | Compare/operate on same-class instances | Use `protected` |
| `04_visibility_comparison.rb` | See all three levels together | Combined example with testing |
| `05_changing_visibility.rb` | Change visibility after definition | Use `private :method_name` |
| `06_class_method_visibility.rb` | Class methods with visibility | Use `private_class_method` |

## Key Rules

### Public
- Callable from anywhere: `obj.method`
- Default visibility in Ruby
- Use for the object's external API

### Private
- Callable **only without explicit receiver** (no `obj.method` or `self.method`)
- Works inside the class: `method` ✓
- Fails outside: `obj.method` ✗
- Use for internal helpers

### Protected
- Callable by **any instance of the same class or subclass**
- `obj.method` works if `obj` is same class
- Fails for arbitrary objects
- Use for `==`, `<=>`, comparisons, cross-instance operations

## Consistent Example

All files use `BankAccount` with the same methods:
- `balance` - read account balance
- `deposit(amount)` - add money
- `withdraw(amount)` - remove money

This lets you focus on the **visibility pattern**, not the domain.

## Related Vimwiki Note

See `~/vimwiki/Apuntes-Ruby-method-visibility.md` for comprehensive reference.
