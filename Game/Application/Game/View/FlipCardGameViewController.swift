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
    private var repeatTiemr: RepeatTimer = RepeatTimer()
    private var flipCardGame = FlipCardGame()

    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupFlipCardGameView()
    }
    
    // MARK: Setting Methods
    private func setupFlipCardGameView() {
        flipCardGameView?.delegate = self
        flipCardGameView?.updateFlipCardGame(flipCardGame)
    }
    
    private func startCountDown() {
        var second = 6
        repeatTiemr.start(timeInterval: 1) { [weak self](timer) in
            second -= 1
            print(second)
            if second == 0 {
                timer.stop()
                self?.flipCardGame.start()
                self?.flipCardGameView?.reloadData()
            }
        }
    }
}

// MARK: - FlipCardGameViewController + FlipCardGameViewDelegate
extension FlipCardGameViewController: FlipCardGameViewDelegate {
        
    func flipCardGameView(_ flipCardGameView: FlipCardGameView, didSelectItemAt index: Int) {
        flipCardGame.flip(at: index)
        flipCardGameView.reloadData()
    }
    
    func flipCardGameViewDidReset(_ flipCardGameView: FlipCardGameView) {
        repeatTiemr.stop()
        flipCardGame.stop()
        flipCardGameView.reloadData()
    }
    
    func flipCardGameViewDidStart(_ flipCardGameView: FlipCardGameView) {
        flipCardGame.showAllCards()
        flipCardGameView.reloadData()
        startCountDown()
    }
}
