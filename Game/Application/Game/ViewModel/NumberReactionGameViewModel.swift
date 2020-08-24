//
//  NumberReactionGameViewModel.swift
//  Game
//
//  Created by Jeremy Xue on 2020/8/24.
//  Copyright © 2020 JeremyXue. All rights reserved.
//

import Foundation

class NumberReactionGameViewModel {
    
    // MARK: Properties
    private var game: NumberReactionGame {
        didSet {
            updateBoxProperties()
        }
    }
    private let countDownTimer: RepeatTimer = .init()
    
    // MARK: Initializers
    init(game: NumberReactionGame) {
        self.game = game
        updateBoxProperties()
    }
    
    private func updateBoxProperties() {
        numbers.value = game.numbers
        score.value = "Score: \(game.score)"
    }
    
    // MARK: Box properties
    private(set) var numbers: Box<[Int]> = .init([])
    private(set) var remainingSeconds: Box<String> = .init("")
    private(set) var isEnded: Box<Bool> = .init(false)
    private(set) var score: Box<String> = .init("Score: 0")
    
    var numbersCount: Int {
        game.limitCount
    }
}

extension NumberReactionGameViewModel {
    
    func startGame() {
        game.randomNumbers()
        game.score = 0
        isEnded.value = false
        var second = 30
        countDownTimer.start(timeInterval: 1) { [weak self](timer) in
            self?.remainingSeconds.value = "\(second)s"
            if second <= 0 {
                timer.stop()
                self?.stopGame()
            }
            second -= 1
        }
    }
    
    func stopGame() {
        isEnded.value = true
        game.removeAll()
    }
    
    func select(number: Int) {
        if isEnded.value { return }
        game.selectNumber(number)
    }
}
