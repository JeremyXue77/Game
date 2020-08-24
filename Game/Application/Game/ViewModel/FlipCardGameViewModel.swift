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
        checkFlipedCardMatch()
    }
    
    private func checkFlipedCardMatch() {
        guard game.selectedIndices.count == 2 else {
            return
        }
        let isMatched = game.checkCardsIsMatched()
        if isMatched {
            game.changeCardsIsMatched(isMatched: true)
        } else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { [weak self] in
                self?.game.changeCardsIsMatched(isMatched: false)
            }
        }
    }
    
    func startGame() {
        var second = 5
        game.start()
        repeatTiemr.start(timeInterval: 1) { [weak self](timer) in
            guard let self = self else { return }
            self.remainingSeconds.value = "\(second)s"
            if second > 0 {
                second -= 1
            } else {
                timer.stop()
                self.remainingSeconds.value = ""
                self.game.flipAllCards(false)
                self.game.isPlaying = true
            }
        }
    }
    
    func stopGame() {
        game.isPlaying = false
        game.flipAllCards(false)
    }
}
