#!/usr/bin/env ruby
# frozen_string_literal: true

# 02_yaml.rb — YAML: human-readable config files (superset of JSON)
#
# WITHOUT YAML — config in raw Ruby or .ini-style parsing:
#
#   # config.rb: DATABASE = {host: "db1", pool: 10} — needs eval, unsafe
#   # config.ini: [database]\nhost=db1 — no nesting, manual parsing
#
# WITH YAML — readable, nested, standard, safe (YAML.safe_load):

require "yaml"
require "tempfile"

# Parse: YAML string → Ruby Hash
config_yaml = <<~YAML
  database:
    host: db.internal
    port: 5432
    pool: 10
  redis:
    host: cache.internal
    port: 6379
  features:
    - dark_mode
    - export_pdf
YAML

config = YAML.safe_load(config_yaml)
puts "DB host:  #{config["database"]["host"]}"
puts "Redis:    #{config["redis"]["host"]}:#{config["redis"]["port"]}"
puts "Features: #{config["features"].join(", ")}"

# Generate: Ruby Hash → YAML string
Tempfile.create(["deploy", ".yml"]) do |tmp|
  deploy = {
    "service" => "web",
    "version" => "2.4.1",
    "rollback" => false,
    "steps" => ["migrate", "restart", "health_check"]
  }
  tmp.write(YAML.dump(deploy))
  tmp.rewind

  puts "\nGenerated YAML:"
  puts File.read(tmp.path)
end

# YAML.safe_load — only parses basic types (safe for untrusted input).
# YAML.load — parses everything including Ruby objects (DANGEROUS for untrusted input).
# YAML.dump — Ruby → YAML
# YAML is a superset of JSON: valid JSON is valid YAML.
