//
//  ModelEnums.swift
//  Kuka Connector
//
//  Created by Пользователь on 06.03.2023.
//

import Foundation

enum KukaVariablesEnum: String, CaseIterable {
    case x = "x"
    case y = "y"
    case z = "z"
    case A = "A"
    case B = "B"
    case C = "C"
    case velocity = "velocity"
    case grip = "grip"
}

enum KukaActions: String, CaseIterable {
    case read_cartessian = "Получить координаты"
    case read_name = "Узнать имя робота"
//    case read_advanced = ""
    case open_grip = "Открыть захват"
    case close_grip = "Закрыть захват"
//    case read_APO = ""
//    case ptp = ""
//    case read_base = ""
//    case cvbase = ""
    case ptp = "Задать координаты"
//    case set_tool = ""
//    case read_input = ""
//    case read_out = ""
    case read_tcp_velocity = "Узнать скорость"
//    case read_tool = ""
}
