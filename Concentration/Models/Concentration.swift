//
//  Concentration.swift
//  Concentration
//
//  Created by Karl Merecido on 4/25/18.
//  Copyright © 2018 Karl Merecido. All rights reserved.
//

import Foundation

class Concentration {
    var cards = [Card]()
    var indexOfOneAndOnlyFaceUpCard: Int?
    var isWon = false
    var score = 0
    var atLeastOneMatch = false
    
    func chooseCard(at index: Int) {
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                // check if cards match
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    score += 2
                    atLeastOneMatch = true;
                }
                indexOfOneAndOnlyFaceUpCard = nil
            } else {
                // either no cards or 2 cards are faced up
                var faceUpCards = [Card]()
                for flipDownIndex in cards.indices {
                    if cards[flipDownIndex].isFaceUp {
                        faceUpCards.append(cards[flipDownIndex])
                    }
                    
                    cards[flipDownIndex].isFaceUp = false
                }
                
                if faceUpCards.count == 2, faceUpCards[0].identifier != faceUpCards[1].identifier, atLeastOneMatch {
                    score -= 1
                }
                
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
        
        if indexOfOneAndOnlyFaceUpCard == nil, checkIfGameWon() {
            isWon = true
        }
        cards[index].isFaceUp = !cards[index].isFaceUp;
    }
    
    func checkIfGameWon() -> Bool {
        for index in cards.indices {
            if !cards[index].isMatched {
                return false
            }
        }
        
        return true;
    }
    
    init(numberOfPairsOfCards: Int){
        var unshuffledCards = [Card]()
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            unshuffledCards += [card, card]
        }
        
        var shuffledCards = [Card]()
        
        for _ in unshuffledCards.indices{
            let randomIndex = Int(arc4random_uniform(UInt32(unshuffledCards.count)))
            shuffledCards.append(unshuffledCards.remove(at: randomIndex))
        }
        
        cards = shuffledCards
    }
}
