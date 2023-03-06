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
    
    func connect(ip: String, port: UInt16) -> Bool {
        self.ip = ip
        self.port = port
        self.sock = BSD_Socket(Domain: AF_INET, Type: SOCK_STREAM, Protocol: IPPROTO_TCP)
        if self.sock?.sock == -1 {
            print("Error creating BSD Socket")
            return false
        } else {
            let sockConnect = self.sock?.connectSocket(ip: self.ip!, port: self.port!)
            if (sockConnect == -1) {
                print("Error connecting BSD Socket")
                return false
            } else {
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
}
