public import IO_Kernel
public import IP_Address
import Kernel
public import Sockets

extension Sockets.TCP.Connection {

    public static func connect(
        to address: IP.Address,
        // swift-linter:disable:next raw concept
        // REASON: a socket-level port number, handed straight to Kernel.Socket.Address, which holds it as UInt16; looked at RFC_3986.URI.Port, a component of a URI's authority in swift-standards that this package does not depend on and that says nothing about sockets.
        port: UInt16,
        io: IO<Sockets.Capabilities>
    ) async throws(Sockets.Error) -> sending Sockets.TCP.Connection {
        switch address {
        case .v4(let address):
            return try await connect(
                to: Kernel.Socket.Address.IPv4(ip: address, port: port),
                io: io
            )

        case .v6(let address):
            return try await connect(
                to: Kernel.Socket.Address.IPv6(ip: address, port: port),
                io: io
            )
        }
    }
}
