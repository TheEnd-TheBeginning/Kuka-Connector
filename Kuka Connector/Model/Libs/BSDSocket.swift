//
//  BSDSocket.swift
//  Kuka Connector
//
//  Created by Пользователь on 10.01.2023.
//

//        Привязка сокета к конкретному процессу (bind()) не требуется, т.к. сокет будет привязан к серверному Адресу и Порту через вызов функции connect()(по сути аналог bind() для Клиента)
//        let sockConnect = connect(self.sock, Server().servinfo!.pointee.ai_addr, socklen_t(Server().servinfo!.pointee.ai_addrlen))

import Foundation

class BSD_Socket {
    var sock: Int32
    
    init(Domain: Int32, Type: Int32, Protocol: Int32) {
        self.sock = socket(AF_INET, //Domain [AF_INET,AF_INET6, AF_UNIX]
                           SOCK_STREAM, //Type [SOCK_STREAM, SOCK_DGRAM, SOCK_SEQPACKET, SOCK_RAW]
                           IPPROTO_TCP  //Protocol [IPPROTO_TCP, IPPROTO_SCTP, IPPROTO_UDP, IPPROTO_DCCP]
        )//Return a FileDescriptor -1 = error
    }
    
    func connectSocket(ip: String, port: UInt16) -> Int32 {
        let isLittleEndian = Int(OSHostByteOrder()) == OSLittleEndian
        let htons  = isLittleEndian ? _OSSwapInt16 : { $0 }
                
        let port : UInt16 = port
        let ip_string : String = ip
        
        var sockAddress = sockaddr_in(
            sin_len: UInt8(MemoryLayout<sockaddr_in>.size),
            sin_family: sa_family_t(AF_INET),
            sin_port: htons(port),
            sin_addr: in_addr(s_addr: 0),
            sin_zero: (0, 0, 0, 0, 0, 0, 0, 0)
        )
        
        let _ = ip_string.withCString({ cs in
            inet_pton(AF_INET, cs, &sockAddress.sin_addr)
        })
        
        let socketAddressLength = socklen_t(MemoryLayout<sockaddr>.size)
        
        let connectSuccess = withUnsafePointer(to: &sockAddress, { $0.withMemoryRebound(to: sockaddr.self, capacity: 1) { zeroSockAddress in
            print("start connect")
            return connect(self.sock, zeroSockAddress, socklen_t(socketAddressLength))
        }})
        return connectSuccess
    }
    
    func closeSocket() {
        close(self.sock)
    }
}
