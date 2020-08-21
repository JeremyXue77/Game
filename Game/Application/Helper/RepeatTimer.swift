//
//  RepeatTimer.swift
//  Game
//
//  Created by Jeremy Xue on 2020/8/21.
//  Copyright © 2020 JeremyXue. All rights reserved.
//

import Foundation

class RepeatTimer {
    
    private var timer: Timer? {
        willSet {
            timer?.invalidate()
        }
    }
    
    private(set) var timeInterval: TimeInterval = 1
    private var timerBlock: ((RepeatTimer) -> Void)?
    
    func start(timeInterval: TimeInterval, with action: @escaping ((RepeatTimer) -> Void)) {
        self.timeInterval = timeInterval
        self.timerBlock = action
        fire()
    }
    
    func fire() {
        timer = Timer.scheduledTimer(withTimeInterval: timeInterval,
                                     repeats: true,
                                     block: { [weak self](timer) in
                                        guard let self = self else { return }
                                        self.timerBlock?(self)
        })
        timer?.fire()
    }
    
    func stop() {
        timer?.invalidate()
        timer = nil
    }
}
