//
//  ViewController.swift
//  Concentration
//
//  Created by Ashish Rawat on 6/4/18.
//  Copyright © 2018 Brown University. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private lazy var game: Concentration = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
    
    var numberOfPairsOfCards : Int {
        get {
            return (cardButtons.count + 1)/2
        }
    }
    
    private(set) var flipCount = 0 {
        didSet {
            updateFlipCountLable()
        }
    }
    private func updateFlipCountLable() {
        //added use of attributed string
        let attributes: [NSAttributedStringKey:Any] = [
            .strokeWidth : 5.0,
            .strokeColor: #colorLiteral(red: 0, green: 0.8326223493, blue: 0.9401578307, alpha: 1)
        ]
        let attributedString = NSAttributedString(string: "Flips: \(flipCount)", attributes:attributes)
        //change flipCountLabel.text to attributedText
        flipCountLabel.attributedText = attributedString
    }
    
    @IBOutlet private weak var flipCountLabel: UILabel! {
        didSet {
            updateFlipCountLable()
        }
    }
    @IBOutlet private var cardButtons: [UIButton]!
    @IBAction private func touchCard(_ sender: UIButton) {
        flipCount += 1
        if let cardNumber = cardButtons.index(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        } else {
            print("Chosen card was not in cardButtons")
        }
    }
    
    private func updateViewFromModel() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: UIControlState.normal)
                button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                
            }else {
                button.setTitle("", for: UIControlState.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0): #colorLiteral(red: 0, green: 0.8326223493, blue: 0.9401578307, alpha: 1)
                
                
            }
        
        }
    }
    
//    private var emojiChoices = ["🥦", "🍉", "🍊", "🍇", "🍒", "🥑", "🍍", "🥝", "🌽"]
    
    private var emojiChoices = "🥦🍉🍊🍇🍒🥑🍍🥝🌽"
    
    private var emoji = [Card:String]()
    
    private func emoji(for card: Card) -> String {
//        if  emoji[card.identifier] != nil {
//            return emoji[card.identifier]!
//        } else {
//            return "?"
//        }
        if emoji[card] == nil, emojiChoices.count > 0 {
            //Changed emojiChoices to string type, cannot use remove(Int), so we make a randomIndex of type String.Index
            
            let randomIndex = emojiChoices.index(emojiChoices.startIndex, offsetBy: emojiChoices.count.arc4random)
            //gives a character, so cast it to String
            emoji[card] = String(emojiChoices.remove(at: randomIndex))
        }
        return emoji[card] ?? "?"
    }
}
extension Int {
    var arc4random: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(abs(self))))
        }
        else if self < 0{
            return -Int(arc4random_uniform(UInt32(abs(self))))
        } else {
            return 0
        }

    }
}

