#!/usr/bin/env ruby
# frozen_string_literal: true

# 05_caller_locations.rb — caller_locations: structured stack inspection
#
# caller returns strings ("file:line:in `method'"). caller_locations returns
# Thread::Backtrace::Location objects — you can query path, lineno, label
# without string parsing.
#
# WITHOUT caller_locations — string slicing and regex:
#
#   caller.first.match(/`(\w+)'/)  # fragile string parsing to extract method name
#
# WITH caller_locations — structured access:

def log_operation(data)
  loc = caller_locations(1, 1).first  # 1 frame up, 1 frame only
  puts "[#{File.basename(loc.path)}:#{loc.lineno}] #{loc.label} → #{data}"
end

def create_user(name)
  log_operation("creating user: #{name}")
end

def provision_server(host)
  log_operation("provisioning: #{host}")
end

create_user("Carlos")
provision_server("web-01.internal")

# caller_locations is like caller but with objects instead of strings:
#   loc.path     → full file path
#   loc.lineno   → line number
#   loc.label    → method name
#   loc.base_label → method name without block suffix
#   loc.absolute_path → resolved symlinks

# Use for: logging frameworks, custom profilers, audit trails
# Skip it for: normal error handling (use raise + backtrace instead)
