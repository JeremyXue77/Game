//
//  Card.swift
//  Game
//
//  Created by Jeremy Xue on 2020/8/20.
//  Copyright © 2020 JeremyXue. All rights reserved.
//

import Foundation

struct Card: Equatable {
    let displayEmoji: String
    var isMatched: Bool = true
    var isFaceUp: Bool = false
    
    static func ==(lhs: Card, rhs: Card) -> Bool {
        lhs.displayEmoji == rhs.displayEmoji && lhs.isFaceUp == rhs.isFaceUp
    }
}
