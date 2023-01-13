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
        //        socket(_: Int32, _: Int32, _: Int32)int nonBlocking = 1;
//        var opt = fcntl(self.sock, F_GETFL)
//        print("unblocked: \(opt)")
//        opt |= O_NONBLOCK
//        let result = fcntl(sock, F_SETFL, opt)
//        print("result: \(result)")
        var flags = fcntl(self.sock , F_GETFL, 0)
        fcntl(self.sock , F_SETFL, flags|O_NONBLOCK)
        var imode: Int32 = 1
        ioctl(sock , UInt(O_NONBLOCK), &imode)
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
                
        // Принудительное преобразование указателя Swift сложнее, чем OC
//       let pointer: UnsafePointer = withUnsafePointer(to: &sockAddress, {$0.withMemoryRebound(to: sockaddr.self, capacity: 1, {$0})})
//
//        var result = connect(self.sock, pointer, socklen_t(MemoryLayout.size(ofValue: sockAddress)))
        
        let connectSuccess = withUnsafePointer(to: &sockAddress, { $0.withMemoryRebound(to: sockaddr.self, capacity: 1) { zeroSockAddress in
            print("start connect")
            let success = connect(self.sock, zeroSockAddress, socklen_t(socketAddressLength))
//            var errinfo: Int32 = 1
//            var errlen: Int32 = 1
//            if (-1 == getsockopt(self.sock, SOL_SOCKET, SO_ERROR, &errinfo, &errlen)) {
//                print("sad")
//            }
            if (success == 0) {
                return success
            } else {
                print("Get The Connect Result by select().\n")
                if (errno == EINPROGRESS) {
                    var rfds: fd_set = fd_set()
                    var wfds: fd_set = fd_set()
                    __darwin_fd_set(self.sock, &rfds)
                    __darwin_fd_set(self.sock, &wfds)
                    var timeout:timeval = timeval(tv_sec: 5, tv_usec: 0)
                    let status = select(self.sock + 1, &rfds, &wfds, nil, &timeout)
                    if (status == 0) {
                        print("status")
                        return success
                    } else {
                        print("success")
                        if ((__darwin_fd_isset(self.sock, &rfds) != 0) || (__darwin_fd_isset(self.sock, &wfds) != 0)){
                            var errinfo: Int32 = 1, errlen: Int32 = 1
                            if (-1 == getsockopt(self.sock, SOL_SOCKET, SO_ERROR, &errinfo, &errlen)){
                                print("getsockopt return -1.\n")
                            } else if (0 != errinfo) {
                                print("getsockopt return errinfo = %d.\n", errinfo)
                            }
                        }
                        return 0
                    }
                } else {
                    return success
                }
            }
//            return success
//            var timeout:timeval = timeval(tv_sec: 5, tv_usec: 0)
//            let status = select(self.sock + 1, nil, nil, nil, &timeout)
//            if status == 0 {
//                print("status")
//                return success
//            } else {
//                print("success")
//                return success
//            }
        }})
        return connectSuccess
    }
    
    func closeSocket() {
        close(self.sock)
    }
}
