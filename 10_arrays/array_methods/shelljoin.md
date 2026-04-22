# shelljoin

Joins array elements into a string suitable for shell command arguments.

```ruby
# Simple arguments
['ls', '-la', '/home'].shelljoin # => "ls -la /home"

# Arguments with spaces (auto-quoted)
['echo', 'hello world'].shelljoin # => "echo 'hello world'"

# Arguments with special characters
['grep', 'pattern with spaces', 'file.txt'].shelljoin
# => "grep 'pattern with spaces' file.txt"

# Ruby command
['ruby', '-e', 'puts "hello"'].shelljoin
# => "ruby -e 'puts \"hello\"'"

# Useful for constructing shell commands
args = ['find', '.', '-name', '*.rb']
`#{args.shelljoin}` # executes the command
```