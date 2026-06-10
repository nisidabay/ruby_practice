# Data Parsing — JSON, CSV, YAML

Read and write structured data using Ruby's built-in libraries —
no gems needed (CSV requires `gem install csv` on Ruby 3.4+).

## Quick Start

```bash
# JSON
ruby 01_json_read_write.rb              # parse/write with the json library
ruby 02_json_config.rb                  # merge defaults with file-based config

# CSV
ruby 03_csv_read_write.rb               # headers, write, read back

# YAML
ruby 04_yaml_config.rb                  # human-readable config files

# Parsing / crypto
ruby 05_logfmt_parser.rb                # 5-state FSM, key=value parsing
ruby 06_md5_cracker.rb                  # Digest::MD5 + wordlist + cache

# Exercises
ruby ../exercises.rb                    # 3 exercises + BONUS
```

## Learning Path

### JSON (~20 min)

| Script | Concept |
|---|---|
| `01_json_read_write.rb` | `JSON.parse`, `JSON.pretty_generate`, write to disk |
| `02_json_config.rb` | `Hash#merge` for config defaults + file overrides |

### CSV (~15 min)

| Script | Concept |
|---|---|
| `03_csv_read_write.rb` | `CSV.open`, `CSV.foreach` with headers |

### YAML (~10 min)

| Script | Concept |
|---|---|
| `04_yaml_config.rb` | `YAML.safe_load`, nested keys |

### Parsing & Crypto (~20 min)

| Script | Concept |
|---|---|
| `05_logfmt_parser.rb` | 5-state FSM, `String#each_char`, type coercion |
| `06_md5_cracker.rb` | `Digest::MD5.hexdigest`, wordlist iteration, cache file |

## Common Patterns

```ruby
# JSON
require "json"
data = JSON.parse(File.read("file.json"))          # read
File.write("out.json", JSON.pretty_generate(data))  # write

# CSV
require "csv"
CSV.foreach("file.csv", headers: true) { |row| ... }   # iterate
CSV.open("out.csv", "w") { |csv| csv << %w[a b c] }    # write

# YAML
require "yaml"
config = YAML.safe_load(File.read("config.yml"))  # safe load only
File.write("out.yml", YAML.dump(data))             # write
```

## Project Tool

```bash
# Convert between formats — JSON ↔ CSV ↔ YAML
../project/fconv input.json output.csv
../project/fconv input.csv output.yaml
../project/fconv input.yml output.json
```

## Now Build Your Own

Write a script that reads a JSON config file, adds a `"backup"` key
with `"enabled" => true` and `"path" => "/var/backups"`, and writes
it back. Handle the case where the file doesn't exist yet by starting
with defaults.
