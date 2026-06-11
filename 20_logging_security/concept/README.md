# Logging & Security — Practice Suite

Production-ready Ruby: structured logging, cryptographic randomness, safe shell
execution, compression, templating, and system introspection. All stdlib — no gems.

> **Prerequisites:** Groups 01 (basics), 05 (filesystem), 09 (exceptions).
> `Syslog` was extracted from default gems in Ruby 3.4 — this group uses `Etc` instead.

## Quick Start

```bash
# Logging
ruby 01_logger_basics.rb                # Logger — levels, formatting, file output

# Security
ruby 02_securerandom.rb                 # SecureRandom — tokens, UUIDs, random numbers
ruby 04_shellwords.rb                   # Shellwords — safe shell command building

# System & Data
ruby 03_english.rb                      # English — readable names for Ruby globals
ruby 05_etc.rb                          # Etc — system users, groups, user info
ruby 06_zlib.rb                         # Zlib — gzip compression/decompression
ruby 07_erb.rb                          # ERB — embedded Ruby templating

# Putting it together
ruby 08_production_script.rb            # Logger + SecureRandom + Shellwords + English
```

## Learning Path

### Logging (~10 min)

| Script | Concept |
|---|---|
| `01_logger_basics.rb` | `Logger` — levels, formatting, file output |

### Security (~20 min)

| Script | Concept |
|---|---|
| `02_securerandom.rb` | `SecureRandom` — hex, base64, UUID, random numbers |
| `04_shellwords.rb` | `Shellwords` — escape and join shell arguments safely |

### System & Data (~25 min)

| Script | Concept |
|---|---|
| `03_english.rb` | `English` — `$ERROR_INFO` instead of `$!` |
| `05_etc.rb` | `Etc` — system users, groups, passwd/group databases |
| `06_zlib.rb` | `Zlib` — gzip, gunzip, deflate, inflate |
| `07_erb.rb` | `ERB` — `<%= %>`, `<% %>`, templates with binding |

### Putting It Together (~10 min)

| Script | Concept |
|---|---|
| `08_production_script.rb` | Logger + SecureRandom + Shellwords + English combined |

## Common Patterns

```ruby
# Logger — leveled, formatted
logger = Logger.new($stdout)
logger.level = Logger::INFO
logger.info('Operation started')

# SecureRandom — cryptographic randomness
SecureRandom.urlsafe_base64(32)  # token
SecureRandom.uuid                 # UUID v4

# Shellwords — safe shell commands
Shellwords.shelljoin(['rsync', '-av', 'src/', 'dst with spaces/'])

# English — readable globals
raise 'boom' rescue puts $ERROR_INFO.message  # not $!

# Zlib — compression
Zlib.gzip(data)   # compress
Zlib.gunzip(data) # decompress

# ERB — templating
ERB.new('Hello, <%= name %>!').result(binding)
```

## Now Build Your Own

Build a `deploy` script that:
1. Generates a secure deployment token with `SecureRandom`
2. Logs every step with `Logger` (to both stdout and a file)
3. Compresses the build artifacts with `Zlib`
4. Uses `Shellwords` to safely build the rsync command
5. Checks `$CHILD_STATUS` (via `English`) after each command

Make it a single runnable script that deploys a directory to a remote path.
