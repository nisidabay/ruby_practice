# Network & System — Practice Suite

DNS resolution, IP validation, UDP/Unix sockets, recursive file search, and
dependency sorting. All stdlib — no gems needed.

> **Prerequisites:** Groups 05 (filesystem), 14 (networking — TCP basics).
> Builds on TCP knowledge from group 14.

## Quick Start

```bash
# DNS & IP
ruby 01_resolv.rb                       # Resolv — DNS resolution
ruby 02_ipaddr.rb                       # IPAddr — IP validation and subnets

# Sockets
ruby 03_udp_socket.rb                   # UDPSocket — connectionless messaging
ruby 04_unix_socket.rb                  # UNIXSocket — local IPC

# System tools
ruby 05_find.rb                         # Find — recursive directory traversal
ruby 06_tsort.rb                        # TSort — topological sort of dependencies

# Putting it together
ruby 07_network_diagnostics.rb          # DNS + IP + TCP — full network check
```

## Learning Path

### DNS & IP (~15 min)

| Script | Concept |
|---|---|
| `01_resolv.rb` | `Resolv::DNS` — resolve hostnames, MX records, reverse DNS |
| `02_ipaddr.rb` | `IPAddr` — validate, compare, subnet iteration |

### Sockets (~20 min)

| Script | Concept |
|---|---|
| `03_udp_socket.rb` | `UDPSocket` — send/receive datagrams, broadcast |
| `04_unix_socket.rb` | `UNIXSocket` / `UNIXServer` — local IPC, socket pairs |

### System Tools (~15 min)

| Script | Concept |
|---|---|
| `05_find.rb` | `Find.find` — recursive traversal with `Find.prune` |
| `06_tsort.rb` | `TSort` — dependency ordering, cycle detection |

### Putting It Together (~10 min)

| Script | Concept |
|---|---|
| `07_network_diagnostics.rb` | Resolv + IPAddr + Socket — production diagnostic tool |

## Common Patterns

```ruby
# DNS resolution
resolver = Resolv::DNS.new
resolver.getaddresses('ruby-lang.org')

# IP subnet check
subnet = IPAddr.new('192.168.1.0/24')
subnet.include?(IPAddr.new('192.168.1.100'))  # => true

# UDP — fire and forget
socket = UDPSocket.new
socket.send('log message', 0, '127.0.0.1', 514)

# UNIX socket — local IPC
UNIXSocket.pair  # two connected sockets, no filesystem

# Recursive file search
Find.find('.') { |path| puts path if path.end_with?('.rb') }

# Dependency ordering
graph.tsort  # => ['configure', 'generate', 'compile', 'deploy']
```

## Now Build Your Own

Build a `service_monitor` that:
1. Uses `Resolv` to resolve a list of service hostnames
2. Uses `IPAddr` to check if they're in expected subnets
3. Uses `Socket.tcp` to verify each service is reachable
4. Uses `TSort` to order checks by dependency (DB before API before Web)
5. Reports results with clear PASS/FAIL for each service
