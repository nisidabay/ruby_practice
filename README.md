# Ruby Practice — From Zero to Real Tools

A progressive, code-first curriculum for learning Ruby through CLI scripting.
No Rails, no frameworks — just the standard library and real problems.

**23 groups. 69 CLI tools. All Ruby, all stdlib.**

## Who This Is For

- You already program in another language and want to pick up Ruby
- You write Bash scripts and want something more maintainable
- You want to see what Ruby can do outside of Rails

## Two Paths In

### Path A: The 12-Challenge Sampler (~30 min)

Start with one file — `ruby_practice_guide.rb`. It runs 12 self-contained
challenges covering collections, strings, hashes, files, system commands,
path manipulation, CLI input, and error recovery. Each challenge has a
one-line key insight. If something clicks, follow the trail into that group.

```bash
ruby ruby_practice_guide.rb
```

### Path B: Systematic (~several weeks)

Work through the numbered groups in order. Each group has:

- **concept/README.md** — quick-start table + learning path
- **concept/*.rb** — one concept per file, code-first, runnable standalone
- **exercises.rb** — practice problems at the group level
- **project/** — a real CLI tool using those concepts
- **"Now Build Your Own"** prompt at the bottom of every README

Start here:

```bash
cd 01_basics_cli/concept
cat README.md            # see the map
ruby basics_01_hello_lesson.rb   # first concept
```

## The Curriculum (23 Groups)

| # | Group | What You'll Learn | Project |
|---|-------|-------------------|---------|
| 01 | **Basics & CLI** | Loops, `gets`, `*args`, `**kwargs`, `(...)` forwarding, OptionParser, ARGF | `argdemo` |
| 02 | **Strings & Regex** | Heredocs, interpolation, `gsub`, `scan`, Unicode, pattern matching | `retest` |
| 03 | **Control & Collections** | `if`/`case`/`unless`, `each`/`map`/`select`/`reduce`, Array, Hash, Set, Stack, Queue, Heap, Graph | `coldemo` |
| 04 | **OOP** | Classes, `attr_accessor`, inheritance, `super`, composition, mixins, `method_missing`, `Comparable`, `Enumerable` | `gpacalc` |
| 05 | **Filesystem** | `File.read`/`write`, `Pathname`, `StringIO`, `Tempfile`, `Dir`, `FileUtils` | `dirsizer` |
| 06 | **Blocks & Procs** | `yield`, `Proc`, `lambda`, `&` operator, block-to-proc conversion | `benchblk` |
| 07 | **Modules** | Namespacing, `include`/`extend`, `module_function`, `extend self` | `cacheable` |
| 08 | **Time** | `Time`, `Date`, `strftime`, timezones, arithmetic, Unix epoch | `agecalc` |
| 09 | **Exceptions** | `raise`/`rescue`/`ensure`/`retry`, custom exceptions, `binding.break`, `TracePoint` |
| 10 | **Threads** | `Thread`, `Mutex`, `Queue`, `Fiber`, `Ractor`, `ConditionVariable`, thread pools |
| 11 | **Testing** | Minitest, `assert_raises`, `setup`/`teardown`, mocks, test helpers |
| 12 | **Metaprogramming** | `instance_eval`/`class_eval`, `binding`, `Method` objects, `ancestors`, `prepend`, `refine`, DSLs |
| 13 | **Data Parsing** | JSON, CSV, YAML, `Digest::MD5`, logfmt parser, data conversion |
| 14 | **Networking** | `Net::HTTP`, `TCPSocket`, SSL, HTTP auth, reverse shells, REST clients, `CGI` URL encoding |
| 15 | **Processes** | `Open3.capture3`, `fork`, `spawn`, `Process.wait`, signal handling, `IO.popen` |
| 16 | **Performance** | `Benchmark`, `.lazy` pipelines, `Set` vs `Array`, command benchmarking |
| 17 | **Pattern Matching** | `case/in`, array/hash patterns, `^` pin, `\|` alternatives, guards, find patterns |
| 18 | **Gems & Bundler** | Gemfile, `.gemspec`, version operators, `bundle gem`, publishing, `Gem::Specification` |
| 19 | **Data & Enumerators** | `Data.define`, `Enumerator.produce`, `.lazy`, external iterators, Fiber Scheduler |
| 20 | **Logging & Security** | `Logger`, `SecureRandom`, `English`, `Shellwords`, `Etc`, `Zlib`, `ERB` |
| 21 | **Serialization & Objects** | `Marshal`, `ObjectSpace`, `WeakRef`, `OpenStruct`, `Observable`, `Singleton` |
| 22 | **Network & System** | `Resolv` (DNS), `IPAddr`, UDP/Unix sockets, `Find`, `TSort` |
| 23 | **Rake for Real** | Task arguments, `TestTask`, `FileList`, `clean`/`clobber`, `PackageTask`, `multitask`, CI pipelines |

## Curriculum Restructuring

The first 8 group projects (G01–G08) used concepts from future groups,
breaking the progressive learning model. They were moved to `projects/`
and replaced with exercises that only use concepts from their group
and prior groups.

| Tool | Original Group | What It Does |
|------|----------------|--------------|
| `fargs` | G01 | Inspect file arguments with filters and patterns |
| `fparse` | G02 | Parse log files into plain/JSON/CSV output |
| `fdedup` | G03 | Find duplicate files by content hash (MD5) |
| `freport` | G04 | File tree reporter with pluggable formatters |
| `flog` | G05 | Log file rotator and archiver |
| `fwatch` | G06 | Watch a directory for file changes |
| `fmix` | G07 | Configurable CLI built from mixin modules |
| `fage` | G08 | Find files older than N days, take action |

Each original group now has a replacement project (`argdemo`, `retest`,
`coldemo`, `gpacalc`, `dirsizer`, `benchblk`, `cacheable`, `agecalc`)
that only uses concepts taught up to that group.

## The Toolbox

`projects/` contains **69 real CLI tools** built with these concepts —
system monitors, file finders, config generators, backup scripts, network diagnostics,
pattern matchers, gem inspectors, lazy data pipelines, and CI task runners.
Everything here was built to solve an actual problem on a Linux machine.
See `projects/README.md` for a guided tour.

### Tools Added in This Session

| Tool | Group | What It Does |
|------|-------|--------------|
| `finspect` | 12 | Inspect Ruby classes — ancestors, methods grouped by origin |
| `fmatch` | 17 | Pattern-match JSON and CSV from the command line |
| `fgem` | 18 | List, inspect, and query installed gems |
| `fpipe` | 19 | Build and run lazy data pipelines |
| `fsecure` | 20 | Generate secure tokens, UUIDs, and random values |
| `fserialize` | 21 | Serialize/deserialize between Marshal and JSON |
| `fnet` | 22 | DNS resolution, TCP checks, subnet iteration |
| `Rakefile` | 23 | Production-ready task runner: test, lint, build, release |
| `web_search` | 14+15 | TUI web search — `gum` input/filter, `CGI.escape`, `spawn` browser |

## Reading

`reading_list.md` — categorized Ruby books, tagged ✅ (owned) / ❌ (want).
