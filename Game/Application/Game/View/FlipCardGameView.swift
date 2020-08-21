//
//  FlipCardGameView.swift
//  Game
//
//  Created by Jeremy Xue on 2020/8/20.
//  Copyright © 2020 JeremyXue. All rights reserved.
//

import UIKit
import Reusable

protocol FlipCardGameViewDelegate: AnyObject {
    func flipCardGameView(_ flipCardGameView: FlipCardGameView, didSelectItemAt index: Int)
    func flipCardGameViewDidStart(_ flipCardGameView: FlipCardGameView)
    func flipCardGameViewDidReset(_ flipCardGameView: FlipCardGameView)
}

class FlipCardGameView: UIView {
    
    // MARK: Properties
    private var flipCardsGame: FlipCardGame? {
        didSet {
            cardCollectionView.reloadData()
        }
    }
    private var cards: [Card] {
        flipCardsGame?.cards ?? []
    }
    weak var delegate: FlipCardGameViewDelegate?
    private let columns: Int = 4
    private let rows: Int = 3
    private let spacing: CGFloat = 8
    private var isStarting = false
    
    // MARK: IBOutlets
    @IBOutlet weak var cardCollectionView: UICollectionView!
    
    // MARK: IBActions
    @IBAction func touchOnResetButton(_ sender: UIButton) {
        if isStarting {
            sender.setTitle("START", for: .normal)
            delegate?.flipCardGameViewDidReset(self)
        } else {
            sender.setTitle("STOP", for: .normal)
            delegate?.flipCardGameViewDidStart(self)
        }
        isStarting.toggle()
    }
    
    // MARK: Lifecylce
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCardCollectionView()
    }
    
    // MARK: Setting Methods
    private func setupCardCollectionView() {
        cardCollectionView.dataSource = self
        cardCollectionView.delegate = self
        cardCollectionView.register(cellType: CardCollectionViewCell.self)
    }
}

// MARK: - Methods
extension FlipCardGameView {
    
    func updateFlipCardGame(_ game: FlipCardGame) {
        flipCardsGame = game
    }
    
    func reloadData() {
        cardCollectionView.reloadData()
    }
}

// MARK: - FlipCardGameView + UICollectionViewDataSource
extension FlipCardGameView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        cards.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: CardCollectionViewCell.self)
        let card = cards[indexPath.row]
        if card.isFaceUp {
            cell.textLabel.text = card.displayEmoji
            cell.textLabel.backgroundColor = .white
        } else {
            cell.textLabel.text = nil
            cell.textLabel.backgroundColor = .orange
        }
        return cell
    }
}

// MARK: - FlipCardGameView + UICollectionViewDelegateFlowLayout
extension FlipCardGameView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let columns: CGFloat = CGFloat(self.columns)
        let rows: CGFloat = CGFloat(self.rows)
        let width = (cardCollectionView.bounds.width - (spacing * (columns - 1))) / columns
        let height = (cardCollectionView.bounds.height - (spacing * (rows - 1))) / (rows)
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        spacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        spacing
    }
}

// MARK: - FlipCardGameView + UICollectionViewDelegate
extension FlipCardGameView: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.flipCardGameView(self, didSelectItemAt: indexPath.row)
    }
}


