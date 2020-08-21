//
//  FlipCardGame.swift
//  Game
//
//  Created by Jeremy Xue on 2020/8/20.
//  Copyright © 2020 JeremyXue. All rights reserved.
//

import Foundation

class FlipCardGame {
    
    private(set) var cards: [Card]
    private var selectedIndices: [Int] = []
    private var handCards: [Card] {
        cards.filter { ($0.isFaceUp && !$0.isMatched) }
    }
    private var isPlaying: Bool {
        (cards.map { $0.isMatched }.contains(false))
    }
    
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
        guard isPlaying && !cards[index].isMatched else {
            return
        }
        
        if handCards.count == 2 {
            if handCards.first == handCards.last {
                for (index, card) in cards.enumerated() {
                    if card == handCards.first {
                        cards[index].isMatched = true
                    }
                }
            } else {
                flipUnmatchCardsToBack()
            }
        }
        
        if cards.map({$0.isMatched}).contains(false) {
            cards[index].isFaceUp.toggle()
        }
    }
    
    private func flipUnmatchCardsToBack() {
        for (index, card) in cards.enumerated() {
            if !card.isMatched {
                cards[index].isFaceUp = false
            }
        }
    }
    
    func showAllCards() {
        for index in cards.indices {
            cards[index].isFaceUp = true
            cards[index].isMatched = true
        }
    }
    
    func start() {
        for index in cards.indices {
            cards[index].isFaceUp = false
            cards[index].isMatched = false
        }
    }
    
    func stop() {
        for index in cards.indices {
            cards[index].isFaceUp = false
            cards[index].isMatched = true
        }
        cards.shuffle()
    }
}
