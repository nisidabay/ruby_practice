================================================================================
RUBY SCRIPTING & AUTOMATION MASTERY ROADMAP
================================================================================

This roadmap is designed for the computer hobbyist who wants to build robust,
pure-Ruby automation tools without the bloat of web frameworks like Rails. It
focuses heavily on the built-in Standard Library to keep scripts lightweight.

Legend:
  [stdlib]   — Part of Ruby's standard library, no install needed
  [bundled]  — Ships with Ruby but may require `require 'x'`
  [gem]      — External gem: `gem install x` required

--------------------------------------------------------------------------------
PHASE 1: CORE AUTOMATION (The Built-In Tools)
--------------------------------------------------------------------------------

Goal: Replace complex Bash scripts with readable, reliable Ruby.

[ ] File and Directory Mastery
    - Learn FileUtils [stdlib] to copy, move, and delete files safely.
    - Learn Pathname [stdlib] to navigate folders and build paths without messy string
      manipulation.
    - Learn Dir.glob [stdlib] to find files matching patterns (e.g., all .txt files).
    - Learn the Logger class [stdlib] to create professional execution logs.

[ ] Running System Commands Safely
    - Learn the difference between backticks (`ls`) and the system() method [stdlib].
    - Master the Open3 module [stdlib]. Use it to separate standard output (stdout)
      from standard error (stderr) to handle failures gracefully.

[ ] Data Parsing (No Third-Party Gems)
    - Learn to read and write JSON [stdlib], CSV [bundled — removed from default gems in Ruby 3.4+, run `gem install csv`],
      and YAML [stdlib] files using built-in
      libraries. This is essential for config files and data export.

--------------------------------------------------------------------------------
PHASE 2: BUILDING COMMAND-LINE INTERFACES (CLI)
--------------------------------------------------------------------------------

Goal: Turn messy scripts into professional tools with help menus and options.

[ ] The OptionParser Class [stdlib]
    - Use this built-in class to add flags (e.g., --verbose or -f data.csv).

[ ] Standard Input and Output
    - Learn how to use $stdin and $stdout [stdlib] to pipe data into your Ruby script
      from other command-line tools.

