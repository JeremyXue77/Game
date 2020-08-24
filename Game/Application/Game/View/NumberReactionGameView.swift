//
//  NumberReactionGameView.swift
//  Game
//
//  Created by Jeremy Xue on 2020/8/22.
//  Copyright © 2020 JeremyXue. All rights reserved.
//

import UIKit

protocol NumberReactionGameViewDelegate: AnyObject {
    func numberReactionGameViewDidTapStart(_ view: NumberReactionGameView)
    func numberReactionGameView(_ view: NumberReactionGameView, button: UIButton, didSelectNumber number: Int)
}

class NumberReactionGameView: UIView {
    
    // MARK: Properties
    private var numbers: [Int] = []
    private var numberButtons: [UIButton] = []
    weak var delegate: NumberReactionGameViewDelegate?

    // MARK: IBOutlets
    @IBOutlet weak var numberContentView: UIView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    
    // MARK: IBActions
    @IBAction func touchOnStartButton(_ sender: UIButton) {
        delegate?.numberReactionGameViewDidTapStart(self)
    }
    
    @objc private func touchOnNumberButton(_ sender: UIButton) {
        guard let title = sender.currentTitle,
            let number = Int(title) else {
            return
        }
        delegate?.numberReactionGameView(self, button: sender, didSelectNumber: number)
    }
    
    // MARK: Setting Methods
    func updateNumbers(_ numbers: [Int], isUpdate: Bool) {
        if numbers == self.numbers { return }
        self.numbers = numbers
        if isUpdate {
            removeNotExistButton()
        } else {
            createNumberButtons()
        }
    }
    
    private func removeNotExistButton() {
        let buttonNumbers = numberButtons.map({Int($0.currentTitle ?? "") ?? 0})
        for (index, number) in buttonNumbers.enumerated() {
            if !numbers.contains(number) {
                numberButtons[index].removeFromSuperview()
            }
        }
    }
    
    private func createNumberButtons() {
        numberButtons.forEach({$0.removeFromSuperview()})
        var buttons: [UIButton] = []
        for _ in 0..<numbers.count {
            let button = UIButton()
            button.addTarget(self,
                             action: #selector(touchOnNumberButton(_:)),
                             for: .touchUpInside)
            buttons.append(button)
        }
        numberButtons = buttons
        configuationButtons()
    }
    
    private func configuationButtons() {
        var frameCacheds: [CGRect] = []
        for (index, button) in numberButtons.enumerated() {
            repeat {
                let length = CGFloat.random(in: 50...200)
                let size = CGSize(width: length, height: length)
                let offset = length / 2
                let x = CGFloat.random(in: offset...numberContentView.bounds.width - offset)
                let y = CGFloat.random(in: offset...numberContentView.bounds.height - offset)
                let title = "\(numbers[index])"
                button.backgroundColor = .orange
                button.titleLabel?.font = UIFont.systemFont(ofSize: 30, weight: .bold)
                button.setTitle(title, for: .normal)
                button.frame.size = size
                button.center = CGPoint(x: x, y: y)
                button.layer.cornerRadius = offset
                button.layer.masksToBounds = true
            } while !checkIsValidFrame(frame: button.frame, cacheds: frameCacheds)
            numberContentView.addSubview(button)
            frameCacheds.append(button.frame)
        }
    }
    
    private func checkIsValidFrame(frame: CGRect, cacheds: [CGRect]) -> Bool {
        for cached in cacheds {
            if cached.intersects(frame) {
                return false
            }
        }
        return true
    }
}
