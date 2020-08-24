//
//  UIColor Extension.swift
//  Game
//
//  Created by Jeremy Xue on 2020/8/24.
//  Copyright © 2020 JeremyXue. All rights reserved.
//

import UIKit

extension UIColor {
    
    static func random() -> UIColor {
        return UIColor(displayP3Red: .random(in: 0...1),
                       green: .random(in: 0...1),
                       blue: .random(in: 0...1),
                       alpha: 1)
    }
}