[ ] Task Automation with Rake [bundled]
    - Use Rake to define "tasks" and dependencies (e.g., "Do not run
      'process_data' unless 'download_file' succeeds").

--------------------------------------------------------------------------------
PHASE 3: BULLETPROOF SCRIPTS WITH RSPEC ⚠️ [ALL EXTERNAL GEMS]
--------------------------------------------------------------------------------

Goal: Ensure your scripts never accidentally delete the wrong files.

NOTE: This entire phase requires installing external gems. RSpec is NOT part of
the standard library. If you're following a strict stdlib-only policy, skip this
phase and use MiniTest [stdlib] instead — see Minitest::Mock for test doubles.

[ ] Testing Output
    - Write tests to verify that your script outputs the correct text to the
      console.

[ ] Mocking System Calls
    - Use RSpec "mocks" to intercept dangerous commands. Pretend a folder was
      deleted instead of actually deleting it during a test.

[ ] Faking the File System
    - Use the FakeFS library [gem]. It creates a temporary, imaginary file system in
      memory so tests are lightning fast and don't clutter your drive.

--------------------------------------------------------------------------------
PHASE 4: ADVANCED SYSTEMS LOGIC
--------------------------------------------------------------------------------

Goal: Process large data quickly and write adaptable code.

[ ] Concurrency (Parallelism)
    - Learn about Fibers [stdlib] and Ractors [stdlib] (Ruby 3.0+). Use Ractors to leverage all
      CPU cores when scanning thousands of files.

[ ] Metaprogramming (Pure Ruby)
    - Learn method_missing and define_method [stdlib]. This allows your script to
      dynamically create methods based on the data it reads.

--------------------------------------------------------------------------------
ESSENTIAL READING LIST (Post-Beginner)
--------------------------------------------------------------------------------

1. For Scripting and CLI Building:
   - "Text Processing with Ruby" by Rob Miller           ✅ IN LIBRARY
   - "Build Awesome Command-Line Applications in Ruby 2" by David B. Copeland  ❌ NOT IN LIBRARY

2. For Mastering RSpec:
   - "Effective Testing with RSpec 3" by Myron Marston and Erin Dees  ✅ IN LIBRARY

3. For Deep Language Mastery:
   - "Programming Ruby 3.3 (The Pickaxe Book)" by Noel Rappin & Dave Thomas  ✅ IN LIBRARY
   - "Polished Ruby Programming" by Jeremy Evans          ❌ NOT IN LIBRARY

================================================================================
SUGGESTED ADDITIONS (Recommended Learning Paths)
================================================================================

The following sections are recommended additions to round out your mastery:

--------------------------------------------------------------------------------
PHASE 1.5: ERROR HANDLING & DEBUGGING (Essential Foundations)
--------------------------------------------------------------------------------

Goal: Build scripts that fail gracefully and are easy to troubleshoot.

[ ] Exception Handling Best Practices
    - Learn begin/rescue/end blocks and custom exception classes.
    - Understand the difference between raise and throw/catch.
    - Use ensure for cleanup operations (like closing file handles).

[ ] Debugging Techniques
    - Master the builtin 'debug' gem [bundled — ships with Ruby 3.1+] for breakpoints.
    - Learn to use pp (pretty print) [stdlib] for inspection.
    - Understand $DEBUG, $VERBOSE, and setting log levels.

--------------------------------------------------------------------------------
PHASE 2.5: TEXT PROCESSING & REGULAR EXPRESSIONS
--------------------------------------------------------------------------------

Goal: Become proficient at parsing and transforming text data.

[ ] Regular Expressions Mastery
    - Learn Ruby's Regexp class [stdlib] and match syntax (=~ and !~ operators).
    - Master capturing groups, lookaheads, and named captures.
    - Understand performance implications of complex regexes.

[ ] String Manipulation
    - Learn String#scan, #gsub, #split, and #partition methods [stdlib].
    - Understand encoding (UTF-8, ASCII-8BIT) and transcoding.
    - Master heredocs for multi-line strings and templates.

--------------------------------------------------------------------------------
PHASE 4.5: NETWORK SCRIPTING
--------------------------------------------------------------------------------

Goal: Interact with network services and APIs without frameworks.

[ ] HTTP Without Rails
    - Use Net::HTTP [stdlib] for API calls and web scraping.
    - Learn about timeouts, SSL, and connection pooling.

[ ] Socket Programming
    - Use the 'socket' library [stdlib] for TCP/UDP client and server scripts.
    - Understand asynchronous I/O with IO.select [stdlib].
    - Learn about UNIX domain sockets for local IPC.

--------------------------------------------------------------------------------
PHASE 5: PROCESS MANAGEMENT & DAEMONIZATION
--------------------------------------------------------------------------------

Goal: Create production-ready, long-running automation scripts.

[ ] Process Control
    - Learn fork, exec, and spawn [stdlib] for process management.
    - Understand signals (SIGTERM, SIGKILL, SIGHUP) [stdlib] and trap handlers.
    - Daemonize scripts to run as background services [stdlib].

[ ] Process Isolation
    - Use Bundler's inline mode [gem — `gem install bundler`] for self-contained scripts.
    - Create standalone executables with Ruby Packer (rubyc) [third-party tool].
    - Consider containerization with Docker for deployment.

--------------------------------------------------------------------------------
PHASE 6: PERFORMANCE & PROFILING
--------------------------------------------------------------------------------

Goal: Write efficient scripts that scale.

[ ] Profiling Tools
    - Use Benchmark and Benchmark.bmbm [stdlib] for timing comparisons.
    - Learn ruby-prof [gem] for detailed performance analysis.
    - Use memory_profiler [gem] to identify memory leaks.

[ ] Optimization Techniques
    - Understand lazy enumerators (Enumerator::Lazy) [stdlib] for large datasets.
    - Learn when to use Set [stdlib] vs Hash [stdlib] vs Array [stdlib] for lookups.
    - Profile before optimizing - avoid premature optimization.

--------------------------------------------------------------------------------
PHASE 7: SECURITY CONSIDERATIONS
--------------------------------------------------------------------------------

Goal: Protect your scripts and the data they process.

[ ] Secure Coding Practices
    - Sanitize all user input and file paths (Pathname#cleanpath).
    - Avoid shell injection with system() - use array form instead.
    - Handle credentials securely with environment variables or encrypted
      config files.

[ ] File System Safety
    - Use File.exist? and File.writable? before operations.
    - Implement atomic writes (write to temp, then rename).
    - Understand file permissions and umask.

================================================================================
ADDITIONAL RECOMMENDED READING
================================================================================

4. For Text Processing:
   - "Mastering Regular Expressions" by Jeffrey E.F. Friedl (language-agnostic)  ❌ NOT IN LIBRARY

5. For Concurrency:
   - "Working with Ruby Threads" by Jerry D'Antonio (free online)  ❌ NOT IN LIBRARY

6. For Ruby Internals:
   - "Ruby Under a Microscope" by Pat Shaughnessy               ❌ NOT IN LIBRARY

7. Official Documentation:
   - Ruby-Doc.org for Standard Library reference
   - The 'ri' command for offline documentation

================================================================================
