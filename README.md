# swift-sockets-ip-address

Use this package when you hold IP addresses as `IP.Address`, `IPv4.Address` or `IPv6.Address` values and want to connect or bind sockets from swift-sockets with them, without byte-order conversion. Start from `Sockets.TCP.Connection.connect(to:port:io:)` to connect to an `IP.Address`, or from `Kernel.Socket.Address.IPv4.init(ip:port:)` and `Kernel.Socket.Address.IPv6.init(ip:port:flowInfo:scopeId:)` to build a socket address. If you only need the address types, use swift-ip-address. If you already have socket addresses, use swift-sockets.

## Laws

- An `IPv4.Address` holds its number in host order, so 127.0.0.1 is `0x7F00_0001`. The socket address holds it in network order. `Kernel.Socket.Address.IPv4.ip` converts back, and the round trip is exact for every address and port.
- An IPv6 address's eight segments are copied unchanged into the socket address and back.
- `Sockets.TCP.Connection.connect(to:port:io:)` connects over IPv4 for a `v4` address and over IPv6 for a `v6` one. An IPv4-mapped IPv6 address still goes over IPv6. It makes one attempt to one address, with no fallback to another family.
