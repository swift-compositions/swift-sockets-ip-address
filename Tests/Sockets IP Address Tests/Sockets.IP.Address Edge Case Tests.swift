import Kernel
import Sockets_IP_Address
import Testing

extension `Sockets IP Address Tests`.`Edge Case` {

    @Test
    func `the kernel's IPv4 loopback reads back as 127 0 0 1`() {
        let loopback = Kernel.Socket.Address.IPv4.loopback(port: 8080)
        #expect(loopback.ip == IPv4.Address(rawValue: 0x7F00_0001))
        #expect(loopback.port == 8080)
    }

    @Test
    func `127 0 0 1 converted to a socket address equals the kernel's loopback`() {
        let converted = Kernel.Socket.Address.IPv4(ip: IPv4.Address(rawValue: 0x7F00_0001), port: 8080)
        #expect(converted.address == Kernel.Socket.Address.IPv4.loopback(port: 8080).address)
    }

    @Test
    func `the kernel's IPv6 loopback reads back as colon colon 1`() {
        let loopback = Kernel.Socket.Address.IPv6.loopback(port: 8443)
        #expect(loopback.ip == IPv6.Address(0, 0, 0, 0, 0, 0, 0, 1))
        #expect(loopback.port == 8443)
    }

    @Test(arguments: [UInt32(0), 0xFFFF_FFFF, 0x0102_0304])
    func `IPv4 extremes and asymmetric addresses survive the conversion`(_ raw: UInt32) {
        let socket = Kernel.Socket.Address.IPv4(ip: IPv4.Address(rawValue: raw), port: 65_535)
        #expect(socket.ip == IPv4.Address(rawValue: raw))
        #expect(socket.port == 65_535)
    }

    @Test
    func `IPv6 all-ones and the unspecified address survive the conversion`() {
        let ones = IPv6.Address(0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF)
        #expect(Kernel.Socket.Address.IPv6(ip: ones, port: 0).ip == ones)
        let unspecified = IPv6.Address(0, 0, 0, 0, 0, 0, 0, 0)
        #expect(Kernel.Socket.Address.IPv6(ip: unspecified).port == 0)
        #expect(Kernel.Socket.Address.IPv6(ip: unspecified).ip == unspecified)
    }
}
