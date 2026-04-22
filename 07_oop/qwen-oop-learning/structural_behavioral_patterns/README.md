# Ruby Design Patterns Cookbook

A progressive learning path through all 23 GoF design patterns, organized like a cooking recipe book — from simple everyday patterns to advanced techniques.

---

## How to Use This Cookbook

Each pattern is a standalone Ruby file you can run and experiment with:

```bash
# Run any pattern
ruby strategy_pattern.rb

# Run all patterns in a category
for f in *_pattern.rb; do ruby "$f"; done
```

**Prerequisites:** Basic Ruby knowledge (classes, inheritance, modules)

---

## 🥄 Level 1: Essential Patterns (Start Here)

These are the "bread and butter" patterns — used daily in real code.

### 1. Singleton Pattern
**File:** `singleton_pattern.rb`  
**Difficulty:** ⭐  
**When to use:** You need exactly one instance (config, logger, database pool)  
**Analogy:** The one kitchen in your house — everyone uses it, but there's only one

```ruby
logger = Logger.instance
logger.log("Starting app")
```

**Learn this first because:** It's the simplest pattern conceptually.

---

### 2. Strategy Pattern
**File:** `strategy_pattern.rb`  
**Difficulty:** ⭐⭐  
**When to use:** You have multiple ways to do the same thing (payment methods, sorting algorithms)  
**Analogy:** Choosing between oven, stove, or microwave — same goal, different methods

```ruby
cart.set_payment_strategy(CreditCardStrategy.new)
cart.checkout
```

**Why it's common:** Every app has swappable algorithms.

---

### 3. Observer Pattern
**File:** `observer_pattern.rb`  
**Difficulty:** ⭐⭐  
**When to use:** One thing changes, many things need to know (event systems, UI updates)  
**Analogy:** Smoke detector — when it senses smoke, everything reacts (alarm, sprinklers, notifications)

```ruby
weather_station.attach(display1)
weather_station.attach(display2)
weather_station.measurements_changed(25, 60, 1013)
```

**Real-world use:** React/Vue reactivity, Rails callbacks, pub/sub systems.

---

### 4. Decorator Pattern
**File:** `decorator_pattern.rb`  
**Difficulty:** ⭐⭐  
**When to use:** Add features to objects without subclassing (middleware, I/O streams)  
**Analogy:** Pizza toppings — start with base, add what you want

```ruby
notifier = FacebookDecorator.new(
  SMSDecorator.new(EmailNotifier.new)
)
```

**Ruby example:** `File.new` → `Zlib::GzipWriter.new(File.new)` → `Base64.encode64(...)`

---

### 5. Factory Method Pattern
**File:** `factory_method_pattern.rb`  
**Difficulty:** ⭐⭐  
**When to use:** Don't know what type you'll need until runtime (plugins, document types)  
**Analogy:** Restaurant kitchen — you order "burger", kitchen decides how to make it

```ruby
doc = DocumentFactory.create("pdf")
doc.open
```

**Why learn it:** Frameworks use this everywhere.

---

### 6. Iterator Pattern
**File:** `iterator_pattern.rb`  
**Difficulty:** ⭐  
**When to use:** Custom collection traversal (Ruby has Enumerable built-in!)  
**Analogy:** Reading a book page by page vs. skipping chapters

```ruby
# Ruby's built-in
playlist.each { |song| play(song) }
playlist.select { |s| s[:duration] > 180 }
```

**Note:** Ruby's `Enumerable` module is this pattern — you already know it!

---

### 7. Template Method Pattern
**File:** `template_method_pattern.rb`  
**Difficulty:** ⭐⭐  
**When to use:** Framework with customizable steps (data processors, report generators)  
**Analogy:** Cake recipe — steps are fixed, ingredients vary

```ruby
class CSVProcessor < DataProcessor
  def read_data(file_path)
    File.readlines(file_path)
  end
end
```

**Real-world:** Rails' `ActiveRecord::Base` — you fill in the blanks.

---

## 🍳 Level 2: Intermediate Patterns

Once you're comfortable with Level 1, these add more power.

### 8. Command Pattern
**File:** `command_pattern.rb`  
**Difficulty:** ⭐⭐⭐  
**When to use:** Undo/redo, action queues, macros (text editors, task schedulers)  
**Analogy:** Recipe cards — each card is an action you can execute or undo

```ruby
history.execute_command(WriteCommand.new(editor, "Hello"))
history.undo
history.redo
```

**Builds on:** Strategy (commands are like strategies with undo)

---

### 9. Builder Pattern
**File:** `builder_pattern.rb`  
**Difficulty:** ⭐⭐⭐  
**When to use:** Complex object construction with many optional parts (SQL queries, configurations)  
**Analogy:** Subway sandwich — pick bread, then meat, then veggies, then sauce

```ruby
car = CarBuilder.new
  .make("Tesla")
  .model("Model 3")
  .color("red")
  .sunroof(true)
  .build
```

**Ruby example:** This is how most Ruby DSLs work (Rake, Bundler)

---

