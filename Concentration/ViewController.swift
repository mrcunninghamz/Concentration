//
//  ViewController.swift
//  Concentration
//
//  Created by Karl Merecido on 4/25/18.
//  Copyright © 2018 Karl Merecido. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var flipCountLabel: UILabel!
    
    @IBOutlet var cardButtons: [UIButton]!
    
    @IBAction func touchCard(_ sender: UIButton) {
        if let cardNumber = cardButtons.index(of: sender){
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        } else {
            print("chosen card was not in cardButtons")
        }
    }
    
    @IBAction func startNewGame(_ sender: Any) {
        startNewGame()
    }
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
        game = initiateConcentration()
    }
    
    var game: Concentration!
    var gameEmojis: [String]!
    var cardEmojis = [Int:String]()
    
    func updateViewFromModel(){
        flipCountLabel.text = "Score: \(game.score)"
        
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: UIControlState.normal)
                button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            } else {
                button.setTitle("", for: UIControlState.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0) : #colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1)
            }
        }
        
        if (game.isWon){
            let alertController = UIAlertController(title: "Concentration", message:
                "You Won with a score of \(game.score)!", preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "New Game", style: UIAlertActionStyle.default, handler: {(alert: UIAlertAction!) in
                self.startNewGame()
            }))
            
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    func emoji(for card: Card) -> String {
        if cardEmojis[card.identifier] == nil, gameEmojis.count > 0 {
                let randomIndex = Int(arc4random_uniform(UInt32(gameEmojis.count)))
                cardEmojis[card.identifier] = gameEmojis.remove(at: randomIndex)
        }
        return cardEmojis[card.identifier] ?? "?"
    }
    
    private func startNewGame(){
        game = initiateConcentration()
        updateViewFromModel()
    }
    
    private func initiateConcentration() -> Concentration {
        print("number of cardbuttons: \(cardButtons.count)")
        gameEmojis = EmojiThemes.getRandomTheme()
        return Concentration(numberOfPairsOfCards: (cardButtons.count) / 2)
    }
}

