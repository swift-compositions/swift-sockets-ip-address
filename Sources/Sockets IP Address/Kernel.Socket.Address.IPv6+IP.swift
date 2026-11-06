public import IP_Address
public import Kernel
import Sockets

extension Kernel.Socket.Address.IPv6 {

    public init(
        ip: IPv6.Address,
        // swift-linter:disable:next raw concept
        // REASON: a socket-level port number, where 0 asks the kernel for a free port, handed straight to Kernel.Socket.Address, which holds it as UInt16; looked at RFC_3986.URI.Port, a component of a URI's authority in swift-standards that this package does not depend on and that says nothing about sockets.
        port: UInt16 = 0,
        flowInfo: UInt32 = 0,
        scopeId: UInt32 = 0
    ) {
        self.init(
            segments: ip.segments,
            port: port,
            flowInfo: flowInfo,
            scopeId: scopeId
        )
    }

    public var ip: IPv6.Address {
        IPv6.Address(
            segments.0,
            segments.1,
            segments.2,
            segments.3,
            segments.4,
            segments.5,
            segments.6,
            segments.7
        )
    }
}
