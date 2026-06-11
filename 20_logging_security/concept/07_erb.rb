#!/usr/bin/env ruby
# frozen_string_literal: true

# Problem: You need to generate text from a template — config files, HTML, emails.
# Example: A config file where host and port come from variables.
#
# Solution: ERB (stdlib) — embedded Ruby templating. Part of Ruby, no Rails needed.
# Visibility: `require 'erb'`. ERB.new(template).result(binding) renders it.

require 'erb'

# Simple template with variables
template = ERB.new(<<~TEMPLATE)
  server {
    listen <%= port %>;
    server_name <%= host %>;
    root <%= root_path %>;
  }
TEMPLATE

host = 'example.com'
port = 443
root_path = '/var/www/html'

result = template.result(binding)
puts result

# Usage: Template with loops
template2 = ERB.new(<<~TEMPLATE)
  Allowed users:
  <% users.each do |user| %>
    - <%= user %>
  <% end %>
TEMPLATE

users = %w[alice bob carol]
puts template2.result(binding)

# Usage: <% vs <%= vs <%#
# <% ... %>   — execute Ruby, no output
# <%= ... %>  — execute Ruby, insert result
# <%# ... %>  — comment, not executed

# This could also be done like this:
# String interpolation (fine for simple cases):
#
#   "server { listen #{port}; server_name #{host}; }"
#
# ERB is for when you have loops, conditionals, or reusable templates.
