//
//  Openshowvar.swift
//  Kuka Connector
//
//  Created by Пользователь on 10.01.2023.
//

import Foundation

class Openshowvar {
    var ip: String?
    var port: UInt16?
    var msg_id: Int = Int.random(in: 1...100)
    var sock: BSD_Socket?
//    var can_connect: Box<Bool> = Box(false)
//    init() {
//        self.ip = "127.0.0.1"
//        self.port = 0
//        self.msg_id = Int.random(in: 1...100)
//        self.sock = BSD_Socket(Domain: AF_INET, Type: SOCK_STREAM, Protocol: IPPROTO_TCP)
//        print("Void init")
//    }
    func connect(ip: String, port: UInt16) -> Bool {
        self.ip = ip
        self.port = port
//        self.msg_id = Int.random(in: 1...100)
        self.sock = BSD_Socket(Domain: AF_INET, Type: SOCK_STREAM, Protocol: IPPROTO_TCP)
        if self.sock?.sock == -1 {
            print("Error creating BSD Socket")
//            self.can_connect.value = false
            return false
        } else {
            let sockConnect = self.sock?.connectSocket(ip: self.ip!, port: self.port!)
            if (sockConnect == -1) {
                print("Error connecting BSD Socket")
//                self.can_connect.value = false
                return false
            } else {
//                self.can_connect.value = true
                return true
            }
        }
    }
    
    func read(_ varname: String) -> [UInt8] {
        ///Переменная, содержащая сообщение для отправки через сокет в байт коде
        var sendBuffer: [UInt8] = []
        
        //2 байта под id сообщения(Tag ID)
        var test = UInt16(self.msg_id).littleEndian
        var test81 = UInt8(test >> 8 & 0x00ff)
        var test82 = UInt8(test & 0x00ff)
        sendBuffer.append(test81)
        sendBuffer.append(test82)
        //2 байта под длину сообщения(Message Length)
        //var_name_len + 3
        test = UInt16(varname.count + 3).littleEndian
        test81 = UInt8(test >> 8 & 0x00ff)
        test82 = UInt8(test & 0x00ff)
        sendBuffer.append(test81)
        sendBuffer.append(test82)
        //1 байт под flag(Message Type, Value: 0)
        let flag = 0
        sendBuffer.append(UInt8(flag))
        //2 байта под длину названия переменной(Length of Variable Name, LVN)
        test = UInt16(varname.count).littleEndian
        test81 = UInt8(test >> 8 & 0x00ff)
        test82 = UInt8(test & 0x00ff)
        sendBuffer.append(test81)
        sendBuffer.append(test82)
        
        //То, что выше, обязательная шапка. Без неё ничего не работает
        //Байтовая строка под название переменной(Variable Name)
        let varname_array: [UInt8] = Array(varname.utf8)
        
        sendBuffer += varname_array
        
        let sendSuccess = send(self.sock!.sock, &sendBuffer, sendBuffer.count, 0)
                
        var recvBuffer = [UInt8](repeating: 0, count: 256)
        let recvSuccess = recv(self.sock!.sock, &recvBuffer, 256, 0)
        return recvBuffer
    }
    
