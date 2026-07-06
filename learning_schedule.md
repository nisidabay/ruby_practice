# Fibonacci Study Schedule — Ruby Practice

## 24-Unit Curriculum · 120 Sessions

| Session | Day | Unit | Activity |
|---------|-----|------|----------|
| 1 | 1 | 01 Basics & CLI | Write each, map, select, reduce from scratch without Enumerable; build a CLI tool with OptionParser that accepts flags and positional args |
| 2 | 3 | 01 Basics & CLI | Reimplement a small Unix tool (head/tail/wc) using ARGF for stream input; use gets in a loop with break conditions |
| 3 | 4 | 01 Basics & CLI | Write a CLI quiz app that reads questions from a file, uses OptionParser for config, and scores answers interactively |
| 4 | 6 | 01 Basics & CLI | Build a command-line RPN calculator supporting + - * / with stack-based evaluation and error handling |
| 5 | 9 | 01 Basics & CLI | Create a todo CLI with ARGV subcommands (add/list/done/remove), file persistence, and colored output |
| 6 | 9 | 02 Strings & Regex | Write an each-char vs each-byte benchmark on a large string; implement heredocs with different delimiters |
| 7 | 11 | 02 Strings & Regex | Build a regex-based log parser that extracts timestamps, severity levels, and error messages from a log file |
| 8 | 12 | 02 Strings & Regex | Implement a string templating engine using gsub with capture groups and a hash of substitutions |
| 9 | 14 | 02 Strings & Regex | Write a code formatter that normalizes whitespace, indentation, and trailing spaces using regex substitution |
| 10 | 17 | 02 Strings & Regex | Create a CSV-to-Markdown-table converter using scan, split, and string interpolation with alignment detection |
| 11 | 17 | 03 Control & Collections | Write each, map, select, reduce, reject from scratch using while loops; benchmark against built-in Enumerable |
| 12 | 19 | 03 Control & Collections | Implement a Set class backed by a Hash; add union, intersection, difference, and subset operations |
| 13 | 20 | 03 Control & Collections | Build a thread-safe Stack and Queue from scratch using Array with push/shift and concurrency guards |
| 14 | 22 | 03 Control & Collections | Create a word-frequency analyzer using reduce with a default Hash value; find top-N frequent words in a corpus |
| 15 | 25 | 03 Control & Collections | Implement a paginated collection with lazy loading, showing N items per page using each_slice and enumerators |
| 16 | 25 | 04 OOP | Write a BankAccount class with attr_accessor, private balance, deposit/withdraw methods, and overdraft protection |
| 17 | 27 | 04 OOP | Build an inheritance hierarchy: Animal → Mammal → Dog/Cat with super calls in initialize and custom to_s |
| 18 | 28 | 04 OOP | Implement composition: a Car composed of Engine, Wheels, Transmission classes with dependency injection |
| 19 | 30 | 04 OOP | Create a mixin-based system: Comparable-based sorting, Enumerable-based filtering, and CustomInspect for formatting |
| 20 | 33 | 04 OOP | Build a simple DSL for defining validation rules on attributes (validates :name, presence: true, length: { max: 50 }) |
| 21 | 33 | 05 Filesystem | Write File.read/write wrappers that handle encoding (UTF-8, ASCII, binary) and report byte counts per file |
| 22 | 35 | 05 Filesystem | Build a recursive directory tree printer using Pathname; show indented tree with file sizes and modification dates |
| 23 | 36 | 05 Filesystem | Build a log rotator with StringIO for in-memory testing and Tempfile for atomic writes during rotation |
| 24 | 38 | 05 Filesystem | Write a file system synchronisation tool using Dir.glob and FileUtils that mirrors directory structure with dry-run mode |
| 25 | 41 | 05 Filesystem | Implement a find-and-replace tool that walks a directory tree, applies regex substitution to file contents, and reports changes |
| 26 | 41 | 06 Blocks & Procs | Write a timing decorator using yield; measure and log execution time of any block passed to a method |
| 27 | 43 | 06 Blocks & Procs | Build a retry_with_backoff method using Proc/lambda; implement exponential backoff with configurable max attempts |
| 28 | 44 | 06 Blocks & Procs | Implement a simple observer pattern using & operator to convert blocks to procs for event callbacks |
| 29 | 46 | 06 Blocks & Procs | Write a method chainer that accepts method names as symbols plus blocks, composing them left-to-right |
| 30 | 49 | 06 Blocks & Procs | Build a scope-based transaction manager using block syntax: Transaction.open { |tx| tx.execute(sql) } with rollback |
| 31 | 49 | 07 Modules | Create a namespace hierarchy: Company::Department::Employee with nested module definitions and module_function helpers |
| 32 | 51 | 07 Modules | Implement an include/extend example: include adds instance methods, extend adds class methods using the same module |
| 33 | 52 | 07 Modules | Write a module that provides both class and instance methods via self.included callback with ClassMethods sub-module |
| 34 | 54 | 07 Modules | Build a plugin system using module mixins: loadable plugins that register themselves in a registry when included |
| 35 | 57 | 07 Modules | Create a refinements example that monkey-patches String#camelcase only within a specific scope using using |
| 36 | 57 | 08 Time | Write a date arithmetic library: compute age in years/months/days, next birthday countdown, and business day calculator |
| 37 | 59 | 08 Time | Build a Unix timestamp converter that handles epoch seconds, milliseconds, nanoseconds, and prints strftime-formatted output |
| 38 | 60 | 08 Time | Implement timezone-aware meeting scheduler: convert times between timezones, detect DST offsets, and find overlap windows |
| 39 | 62 | 08 Time | Write a cron-like scheduler that parses cron expressions and computes next N fire times from a given DateTime |
| 40 | 65 | 08 Time | Create a duration formatter: take seconds and produce human-readable "2h 15m 30s", handle days/weeks/months too |
| 41 | 65 | 09 Exceptions | Build a retry wrapper that catches specific exceptions, retries N times with logging, and re-raises on final failure |
| 42 | 67 | 09 Exceptions | Implement a transaction class using raise/rescue/ensure that rolls back on error and always closes resources in ensure |
| 43 | 68 | 09 Exceptions | Create a custom exception hierarchy (NetworkError → TimeoutError/DNSError) with structured error codes and messages |
| 44 | 70 | 09 Exceptions | Write a circuit breaker pattern: trip after N failures, half-open after timeout, track state with retry logic |
| 45 | 73 | 09 Exceptions | Build a safe numeric parser that handles edge cases (NaN, Infinity, overflow) with custom descriptive exceptions |
| 46 | 73 | 10 Threads | Write a producer-consumer pattern using Thread + Queue with multiple producers and a single consumer |
| 47 | 75 | 10 Threads | Show a data race with two threads incrementing a shared counter (no Mutex), then fix with Mutex#synchronize |
| 48 | 76 | 10 Threads | Build a thread pool using Queue#pop (blocking) with worker threads; submit jobs and collect results |
| 49 | 78 | 10 Threads | Implement a Fiber-based generator: produce Fibonacci numbers lazily using Fiber.yield and Fiber#resume |
| 50 | 81 | 10 Threads | Create a Ractor-based parallel map that splits an array across Ractors and merges results safely |
| 51 | 81 | 11 Testing | Write Minitest specs for a Calculator class: test add/sub/mul/div including edge cases (division by zero) |
| 52 | 83 | 11 Testing | Test exception raising with assert_raises; test a FileProcessor that raises on missing file, bad encoding, etc. |
| 53 | 84 | 11 Testing | Use setup/teardown to manage Tempfile fixtures for a CSV parser test suite; ensure cleanup on failure |
| 54 | 86 | 11 Testing | Mock an external API client using Minitest::Mock; test success, timeout, and 500 error paths with stubs |
| 55 | 89 | 11 Testing | Write property-based tests for a sort function: test idempotency, length preservation, and element membership |
| 56 | 89 | 12 Metaprogramming | Use define_method to dynamically create attribute accessors; compare with attr_accessor implementation |
| 57 | 91 | 12 Metaprogramming | Write a method tracer using instance_eval/class_eval; log every method call with arguments and return value |
| 58 | 92 | 12 Metaprogramming | Use Binding for live variable inspection; implement a Pry-style debugger that captures local variable state |
| 59 | 94 | 12 Metaprogramming | Explore the ancestors chain: insert a module into MRO, use prepend to override methods without aliasing |
| 60 | 97 | 12 Metaprogramming | Build a simple ActiveRecord-style ORM: dynamically define find_by_* methods using method_missing with respond_to_missing? |
| 61 | 97 | 13 Data Parsing | Write JSON parse/generate benchmarks; compare Oj vs stdlib JSON on a large nested document |
| 62 | 99 | 13 Data Parsing | Build a CSV-to-JSON converter with column type detection (integer, float, date, string) using CSV.table |
| 63 | 100 | 13 Data Parsing | Parse a YAML config file with nested keys; implement dot-notation accessor (config.get("database.host")) |
| 64 | 102 | 13 Data Parsing | Generate MD5/SHA256/SHA512 checksums for files; build a file integrity checker that verifies against a manifest |
| 65 | 105 | 13 Data Parsing | Chain parsers: read JSON → extract fields → CSV output; handle encoding mismatches between formats |
| 66 | 105 | 14 Networking | Write a minimal HTTP GET client using Net::HTTP; handle redirects, timeouts, and chunked transfer encoding |
| 67 | 107 | 14 Networking | Build a TCP echo server using TCPSocket + TCPServer; handle multiple clients with select or threads |
| 68 | 108 | 14 Networking | Implement TLS client/server with OpenSSL; generate self-signed certs, verify peer, handle handshake errors |
| 69 | 110 | 14 Networking | Add HTTP Basic Auth and Bearer token support to an HTTP client; test with a mock server |
| 70 | 113 | 14 Networking | Build a simple web crawler that follows links up to depth N, respects robots.txt, and reports response times |
| 71 | 113 | 15 Processes | Use Open3.capture3 to run shell commands; capture stdout, stderr, and exit status for error reporting |
| 72 | 115 | 15 Processes | Fork a child process for parallel computation; use pipes for IPC to send results back to parent |
| 73 | 116 | 15 Processes | Implement a process supervisor using spawn with monitoring: auto-restart on crash, limit restart frequency |
| 74 | 118 | 15 Processes | Write a parallel file processor using Process.wait: fork N workers, each processes a batch of files, collect exit codes |
| 75 | 121 | 15 Processes | Build a shell command pipeline: pipe the output of one command into the input of another using fork+dup2 |
| 76 | 121 | 16 Performance | Benchmark each vs for vs while for summing an array of 1M integers; report and explain the results |
| 77 | 123 | 16 Performance | Implement .lazy pipelines: chain select+map+take on a large range and show lazy vs eager memory usage |
| 78 | 124 | 16 Performance | Compare Set#include? vs Array#include? vs Hash#include? lookups with membership testing on 10K/100K/1M elements |
| 79 | 126 | 16 Performance | Profile a string concatenation loop: += vs << vs Array#join vs StringIO; find the fastest method with Benchmark.ips |
| 80 | 129 | 16 Performance | Write a memory profiler that tracks object allocations; find allocations hotspots in a text processing pipeline |
| 81 | 129 | 17 Pattern Matching | Match array patterns: destructure [first, *middle, last] from a parsed CSV row using case/in |
| 82 | 131 | 17 Pattern Matching | Use hash pattern matching to validate and extract fields from a nested JSON response with default values |
| 83 | 132 | 17 Pattern Matching | Implement pattern guards: match a Shape variant (Circle, Rect, Triangle) with area calculations using guards on params |
| 84 | 134 | 17 Pattern Matching | Use the pin operator (=~) to match against existing variables; demonstrate scope rules and shadowing gotchas |
| 85 | 137 | 17 Pattern Matching | Refactor nested if/elsif chains into case/in patterns; match on combinations of types, values, and conditions |
| 86 | 137 | 18 Gems & Bundler | Create a gemspec for a small utility gem (string_extensions); set up Gemfile with version operators (~>, >=, !=) |
| 87 | 139 | 18 Gems & Bundler | Build a multi-gem project with gemspec dependencies; use path/git sources for local development and remote deps |
| 88 | 140 | 18 Gems & Bundler | Write a Thor-based CLI gem: implement subcommands, option parsing, and help text; publish structure with gemspec |
| 89 | 142 | 18 Gems & Bundler | Set up a gem with C extension skeleton using Rice or FFI; compile, link, and call native code from Ruby |
| 90 | 145 | 18 Gems & Bundler | Publish a practice gem to RubyGems.org (or simulate with gem build/install locally); manage version bumps with semantic versioning |
| 91 | 145 | 19 Data & Enumerators | Define a structured data type with Data.define; add methods and compare with OpenStruct and Struct |
| 92 | 147 | 19 Data & Enumerators | Use Enumerator.produce to generate an infinite Fibonacci sequence; take N values and benchmark against recursive |
| 93 | 148 | 19 Data & Enumerators | Build a lazy CSV reader that yields rows one at a time using .lazy; avoid loading entire file into memory |
| 94 | 150 | 19 Data & Enumerators | Implement a tree traversal enumerator (DFS and BFS) using Enumerator.new with yielder |
| 95 | 153 | 19 Data & Enumerators | Chain multiple lazy enumerators: read → filter → transform → write; demonstrate pipeline composability |
| 96 | 153 | 20 Logging & Security | Set up Logger with rotation, different log levels (DEBUG→FATAL), and custom formatters for production-style logging |
| 97 | 155 | 20 Logging & Security | Use SecureRandom to generate API keys, session tokens, and UUIDs; compare hex, base64, and random_bytes outputs |
| 98 | 156 | 20 Logging & Security | Build a command executor using Shellwords; safely escape user input before passing to system() or exec() |
| 99 | 158 | 20 Logging & Security | Write a log aggregator: tail multiple log files, merge timestamps, color-code by severity, output to stdout |
| 100 | 161 | 20 Logging & Security | Implement rate limiting with a token bucket algorithm; test with high-frequency requests and burst handling |
| 101 | 161 | 21 Serialization & Objects | Serialize/deserialize complex objects with Marshal; handle circular references and version incompatibilities |
| 102 | 163 | 21 Serialization & Objects | Use ObjectSpace to trace object allocations; find memory leaks by counting references to a class |
| 103 | 164 | 21 Serialization & Objects | Implement a cache with WeakRef: auto-expire entries when GC reclaims the value, test with GC.start forcing reclamation |
| 104 | 166 | 21 Serialization & Objects | Build a deep-freeze utility that recursively freezes nested hashes, arrays, and custom objects |
| 105 | 169 | 21 Serialization & Objects | Create a simple object-diff tool that compares two objects recursively and reports added/removed/changed fields |
| 106 | 169 | 22 Network & System | Use Resolv to perform DNS lookups (A, AAAA, MX, CNAME records); compare with system getent/host commands |
| 107 | 171 | 22 Network & System | Work with IPAddr: parse CIDR ranges, compute network/broadcast addresses, check subnet membership |
| 108 | 172 | 22 Network & System | Build a UDP chat server: send/receive datagrams, handle packet loss simulation, and broadcast to all clients |
| 109 | 174 | 22 Network & System | Use Unix sockets for IPC between a Ruby server and client; compare performance vs TCP loopback |
| 110 | 177 | 22 Network & System | Walk a filesystem with Find.find; build a disk usage analyzer that reports per-directory sizes sorted largest first |
| 111 | 177 | 23 Rake for Real | Write a Rake task that accepts arguments (name, type, template); generate scaffold files from a template directory |
| 112 | 179 | 23 Rake for Real | Set up Rake::TestTask with multiple test patterns; run unit, integration, and benchmark tasks separately |
| 113 | 180 | 23 Rake for Real | Use FileList for glob-based file operations; write tasks that compile, concatenate, and minify assets |
| 114 | 182 | 23 Rake for Real | Implement a multitask for parallel downloads: download 10 files concurrently using multitask and Rake::FileTask |
| 115 | 185 | 23 Rake for Real | Build a complete Rakefile with namespaced tasks (db:migrate, db:seed, test, lint, build, deploy) |
| 116 | 185 | 24 Databases & SQL | Set up SQLite3 in-memory database; create tables, insert rows, and run SELECT/INSERT/UPDATE/DELETE queries |
| 117 | 187 | 24 Databases & SQL | Write CRUD operations with parameterised queries; prevent SQL injection and handle constraint violations |
| 118 | 188 | 24 Databases & SQL | Build a multi-table query with INNER JOIN, LEFT JOIN, GROUP BY, and HAVING; model a blog with posts/comments/authors |
| 119 | 190 | 24 Databases & SQL | Design a schema with foreign keys, indexes, and unique constraints; run EXPLAIN to analyse query performance |
| 120 | 193 | 24 Databases & SQL | Use Sequel ORM to define models, associations, and migrations; rewrite raw SQL queries using the DSL |
