//
//  NumberReactionGameViewController.swift
//  Game
//
//  Created by Jeremy Xue on 2020/8/20.
//  Copyright © 2020 JeremyXue. All rights reserved.
//

import UIKit

class NumberReactionGameViewController: UIViewController {

    // MARK: Propreties
    weak var coordinator: GameCoordinaotr?
    private var viewModel: NumberReactionGameViewModel?
    private var numberReactionGameView: NumberReactionGameView? {
        view as? NumberReactionGameView
    }
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNumberReactionGameView()
        setupViewModel()
    }
    
    // MARK: Setting Methods
    private func setupNumberReactionGameView() {
        numberReactionGameView?.delegate = self
    }
    
    private func setupViewModel() {
        let game = NumberReactionGame(count: 3)
        viewModel = .init(game: game)
        viewModel?.numbers.bind({ [weak self](numbers) in
            let isUpdate = (numbers.count != self?.viewModel?.numbersCount)
            self?.numberReactionGameView?.updateNumbers(numbers, isUpdate: isUpdate)
        })
        viewModel?.score.bind({ [weak self](text) in
            self?.numberReactionGameView?.scoreLabel.text = text
        })
        viewModel?.remainingSeconds.bind({ [weak self](text) in
            self?.numberReactionGameView?.timeLabel.text = text
        })
    }
}

// MARK: - NumberReactionGameViewDelegate
extension NumberReactionGameViewController: NumberReactionGameViewDelegate {
    
    func numberReactionGameViewDidStart(_ view: NumberReactionGameView) {
        viewModel?.startGame()
    }
    
    func numberReactionGameView(_ view: NumberReactionGameView, button: UIButton, didSelectNumber number: Int) {
        viewModel?.select(number: number)
    }
}
