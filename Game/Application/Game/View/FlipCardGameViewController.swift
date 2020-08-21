//
//  FlipCardGameViewController.swift
//  Game
//
//  Created by Jeremy Xue on 2020/8/20.
//  Copyright © 2020 JeremyXue. All rights reserved.
//

import UIKit

class FlipCardGameViewController: UIViewController {
    
    // MARK: Properties
    private var flipCardGameView: FlipCardGameView? {
        view as? FlipCardGameView
    }
    weak var coordinator: GameCoordinaotr?
    private var viewModel: FlipCardGameViewModel?
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupFlipCardGameView()
        setupViewModel()
    }
    
    // MARK: Setting Methods
    private func setupFlipCardGameView() {
        flipCardGameView?.delegate = self
    }
    
    private func setupViewModel() {
        let game = FlipCardGame()
        viewModel = FlipCardGameViewModel(game: game)
        viewModel?.cards.bind({ [weak flipCardGameView](cards) in
            flipCardGameView?.reloadCardCollectionView(with: cards)
        })
        viewModel?.remainingSeconds.bind({ [weak flipCardGameView](text) in
            flipCardGameView?.countDownLabel.text = text
        })
    }
}

// MARK: - FlipCardGameViewController + FlipCardGameViewDelegate
extension FlipCardGameViewController: FlipCardGameViewDelegate {
    
    func flipCardGameView(_ flipCardGameView: FlipCardGameView, didSelectItemAt index: Int) {
        viewModel?.flipCard(at: index)
    }
    
    func flipCardGameViewDidReset(_ flipCardGameView: FlipCardGameView) {
        viewModel?.stopGame()
    }
    
    func flipCardGameViewDidStart(_ flipCardGameView: FlipCardGameView) {
        viewModel?.startGame()
    }
}
