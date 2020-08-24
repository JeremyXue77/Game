//
//  FlipCardGame.swift
//  Game
//
//  Created by Jeremy Xue on 2020/8/20.
//  Copyright © 2020 JeremyXue. All rights reserved.
//

import Foundation

struct FlipCardGame {
    
    // MARK: Properties
    var cards: [Card]
    var selectedIndices: Set<Int> = []
    var isPlaying: Bool = false
    
    // MARK: Initializers
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
        guard isPlaying && !cards[index].isMatched && selectedIndices.count < 2 else {
            return
        }
        cards[index].isFaceUp.toggle()
        if cards[index].isFaceUp {
            selectedIndices.insert(index)
        } else {
            selectedIndices.remove(index)
        }
    }
    
    func checkCardsIsMatched() -> Bool {
        var selecetedCards: [Card] = []
        for index in selectedIndices {
            let card = cards[index]
            selecetedCards.append(card)
        }
        return (selecetedCards.first == selecetedCards.last)
    }
    
    mutating func changeCardsIsMatched(isMatched: Bool) {
        for index in selectedIndices {
            cards[index].isFaceUp = isMatched
            cards[index].isMatched = isMatched
        }
        selectedIndices.removeAll()
    }
    
    mutating func start() {
        for index in cards.indices {
            cards[index].isFaceUp = true
            cards[index].isMatched = false
        }
        cards.shuffle()
    }
    
    mutating func flipAllCards(_ isFaceUp: Bool) {
        for index in cards.indices {
            cards[index].isFaceUp = isFaceUp
        }
    }
}
