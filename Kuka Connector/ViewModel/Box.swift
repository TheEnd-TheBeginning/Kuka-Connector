//
//  Box.swift
//  Kuka Connector
//
//  Created by Пользователь on 13.01.2023.
//

import Foundation

struct Box<T> {
    
    var value: T {
        didSet {
            action?(value)
        }
    }
    
    typealias Action = (T) -> Void
    
    private var action : Action?
    
    init(_ value: T) {
        self.value = value
    }
    
    mutating func set(value: T) {
        self.value = value
    }
    
    mutating func bind(action: @escaping Action) {
        self.action = action
    }
}
