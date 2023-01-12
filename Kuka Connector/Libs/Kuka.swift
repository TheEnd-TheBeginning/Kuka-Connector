//
//  Kuka.swift
//  Kuka Connector
//
//  Created by Пользователь on 10.01.2023.
//

//Альтернативой для self.robot.read('$ROBNAME[]', debug=False).decode() является String(bytes: robot_name, encoding: .ascii) ?? ""

import Foundation

enum KukaActions: String, CaseIterable {
    case cartessian = "Получить координаты"
    func action(robot: Openshowvar) {
        switch self {
        case .cartessian:
            return Kuka.read_cartenssian(robot: robot)
        }
    }
}

class Kuka {
//    let name: String!
    static func read_name(robot: Openshowvar) -> String{
        let robot_name = robot.read("$ROBNAME[]")
        let name: String = String(bytes: robot_name, encoding: .ascii) ?? ""
        print("robot name: \(name)")
        return name
    }
    static func read_advanced(robot: Openshowvar) -> String {
        let robot_advance = robot.read("$ADVANCE")
        let advance = String(bytes: robot_advance, encoding: .ascii) ?? ""
        return advance
    }
    static func open_grip(robot: Openshowvar) {
        robot.write("OUT5", "False")
        robot.write("OUT6", "True")
        print("open")
    }
    static func close_grip(robot: Openshowvar) {
        robot.write("OUT5", "True")
        robot.write("OUT6", "False")
        print("close")
    }
    static func read_APO(robot: Openshowvar) -> String {
        let robot_APO = robot.read("$APO")
        let APO = String(bytes: robot_APO, encoding: .ascii) ?? ""
        return APO
    }
    static func ptp(robot: Openshowvar, arr: [Any]) {
        Kuka.send_Frame(robot: robot, arr, "COM_FRAME")
        robot.write("COM_CASEVAR", "1")
    }
    static func send_Frame(robot: Openshowvar, _ arr: [Any], _ system_variable: String = "") {
        var string_arr: [String] = []
        for element in arr {
            string_arr.append(element as? String ?? "")
        }
        let cartessian_string: String = "{FRAME: X " + string_arr[0] + ", Y " + string_arr[1] + ", Z " + string_arr[2] + ", A " + string_arr[3] + ", B " + string_arr[4] + ", C " + string_arr[5] + "}"
        print("cartessian string: \(cartessian_string)")
        robot.write(system_variable, cartessian_string)
    }
    
    static func read_base(robot: Openshowvar) -> (base_frame_x: Float, base_frame_y: Float, base_frame_z: Float, base_frame_A: Float, base_frame_B: Float, base_frame_C: Float){
        let base = robot.read("$BASE")
        let base_ascii: String = String(bytes: base, encoding: .ascii) ?? ""
        
        var replaced_base = base_ascii.replacingOccurrences(of: ",", with: "")
        replaced_base = replaced_base.replacingOccurrences(of: "{", with: "")
        replaced_base = replaced_base.replacingOccurrences(of: "}", with: "")
        var base_array = replaced_base.components(separatedBy: " ")
        print("base array: \(base_array)")
        
        let base_frame_x = Float(base_array[2]) ?? 0
        print("x_cartessian: \(base_frame_x)")
        let base_frame_y = Float(base_array[4]) ?? 0
        print("x_cartessian: \(base_frame_y)")
        let base_frame_z = Float(base_array[6]) ?? 0
        print("x_cartessian: \(base_frame_z)")
        let base_frame_A = Float(base_array[8]) ?? 0
        print("x_cartessian: \(base_frame_A)")
        let base_frame_B = Float(base_array[10]) ?? 0
        print("x_cartessian: \(base_frame_B)")
        let base_frame_C = Float(base_array[12]) ?? 0
        print("x_cartessian: \(base_frame_C)")
        return(base_frame_x, base_frame_y, base_frame_z, base_frame_A, base_frame_B, base_frame_C)
    }
    
    static func read_cartenssian(robot: Openshowvar) {
        let cartessian = robot.read("$POS_ACT")
        let cartessian_ascii: String = String(bytes: cartessian, encoding: .ascii) ?? ""
//        Строка преобразуется в такой формат:
//        Optional("\0\'\0\0\0{E6POS: X 329.857727, Y 1.60718048, Z 386.610535, A -157.715195, B -0.929982603, C 179.624176, S 2, T 3, E1 0.0, E2 0.0, E3 0.0, E4 0.0, E5 0.0, E6 0.0}\0\u{01}\u{01}\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0")
        
        var replaced_catessian = cartessian_ascii.replacingOccurrences(of: ",", with: "")
        var cartessian_array = replaced_catessian.components(separatedBy: " ")
        print("cartessian array: \(cartessian_array)")
        
        //x:329, y: 1.61, z: 386.61
        //A: -157.72, B: -0.93, C: 179.62
        let x_cartessian = Float(cartessian_array[2]) ?? 0
        print("x_cartessian: \(x_cartessian)")
        let y_cartessian = Float(cartessian_array[4]) ?? 0
        print("y_cartessian: \(y_cartessian)")
        let z_cartessian = Float(cartessian_array[6]) ?? 0
        print("z_cartessian: \(z_cartessian)")
        let A_cartessian = Float(cartessian_array[8]) ?? 0
        print("A_cartessian: \(A_cartessian)")
        let B_cartessian = Float(cartessian_array[10]) ?? 0
        print("B_cartessian: \(B_cartessian)")
        let C_cartessian = Float(cartessian_array[12]) ?? 0
        print("C_cartessian: \(C_cartessian)")
        let E1_cartessian = Float(cartessian_array[14]) ?? 0
        print("E1_cartessian: \(E1_cartessian)")
        let E2_cartessian = Float(cartessian_array[16]) ?? 0
        print("E2_cartessian: \(E2_cartessian)")
        let E3_cartessian = Float(cartessian_array[18]) ?? 0
        print("E3_cartessian: \(E3_cartessian)")
        let E4_cartessian = Float(cartessian_array[20]) ?? 0
        print("E4_cartessian: \(E4_cartessian)")
        let E5_cartessian = Float(cartessian_array[22]) ?? 0
        print("E5_cartessian: \(E5_cartessian)")
        let E6_cartessian = Float(cartessian_array[24]) ?? 0
        print("E6_cartessian: \(E6_cartessian)")
    }
}
