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
    
    // MARK: IBOutlets
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var cardBackView: UIView!
    
    // MARK: Awake from nib
    override func awakeFromNib() {
        super.awakeFromNib()
        cardBackView.layer.cornerRadius = 10
        cardBackView.clipsToBounds = true
        textLabel.layer.cornerRadius = 10
        textLabel.clipsToBounds = true
        textLabel.layer.borderWidth = 2.5
        textLabel.layer.borderColor = UIColor.orange.cgColor
        textLabel.backgroundColor = .white
    }
    
    // MARK: Methods
    func update(_ card: Card) {
        let fromView = card.isFaceUp ? cardBackView : textLabel
        let toView = !card.isFaceUp ? cardBackView : textLabel
        let duration: TimeInterval = 0.3
        let options: UIView.AnimationOptions = [.transitionFlipFromLeft, .showHideTransitionViews, .curveEaseOut]
        isUserInteractionEnabled = false
        UIView.transition(from: fromView!,
                          to: toView!,
                          duration: duration,
                          options: options) { [weak self](finish) in
                            if finish {
                                self?.isUserInteractionEnabled = true
                                fromView?.isHidden = true
                                toView?.isHidden = false
                            }
        }
        textLabel.text = card.displayEmoji
    }
}
