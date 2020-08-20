//
//  GameCoordinator.swift
//  Game
//
//  Created by Jeremy Xue on 2020/8/20.
//  Copyright © 2020 JeremyXue. All rights reserved.
//

import UIKit

class GameCoordinaotr: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    init(nav: UINavigationController) {
        navigationController = nav
    }
    
    func start() {
        let vc = GameListViewController()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: false)
    }
    
    func showFlipCardPage() {
        let vc = FlipCardGameViewController()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
    
    func showNumberReactionPage() {
        let vc = NumberReactionGameViewController()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
    
    func showPerfectPathPage() {
        let vc = PerfectPathGameViewController()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
}
