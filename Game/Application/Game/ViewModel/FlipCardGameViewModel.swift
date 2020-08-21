//
//  FlipCardGameViewModel.swift
//  Game
//
//  Created by Jeremy Xue on 2020/8/21.
//  Copyright © 2020 JeremyXue. All rights reserved.
//

import Foundation

class FlipCardGameViewModel {
    
    // MARK: Properties
    private var game: FlipCardGame {
        didSet {
            cards.value = game.cards
        }
    }
    private var repeatTiemr: RepeatTimer = .init()
    
    // MARK: Initializers
    init(game: FlipCardGame) {
        self.game = game
        cards.value = game.cards
    }
    
    // MARK: Box Properties
    private(set) var cards: Box<[Card]> = .init([])
    private(set) var remainingSeconds: Box<String> = .init("")
}

// MARK: - Methods
extension FlipCardGameViewModel {
    
    func flipCard(at index: Int) {
        game.flip(at: index)
    }
    
    func startGame() {
        var second = 5
        game.showAllCards()
        repeatTiemr.start(timeInterval: 1) { [unowned self](timer) in
            print(second)
            self.remainingSeconds.value = "\(second)"
            if second >= 0 {
                second -= 1
            } else {
                timer.stop()
                self.remainingSeconds.value = ""
                self.game.start()
            }
        }
    }
    
    func stopGame() {
        game.stop()
    }
}