### 10. Adapter Pattern
**File:** `adapter_pattern.rb`  
**Difficulty:** ⭐⭐  
**When to use:** Make incompatible interfaces work together (legacy code, third-party APIs)  
**Analogy:** Power adapter — US plug fits European outlet

```ruby
player = UniversalPlayer.new
player.play("movie.vlc")  # Works via adapter
```

**Real-world:** API wrappers, database drivers, Rails' `ActiveModel::Adapter`

---

### 11. Facade Pattern
**File:** `facade_pattern.rb`  
**Difficulty:** ⭐⭐  
**When to use:** Simplify complex subsystems (home theater, database connections)  
**Analogy:** TV remote — one button does 10 things behind the scenes

```ruby
theater = HomeTheaterFacade.new
theater.watch_movie("netflix.com/movie/123")
# Behind: powers on 5 devices, connects, configures, starts
```

**Why it matters:** Every good library has a facade.

---

### 12. State Pattern
**File:** `state_pattern.rb`  
**Difficulty:** ⭐⭐⭐  
**When to use:** Object behavior changes based on internal state (game characters, order processing)  
**Analogy:** Traffic light — same light, different behavior (stop/go/yield)

```ruby
player.play    # Stopped → Playing
player.pause   # Playing → Paused
player.play    # Paused → Playing
```

**Avoids:** Giant `case` statements checking state everywhere.

---

### 13. Proxy Pattern
**File:** `proxy_pattern.rb`  
**Difficulty:** ⭐⭐⭐  
**When to use:** Control access to objects (lazy loading, caching, access control)  
**Analogy:** Security guard — checks ID before letting you in

```ruby
proxy = ImageProxy.new("photo.jpg")  # Not loaded yet
proxy.display  # Now it loads
```

**Types:** Virtual (lazy), Protection (auth), Caching, Logging

---

### 14. Abstract Factory Pattern
**File:** `abstract_factory_pattern.rb`  
**Difficulty:** ⭐⭐⭐⭐  
**When to use:** Create families of related objects (UI toolkits, cloud providers)  
**Analogy:** IKEA room sets — everything matches (Scandinavian, Modern, Rustic)

```ruby
factory = MacFactory.new
button = factory.create_button
checkbox = factory.create_checkbox
# All Mac-style, guaranteed compatible
```

**Builds on:** Factory Method (but for families of objects)

---

### 15. Composite Pattern
**File:** `composite_pattern.rb`  
**Difficulty:** ⭐⭐⭐  
**When to use:** Tree structures where individual and groups are treated the same (file systems, UI components)  
**Analogy:** Russian nesting dolls — each doll can contain dolls

```ruby
directory.add(file1)
directory.add(subdirectory)
directory.display  # Works for both files and folders
```

**Real-world:** HTML DOM, file systems, organization charts.

---

## 👨‍🍳 Level 3: Advanced Patterns

These solve specialized problems — learn when you encounter the need.

### 16. Mediator Pattern
**File:** `mediator_pattern.rb`  
**Difficulty:** ⭐⭐⭐⭐  
**When to use:** Many objects communicating chaotically (chat systems, air traffic control)  
**Analogy:** Air traffic controller — planes don't talk to each other, they talk to the tower

```ruby
mediator.register_components(user_list, chat_log, notification)
user_list.add_user("Alice")  # Mediator notifies everyone
```

**Trade-off:** Reduces N² connections to N, but mediator becomes complex.

---

### 17. Memento Pattern
**File:** `memento_pattern.rb`  
**Difficulty:** ⭐⭐⭐⭐  
**When to use:** Save/restore object state without breaking encapsulation (undo, checkpoints)  
**Analogy:** Game save files — capture state without exposing internals

```ruby
memento = editor.save
editor.type("more text")
editor.restore(memento)  # Back to saved state
```

**Ruby alternative:** `Marshal.dump(obj)` / `Marshal.load(data)`

---

### 18. Chain of Responsibility Pattern
**File:** `chain_of_responsibility_pattern.rb`  
**Difficulty:** ⭐⭐⭐⭐  
**When to use:** Request handling pipeline (middleware, approval workflows)  
**Analogy:** Assembly line — each worker does their step or passes it on

```ruby
logging.set_next(auth).set_next(rate_limit).set_next(cache)
logging.handle(request)  # Goes through chain
```

**Real-world:** Rack middleware, Rails filters, exception handling.

---

### 19. Visitor Pattern
**File:** `visitor_pattern.rb`  
**Difficulty:** ⭐⭐⭐⭐⭐  
**When to use:** Add operations to objects without changing their classes (exporters, calculators)  
**Analogy:** Food critic — visits restaurants, writes reviews without changing the restaurants

```ruby
drawing.accept(AreaCalculatorVisitor.new)
drawing.accept(SVGRendererVisitor.new)
# Same shapes, different operations
```

**Trade-off:** Easy to add operations, hard to add new element types.

---

### 20. Bridge Pattern
**File:** `bridge_pattern.rb`  
**Difficulty:** ⭐⭐⭐⭐⭐  
**When to use:** Avoid class explosion when you have multiple dimensions of variation  
**Analogy:** Universal remote — works with any TV brand, any device type

