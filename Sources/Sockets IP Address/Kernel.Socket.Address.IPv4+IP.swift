public import IP_Address
public import Kernel
import Sockets

extension Kernel.Socket.Address.IPv4 {

    // swift-linter:disable:next raw concept
    // REASON: a socket-level port number, where 0 asks the kernel for a free port, handed straight to Kernel.Socket.Address, which holds it as UInt16; looked at RFC_3986.URI.Port, a component of a URI's authority in swift-standards that this package does not depend on and that says nothing about sockets.
    public init(ip: IPv4.Address, port: UInt16 = 0) {
        self.init(address: ip.bigEndian, port: port)
    }

    public var ip: IPv4.Address {
        IPv4.Address(rawValue: UInt32(bigEndian: address))
    }
}
