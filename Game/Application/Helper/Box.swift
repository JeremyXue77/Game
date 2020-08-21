//
//  Box.swift
//  Game
//
//  Created by Jeremy Xue on 2020/8/21.
//  Copyright © 2020 JeremyXue. All rights reserved.
//

import Foundation

class Box<Value> {
    
    typealias ValueChangedAction = (Value) -> Void
    private var valueChangedAction: ValueChangedAction?
    var value: Value {
        didSet {
            valueChangedAction?(value)
        }
    }
    
    init(_ value: Value) {
        self.value = value
    }
    
    func bind(_ action: @escaping ValueChangedAction) {
        valueChangedAction = action
        valueChangedAction?(value)
    }
    
    func cancel() {
        valueChangedAction = nil
    }
}