```ruby
remote = AdvancedRemote.new(TV.new)
remote = AdvancedRemote.new(Radio.new)
# Same remote, different devices
```

**Without Bridge:** N × M classes. **With Bridge:** N + M classes.

---

### 21. Flyweight Pattern
**File:** `flyweight_pattern.rb`  
**Difficulty:** ⭐⭐⭐⭐  
**When to use:** Memory optimization with many similar objects (text editors, games, particles)  
**Analogy:** Library books — many readers share the same book copies

```ruby
type = factory.get_tree_type("Oak", "green", "rough")  # Shared
tree = Tree.new(x, y, age, type)  # Unique position
```

**Use sparingly:** Only when you have thousands of objects.

---

### 22. Prototype Pattern
**File:** `prototype_pattern.rb`  
**Difficulty:** ⭐⭐⭐  
**When to use:** Object creation is expensive, clone instead (game entities, document templates)  
**Analogy:** Photocopier — duplicate existing document instead of retyping

```ruby
goblin = registry.create("goblin")  # Clone from prototype
goblin.move_to(10, 20)
```

**Ruby built-in:** `obj.clone`, `obj.dup`, `Marshal.load(Marshal.dump(obj))`

---

### 23. Interpreter Pattern
**File:** `interpreter_pattern.rb`  
**Difficulty:** ⭐⭐⭐⭐⭐  
**When to use:** Build domain-specific languages (math expressions, query languages)  
**Analogy:** Language translator — parse sentences, interpret meaning

```ruby
parser = ExpressionParser.new
expression = parser.parse("(x + y) * 2")
result = expression.interpret(context)
```

**Rarely needed:** Use parser generators (ANTLR, Yacc) for complex languages.

---

## 📚 Learning Path Recommendations

### Week 1-2: Foundations
1. Singleton (30 min)
2. Strategy (1 hour)
3. Observer (1 hour)
4. Decorator (1 hour)

### Week 3-4: Creation & Structure
5. Factory Method (1 hour)
6. Builder (1 hour)
7. Adapter (45 min)
8. Facade (45 min)

### Week 5-6: Behavioral
9. Command (1 hour)
10. State (1 hour)
11. Template Method (45 min)
12. Iterator (30 min)

### Week 7-8: Advanced
13. Composite (1 hour)
14. Proxy (1 hour)
15. Mediator (1 hour)
16. Memento (1 hour)

### Week 9-10: Mastery
17-23. Remaining patterns (2-3 hours each)

---

## 🔗 Pattern Relationships

### Similar Patterns (Know the Difference)

| Pattern A | Pattern B | Difference |
|-----------|-----------|------------|
| Strategy | Decorator | Strategy swaps behavior, Decorator adds behavior |
| Factory Method | Abstract Factory | Factory Method creates one product, Abstract Factory creates families |
| Observer | Mediator | Observer is one-to-many broadcast, Mediator is many-to-many coordination |
| Command | Memento | Command stores actions, Memento stores state |
| Proxy | Decorator | Proxy controls access, Decorator adds responsibilities |
| Bridge | Adapter | Bridge separates abstraction/implementation, Adapter converts interfaces |

### Patterns That Work Together

- **Command + Memento** = Undo/redo system
- **Observer + Mediator** = Event-driven architecture
- **Builder + Abstract Factory** = Complex object families
- **Decorator + Strategy** = Flexible behavior composition
- **Iterator + Composite** = Tree traversal

---

## 🎯 Quick Reference: When to Use What

| Problem | Pattern |
|---------|---------|
| Need one instance? | Singleton |
| Swap algorithms? | Strategy |
| Event notifications? | Observer |
| Add features dynamically? | Decorator |
| Unknown object types? | Factory Method |
| Complex object construction? | Builder |
| Incompatible interfaces? | Adapter |
| Simplify complex subsystem? | Facade |
| Undo/redo? | Command + Memento |
| Object changes by state? | State |
| Framework skeleton? | Template Method |
| Tree structures? | Composite |
| Control object access? | Proxy |
| Many-to-many communication? | Mediator |
| Memory optimization? | Flyweight |
| Clone expensive objects? | Prototype |
| Parse DSL? | Interpreter |
| Add operations without changing classes? | Visitor |
| Avoid class explosion? | Bridge |
| Request pipeline? | Chain of Responsibility |

---

## 🧪 Testing Your Understanding

After studying each pattern, ask yourself:

1. **Can I explain it in one sentence?**
2. **Can I name a real-world example?**
3. **Do I know when NOT to use it?**
4. **Can I implement it without looking at the code?**

---

## 📖 Further Reading

- "Design Patterns: Elements of Reusable Object-Oriented Software" (GoF book)
- Refactoring.Guru — https://refactoring.guru/design-patterns
- "Head First Design Patterns" — Beginner-friendly explanations
- "Patterns of Enterprise Application Architecture" by Martin Fowler

---

## 🤝 Contributing

Found a bug? Have a better example? Open an issue or PR!

**License:** MIT — Use these patterns freely in your projects.

---

*Happy coding! Remember: patterns are tools, not goals. Use them when they solve a real problem, not because they're "best practice".*
