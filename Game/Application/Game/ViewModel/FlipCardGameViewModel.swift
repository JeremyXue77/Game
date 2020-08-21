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
    
    // MARK: Initializers
    init(game: FlipCardGame) {
        self.game = game
    }
    
    // MARK: Box Properties
    private var cards: Box<[Card]> = .init([])
}
