# Ruby Practice — From Zero to Real Tools

A progressive, code-first curriculum for learning Ruby through CLI scripting.
No Rails, no frameworks — just the standard library and real problems.

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

Then keep going: `02_strings_regex` → `03_control_collections` → `04_oop` →
`05_filesystem` → `06_blocks_procs` → `07_modules` → `08_time` →
`09_exceptions` → `10_threads` → `11_testing` → `13_data_parsing` →
`14_networking` → `15_processes` → `16_performance`.

## The Toolbox

`projects/` contains 36+ real CLI tools built with these concepts —
system monitors, file finders, config generators, backup scripts.
Everything here was built to solve an actual problem on a Linux machine.
See `projects/README.md` for a guided tour.

## Reading

`reading_list.md` — categorized Ruby books, tagged ✅ (owned) / ❌ (want).
