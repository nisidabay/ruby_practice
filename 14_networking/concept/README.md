# Networking — HTTP, SSL, Sockets

Interact with web services and raw TCP/UDP without frameworks.
Pure stdlib: `net/http`, `uri`, `socket`, `json`.

## Quick Start

```bash
# HTTP client
ruby 01_http_get.rb                     # GET request with query params
ruby 02_http_post.rb                    # POST JSON body
ruby 04_timeout_ssl.rb                  # Timeouts, SSL

# Raw sockets
ruby 03_socket_client.rb                # TCP client, send raw HTTP

# Exercises
ruby ../exercises.rb                    # 3 exercises + BONUS (tiny web server)
```

## Learning Path

### HTTP Client (~25 min)

| Script | Concept |
|---|---|
| `01_http_get.rb` | `Net::HTTP.get_response`, URI, status codes |
| `02_http_post.rb` | `Net::HTTP#post`, JSON headers, `http.use_ssl = true` |
| `04_timeout_ssl.rb` | `open_timeout`, `read_timeout`, `Net::OpenTimeout`, SSL |

### Sockets (~10 min)

| Script | Concept |
|---|---|
| `03_socket_client.rb` | `Socket.tcp`, raw HTTP over TCP, `Connection: close` |

## Common Patterns

```ruby
# Simple GET
require "net/http"
response = Net::HTTP.get_response(URI("https://api.example.com/data"))
puts response.body if response.code == "200"

# SSL + timeouts
http = Net::HTTP.new(host, port)
http.use_ssl = true
http.open_timeout = 5   # give up connecting after 5s
http.read_timeout = 5   # give up waiting after 5s
response = http.get(path)

# POST with JSON
headers = {"Content-Type" => "application/json"}
body = {key: "value"}.to_json
response = http.post(path, body, headers)

# Raw TCP socket
require "socket"
Socket.tcp("host", 80) { |s| s.write "GET / HTTP/1.1\r\n\r\n" }
```

## Project Tool

```bash
# Health-check a URL
../project/fcheck https://httpbin.org/get
../project/fcheck --count 3 https://httpbin.org/get
```
