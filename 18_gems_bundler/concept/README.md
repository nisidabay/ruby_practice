# Gems & Bundler — Practice Suite

Ruby's package system: how to use gems, create your own, manage dependencies,
and publish to RubyGems.org. Everything here uses Ruby's built-in tools —
no external gems needed.

> **Prerequisites:** Groups 01 (basics), 05 (filesystem), 07 (modules).
> RubyGems and Bundler are part of Ruby itself.

## Quick Start

```bash
# Understanding gems
ruby 01_what_is_a_gem.rb                # What gems are, where they live
ruby 08_gem_introspection.rb            # Inspect any installed gem

# Managing dependencies
ruby 02_gemfile_basics.rb               # Gemfile — declare your dependencies
ruby 03_version_operators.rb            # ~>, >=, = — version specification
ruby 07_require_and_bundler.rb          # require vs Bundler.require

# Creating gems
ruby 04_gemspec.rb                      # .gemspec — describe your gem
ruby 05_gem_dependencies.rb             # Runtime vs development dependencies
ruby 09_build_install_gem.rb            # Build and install a gem locally

# Advanced
ruby 06_local_gems.rb                   # Use gems from disk or git
ruby 10_publishing.rb                   # Push to RubyGems.org
```

## Learning Path

### Understanding Gems (~20 min)

| Script | Concept |
|---|---|
| `01_what_is_a_gem.rb` | What gems are, RubyGems, gem paths |
| `08_gem_introspection.rb` | `Gem::Specification` — inspect gem metadata and files |

### Managing Dependencies (~25 min)

| Script | Concept |
|---|---|
| `02_gemfile_basics.rb` | Gemfile — declare project dependencies |
| `03_version_operators.rb` | `~>`, `>=`, `=` — version specification |
| `07_require_and_bundler.rb` | `require` vs `Bundler.require` |

### Creating Gems (~30 min)

| Script | Concept |
|---|---|
| `04_gemspec.rb` | `.gemspec` — describe your gem |
| `05_gem_dependencies.rb` | `add_dependency` vs `add_development_dependency` |
| `09_build_install_gem.rb` | Full cycle: code → gemspec → .gem file → install |

### Advanced (~15 min)

| Script | Concept |
|---|---|
| `06_local_gems.rb` | `path:` and `git:` — use gems without publishing |
| `10_publishing.rb` | `gem push`, `gem yank`, versioning rules |

## Common Patterns

```ruby
# Gemfile — declare dependencies
source 'https://rubygems.org'
gem 'json', '~> 2.0'
gem 'minitest', '~> 5.0', group: :test

# .gemspec — describe your gem
Gem::Specification.new do |spec|
  spec.name    = 'my_gem'
  spec.version = '0.1.0'
  spec.summary = 'Does something useful'
  spec.authors = ['Your Name']
  spec.files   = Dir['lib/**/*.rb']
  spec.require_paths = ['lib']
  spec.add_dependency 'json', '~> 2.0'
end

# Inspect any gem
spec = Gem::Specification.find_by_name('json')
puts spec.version, spec.gem_dir, spec.dependencies

# Version requirements
req = Gem::Requirement.new('~> 1.2')
req.satisfied_by?(Gem::Version.new('1.2.5'))  # => true
req.satisfied_by?(Gem::Version.new('2.0.0'))  # => false
```

## Now Build Your Own

Create a real gem called `file_summary` that takes a file path and returns
a hash with: size, line count, word count, and last modified time. Write the
code in `lib/file_summary.rb`, create a `.gemspec`, build it with `gem build`,
and test it with `gem install`.

Hint: Use `File.stat`, `File.foreach`, and `String#split`. No external gems needed.