    @discardableResult
    func write(_ varname: String, _ value: String) -> [UInt8] {
        ///Переменная, содержащая сообщение для отправки через сокет в байт коде
        var sendBuffer: [UInt8] = []
        
        //2 байта под id сообщения(Tag ID)
        var test = UInt16(self.msg_id).littleEndian
        var test81 = UInt8(test >> 8 & 0x00ff)
        var test82 = UInt8(test & 0x00ff)
        sendBuffer.append(test81)
        sendBuffer.append(test82)
        //2 байта под длину сообщения(Message Length)
        //var_name_len + 3 + 2 + value_len
        test = UInt16(varname.count + 3 + 2 + value.count).littleEndian
        test81 = UInt8(test >> 8 & 0x00ff)
        test82 = UInt8(test & 0x00ff)
        sendBuffer.append(test81)
        sendBuffer.append(test82)
        //1 байт под flag(Message Type, Value: 1)
        let flag = 1
        sendBuffer.append(UInt8(flag))
        //2 байта под длину названия переменной(Length of Variable Name, LVN)
        test = UInt16(varname.count).littleEndian
        test81 = UInt8(test >> 8 & 0x00ff)
        test82 = UInt8(test & 0x00ff)
        sendBuffer.append(test81)
        sendBuffer.append(test82)
        
        //То, что выше, обязательная шапка. Без неё ничего не работает
        //Байтовая строка под название переменной(Variable Name)
        let varname_array: [UInt8] = Array(varname.utf8)
        
        sendBuffer += varname_array
        
        //2 байта под длину значения переменной(Length of Variable Value, LVV)
        test = UInt16(value.count).littleEndian
        test81 = UInt8(test >> 8 & 0x00ff)
        test82 = UInt8(test & 0x00ff)
        sendBuffer.append(test81)
        sendBuffer.append(test82)
        
        //Байтовая строка под значение переменной(Variable Value)
        print(value)
        let value_array: [UInt8] = Array(value.utf8)
        
        sendBuffer += value_array
        
        print("sendBuffer: \(sendBuffer)")
        
        let sendSuccess = send(self.sock!.sock, &sendBuffer, sendBuffer.count, 0)
        
        var recvBuffer = [UInt8](repeating: 0, count: 256)
        let recvSuccess = recv(self.sock!.sock, &recvBuffer, 256, 0)
        return recvBuffer
    }
    
//    def read(self, var, debug=True):
//        if not isinstance(var, str):
//            raise Exception('Var name is a string'
//        else:
//            self.varname = var if PY2 else var.encode(ENCODING)
//        return self._read_var(debug)
            
//    def write(self, var, value, debug=True):
//        if not (isinstance(var, str) and isinstance(value, str)):
//            raise Exception('Var name and its value should be string')
//        self.varname = var if PY2 else var.encode(ENCODING)
//        self.value = value if PY2 else value.encode(ENCODING)
//        return self._write_var(debug)
        
//    def _pack_read_req(self):
//        var_name_len = len(self.varname)
//        flag = 0
//        req_len = var_name_len + 3
//        return struct.pack(
//            '!HHBH'+str(var_name_len)+'s',
//            self.msg_id,
//            req_len,
//            flag,
//            var_name_len,
//            self.varname
//            )

//    def _pack_write_req(self):
//        var_name_len = len(self.varname)
//        flag = 1
//        value_len = len(self.value)
//        req_len = var_name_len + 3 + 2 + value_len
//        return struct.pack(
//            '!HHBH'+str(var_name_len)+'s'+'H'+str(value_len)+'s',
//            self.msg_id,
//            req_len,
//            flag,
//            var_name_len,
//            self.varname,
//            value_len,
//            self.value
//            )
    
//    def _read_var(self, debug):
//        req = self._pack_read_req()
//        self._send_req(req)
//        _value = self._read_rsp(debug)
//        if debug:
//            print(_value)
//        return _value
            
//    def _write_var(self, debug):
//        req = self._pack_write_req()
//        self._send_req(req)
//        _value = self._read_rsp(debug)
//        if debug:
//            print(_value)
//        return _value
    
//    def _read_rsp(self, debug=False):
//        if self.rsp is None: return None
//        var_value_len = len(self.rsp) - struct.calcsize('!HHBH') - 3
//        result = struct.unpack('!HHBH'+str(var_value_len)+'s'+'3s', self.rsp)
//        _msg_id, body_len, flag, var_value_len, var_value, isok = result
//        if debug:
//            print('[DEBUG]', result)
//        if result[-1].endswith(b'\x01') and _msg_id == self.msg_id:
//            self.msg_id = (self.msg_id + 1) % 65536  # format char 'H' is 2 bytes long
//            return var_value
}
