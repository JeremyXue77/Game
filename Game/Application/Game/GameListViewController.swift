//
//  GameListViewController.swift
//  Game
//
//  Created by Jeremy Xue on 2020/8/20.
//  Copyright © 2020 JeremyXue. All rights reserved.
//

import UIKit

class GameListViewController: UIViewController {

    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
    }
    
    // MARK: Setting Methods
    private func setupNavigation() {
        navigationItem.title = "🎮 Game List"
    }
}
