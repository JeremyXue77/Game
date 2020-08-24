//
//  NumberReactionGame.swift
//  Game
//
//  Created by Jeremy Xue on 2020/8/24.
//  Copyright © 2020 JeremyXue. All rights reserved.
//

import Foundation

struct NumberReactionGame {
    
    private(set) var numbers: [Int] = []
    private(set) var isPlaying = false
    var score = 0
    let limitCount: Int
    
    init(count: Int) {
        self.limitCount = count
    }
}

// MARK: - NumberReactionGame
extension NumberReactionGame {
    
    mutating func randomNumbers() {
        var randomNumbers: [Int] = []
        for _ in 1...limitCount {
            var randomNumber = Int.random(in: 1...100)
            while randomNumbers.contains(randomNumber) {
                randomNumber = Int.random(in: 1...100)
            }
            randomNumbers.append(randomNumber)
        }
        numbers = randomNumbers.sorted()
    }
    
    mutating func selectNumber(_ number: Int) {
        guard checkIsCorrect(number: number) else {
            return
        }
        numbers.removeFirst()
        
        if numbers.isEmpty {
            score += 1
            randomNumbers()
        }
    }
    
    mutating func removeAll() {
        numbers.removeAll()
    }
    
    func checkIsCorrect(number: Int) -> Bool {
        number == numbers.first
    }
}
