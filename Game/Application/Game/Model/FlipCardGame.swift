//
//  FlipCardGame.swift
//  Game
//
//  Created by Jeremy Xue on 2020/8/20.
//  Copyright © 2020 JeremyXue. All rights reserved.
//

import Foundation

struct FlipCardGame {
    
    private(set) var cards: [Card]
    var handCardIndices: [Int] = []
    
    var isPlaying: Bool {
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
    
    mutating func flip(at index: Int) {
        guard isPlaying && !cards[index].isMatched && handCardIndices.count < 2 else {
            return
        }
        cards[index].isFaceUp.toggle()
        if cards[index].isFaceUp {
            handCardIndices.append(index)
        } else {
            handCardIndices.removeAll()
        }
    }
    
    func checkHandCardIsMatched() -> Bool {
        var selecetedCards: [Card] = []
        for index in handCardIndices {
            let card = cards[index]
            selecetedCards.append(card)
        }
        return (selecetedCards.first == selecetedCards.last)
    }
    
    mutating func setHandCards(indices: [Int], isMatched: Bool) {
        for index in indices {
            cards[index].isFaceUp = isMatched
            cards[index].isMatched = isMatched
        }
    }
    
    mutating func showAllCards() {
        for index in cards.indices {
            cards[index].isFaceUp = true
            cards[index].isMatched = true
        }
    }
    
    mutating func start() {
        for index in cards.indices {
            cards[index].isFaceUp = false
            cards[index].isMatched = false
        }
    }
    
    mutating func stop() {
        for index in cards.indices {
            cards[index].isFaceUp = false
            cards[index].isMatched = true
        }
        cards.shuffle()
    }
}
