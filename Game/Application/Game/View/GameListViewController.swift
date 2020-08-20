//
//  GameListViewController.swift
//  Game
//
//  Created by Jeremy Xue on 2020/8/20.
//  Copyright © 2020 JeremyXue. All rights reserved.
//

import UIKit

class GameListViewController: UIViewController {
    
    // MARK: Properties
    private var gameListView: GameListView? {
        view as? GameListView
    }
    weak var coordinator: GameCoordinaotr?

    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupGameListView()
        setupNavigation()
    }
    
    // MARK: Setting Methods
    private func setupGameListView() {
        gameListView?.delegate = self
    }
    
    private func setupNavigation() {
        navigationItem.title = "🎮 遊戲清單"
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
}

// MARK: - GameListViewController + GameListViewDelegate
extension GameListViewController: GameListViewDelegate {
    
    func gameListView(_ gameListView: GameListView, didSelectItem item: GameListView.GameItem) {
        switch item {
        case .flipCards:       coordinator?.showFlipCardPage()
        case .numberReaction:  coordinator?.showNumberReactionPage()
        case .perfectPath:     coordinator?.showPerfectPathPage()
        }
    }
}
