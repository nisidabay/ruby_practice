# pack

Packs array elements into a binary string using template directives.

```ruby
# Pack integers as binary
[65, 66, 67].pack('C*') # => "ABC" (unsigned chars)

# Pack numbers
[1, 2, 3].pack('l*') # => binary string of longs

# Pack strings
['hello', 'world'].pack('a5a5') # => "helloworld"

# Common directive: pack to network byte order
[1024].pack('n') # => "\x04\x00" (16-bit network byte order)

# IP address packing
[192, 168, 1, 1].pack('C4') # => "\xC0\xA8\x01\x01"

# Unpack is the reverse
packed = [65, 66, 67].pack('C*')
packed.unpack('C*') # => [65, 66, 67]
```