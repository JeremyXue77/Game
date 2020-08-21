//
//  FlipCardGame.swift
//  Game
//
//  Created by Jeremy Xue on 2020/8/20.
//  Copyright © 2020 JeremyXue. All rights reserved.
//

import Foundation

class FlipCardGame {
    
    private(set) var isStarting = false
    private(set) var cards: [Card]
    private var selectedIndices: [Int] = []
    
    init() {
        let emojis = ["🎮", "🤖", "👨🏻‍💻", "⚠️", "🎉", "😎"]
        var cards = [Card]()
        for emoji in emojis {
            let card = Card(displayEmoji: emoji)
            cards.append(card)
            cards.append(card)
        }
        self.cards = cards.shuffled()
    }
}

// MARK: - Methods
extension FlipCardGame {
    
    func flip(at index: Int) {
        if !isStarting { return }
        if cards[index].isMatched { return }
        let frontCards = cards.filter({ $0.isFaceUp && !$0.isMatched })
        if frontCards.count == 2 {
            if frontCards.first == frontCards.last {
                for (index, card) in cards.enumerated() {
                    if card == frontCards.first {
                        cards[index].isMatched = true
                    }
                }
            } else {
                flipUnmatchCardsToBack()
            }
        }
        cards[index].isFaceUp.toggle()
    }
    
    func flipUnmatchCardsToBack() {
        for (index, card) in cards.enumerated() {
            if !card.isMatched {
                cards[index].isFaceUp = false
            }
        }
    }
    
    func showAllCards() {
        isStarting = false
        for index in cards.indices {
            cards[index].isFaceUp = true
            cards[index].isMatched = true
        }
    }
    
    func start() {
        isStarting = true
        for index in cards.indices {
            cards[index].isFaceUp = false
            cards[index].isMatched = false
        }
    }
    
    func stop() {
        isStarting = true
        for index in cards.indices {
            cards[index].isFaceUp = false
            cards[index].isMatched = false
        }
        cards.shuffle()
    }
}
