//
//  CardCollectionViewCell.swift
//  Game
//
//  Created by Jeremy Xue on 2020/8/20.
//  Copyright © 2020 JeremyXue. All rights reserved.
//

import UIKit
import Reusable

class CardCollectionViewCell: UICollectionViewCell, NibReusable {

    @IBOutlet weak var textLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 10
        self.layer.borderWidth = 2.5
        self.layer.borderColor = UIColor.orange.cgColor
        self.clipsToBounds = true
    }
}
