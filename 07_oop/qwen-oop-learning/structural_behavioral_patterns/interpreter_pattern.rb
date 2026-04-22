#!/usr/bin/env ruby

# Interpreter Pattern — Define a Grammar and Interpret Sentences
# Core Idea: Given a language, define a representation for its grammar along
# with an interpreter that uses the representation to interpret sentences.


# =============================================================================
# 1. THE EXPRESSION INTERFACE (Abstract Expression)
# =============================================================================
# All expressions must implement interpret.

class Expression
  def interpret(context)
    raise NotImplementedError, "Subclasses must implement interpret()"
  end
end


# =============================================================================
# 2. TERMINAL EXPRESSIONS
# =============================================================================
# These represent basic elements in the grammar (like numbers or variables).

class Number < Expression
  def initialize(value)
    @value = value
  end

  def interpret(context)
    @value
  end

  def to_s
    @value.to_s
  end
end

class Variable < Expression
  def initialize(name)
    @name = name
  end

  def interpret(context)
    context[@name] || 0
  end

  def to_s
    @name
  end
end


# =============================================================================
# 3. NON-TERMINAL EXPRESSIONS
# =============================================================================
# These combine other expressions (like operators in math).

class Add < Expression
  def initialize(left, right)
    @left = left
    @right = right
  end

  def interpret(context)
    @left.interpret(context) + @right.interpret(context)
  end

  def to_s
    "(#{@left} + #{@right})"
  end
end

class Subtract < Expression
  def initialize(left, right)
    @left = left
    @right = right
  end

  def interpret(context)
    @left.interpret(context) - @right.interpret(context)
  end

  def to_s
    "(#{@left} - #{@right})"
  end
end

class Multiply < Expression
  def initialize(left, right)
    @left = left
    @right = right
  end

  def interpret(context)
    @left.interpret(context) * @right.interpret(context)
  end

  def to_s
    "(#{@left} * #{@right})"
  end
end

class Divide < Expression
  def initialize(left, right)
    @left = left
    @right = right
  end

  def interpret(context)
    left_val = @left.interpret(context)
    right_val = @right.interpret(context)
    raise "Division by zero" if right_val == 0
    left_val / right_val.to_f
  end

  def to_s
    "(#{@left} / #{@right})"
  end
end


# =============================================================================
# 4. THE CONTEXT
# =============================================================================
# Stores variable values and state during interpretation.

class Context
  def initialize
    @variables = {}
  end

  def set_variable(name, value)
    @variables[name] = value
  end

  def [](name)
    @variables[name]
  end

  def to_s
    @variables.map { |k, v| "#{k}=#{v}" }.join(", ")
  end
end


# =============================================================================
# 5. EXPRESSION BUILDER (Parser)
# =============================================================================
# Converts a string expression into an expression tree.

class ExpressionParser
  def initialize
    @pos = 0
    @text = ""
  end

  def parse(expression)
    @text = expression.gsub(/\s+/, "")  # Remove spaces
    @pos = 0
    parse_additive
  end

  private

  def parse_additive
    left = parse_multiplicative

    while @pos < @text.length && ["+", "-"].include?(@text[@pos])
      op = @text[@pos]
      @pos += 1
      right = parse_multiplicative
      left = op == "+" ? Add.new(left, right) : Subtract.new(left, right)
    end

    left
  end

  def parse_multiplicative
    left = parse_primary

    while @pos < @text.length && ["*", "/"].include?(@text[@pos])
      op = @text[@pos]
      @pos += 1
      right = parse_primary
      left = op == "*" ? Multiply.new(left, right) : Divide.new(left, right)
    end

    left
  end

  def parse_primary
    if @text[@pos] == "("
      @pos += 1  # Skip '('
      expr = parse_additive
      @pos += 1  # Skip ')'
      return expr
    end

    # Parse number or variable
    start = @pos
    if @text[@pos] =~ /[a-zA-Z]/
      while @pos < @text.length && @text[@pos] =~ /[a-zA-Z0-9]/
        @pos += 1
      end
      Variable.new(@text[start...@pos])
    else
      while @pos < @text.length && @text[@pos] =~ /[0-9]/
        @pos += 1
      end
      Number.new(@text[start...@pos].to_i)
    end
  end
end


# =============================================================================
# 6. REAL-WORLD EXAMPLE: SQL-like Query Language
# =============================================================================

