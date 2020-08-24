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
    private let repeatTiemr: RepeatTimer = .init()
    
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
        gameMatchHandle()
    }
    
    private func gameMatchHandle() {
        if game.handCardIndices.count != 2 { return }
        let isMatched = game.checkHandCardIsMatched()
        let cached = game.handCardIndices
        game.handCardIndices.removeAll()
        if isMatched {
            game.setHandCards(indices: cached, isMatched: true)
        } else {
            var deley = 1
            Timer.scheduledTimer(withTimeInterval: 1,
                                 repeats: true,
                                 block: {
                                    [weak self](timer) in
                                    guard let self = self else { return }
                                    if deley == 0 {
                                        timer.invalidate()
                                        self.game.setHandCards(indices: cached, isMatched: false)
                                    }
                                    deley -= 1
                                    
            }).fire()
        }
    }
    
    func startGame() {
        var second = 5
        game.showAllCards()
        repeatTiemr.start(timeInterval: 1) { [weak self](timer) in
            guard let self = self else { return }
            self.remainingSeconds.value = "\(second)s"
            if second > 0 {
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