class QueryExpression
  def interpret(data)
    raise NotImplementedError
  end
end

class SelectAll < QueryExpression
  def interpret(data)
    data
  end

  def to_s
    "SELECT *"
  end
end

class WhereCondition < QueryExpression
  def initialize(field, operator, value)
    @field = field
    @operator = operator
    @value = value
  end

  def interpret(data)
    data.select do |row|
      row_value = row[@field.to_sym] || row[@field.to_s]
      case @operator
      when "=" then row_value == @value
      when ">" then row_value > @value
      when "<" then row_value < @value
      when ">=" then row_value >= @value
      when "<=" then row_value <= @value
      else false
      end
    end
  end

  def to_s
    "WHERE #{@field} #{@operator} #{@value.inspect}"
  end
end

class OrderBy < QueryExpression
  def initialize(field, ascending = true)
    @field = field
    @ascending = ascending
  end

  def interpret(data)
    data.sort_by do |row|
      row[@field.to_sym] || row[@field.to_s] || ""
    end.then { |sorted| @ascending ? sorted : sorted.reverse }
  end

  def to_s
    "ORDER BY #{@field}#{@ascending ? " ASC" : " DESC"}"
  end
end

class Limit < QueryExpression
  def initialize(count)
    @count = count
  end

  def interpret(data)
    data.first(@count)
  end

  def to_s
    "LIMIT #{@count}"
  end
end

class Query
  def initialize
    @expressions = []
  end

  def add(expression)
    @expressions << expression
    self
  end

  def execute(data)
    @expressions.reduce(data) { |result, expr| expr.interpret(result) }
  end

  def to_s
    @expressions.map(&:to_s).join(" ")
  end
end


# =============================================================================
# HOW TO USE IT
# =============================================================================

puts "=== Interpreter Pattern Demo ===\n\n"

# Mathematical expressions
puts "--- Math Expression Interpreter ---"
context = Context.new
parser = ExpressionParser.new

# Parse and evaluate: (10 + 5) * 2
expression = parser.parse("(10 + 5) * 2")
puts "Expression: #{expression}"
puts "Result: #{expression.interpret(context)}"

# Parse and evaluate: 100 / (5 + 5)
expression = parser.parse("100 / (5 + 5)")
puts "\nExpression: #{expression}"
puts "Result: #{expression.interpret(context)}"

# With variables: (x + y) * 2
context.set_variable("x", 10)
context.set_variable("y", 20)
expression = parser.parse("(x + y) * 2")
puts "\nExpression: #{expression}"
puts "Context: #{context}"
puts "Result: #{expression.interpret(context)}"

# Complex expression with variables
expression = parser.parse("(x * 2) + (y / 2) - 5")
puts "\nExpression: #{expression}"
puts "Result: #{expression.interpret(context)}"

# SQL-like query example
puts "\n--- SQL-like Query Interpreter ---"

data = [
  { name: "Alice", age: 30, city: "NYC", salary: 75000 },
  { name: "Bob", age: 25, city: "LA", salary: 65000 },
  { name: "Charlie", age: 35, city: "NYC", salary: 85000 },
  { name: "Diana", age: 28, city: "Chicago", salary: 70000 },
  { name: "Eve", age: 32, city: "LA", salary: 80000 }
]

puts "Data: #{data.length} employees"

# Build query: SELECT * WHERE age > 28 ORDER BY salary DESC LIMIT 3
query = Query.new
  .add(SelectAll.new)
  .add(WhereCondition.new("age", ">", 28))
  .add(OrderBy.new("salary", false))
  .add(Limit.new(3))

puts "\nQuery: #{query}"
result = query.execute(data)
puts "\nResults:"
result.each { |row| puts "  #{row}" }

# Another query: WHERE city = 'NYC' ORDER BY name ASC
query2 = Query.new
  .add(SelectAll.new)
  .add(WhereCondition.new("city", "=", "NYC"))
  .add(OrderBy.new("name", true))

puts "\n\nQuery: #{query2}"
result2 = query2.execute(data)
puts "\nResults:"
result2.each { |row| puts "  #{row}" }

puts "\n=== Key Takeaway ==="
puts "Interpreter builds an AST (Abstract Syntax Tree) from expressions."
puts "Each node knows how to evaluate itself in context."
puts "Common uses: math parsers, query languages, rule engines, DSLs."
puts "Note: For complex languages, use parser generators (ANTLR, Yacc)."
