//
//  EmojiTheme.swift
//  Concentration
//
//  Created by Karl Merecido on 4/26/18.
//  Copyright © 2018 Karl Merecido. All rights reserved.
//

import Foundation

class EmojiThemes {
    static let themes = [["👻", "🙀", "🎃", "👹", "😱", "🕷"],
                  ["🐶", "🐱", "🐭", "🐹", "🐰", "🦊"],
                  ["🐔", "🐧", "🐦", "🐤", "🦆", "🦉"],
                  ["🐙", "🦑", "🦐", "🦀", "🐡", "🐠"],
                  ["🍏", "🍎", "🍐", "🍊", "🍋", "🍌"],
                  ["🥞", "🥓", "🥩", "🍗", "🍖", "🌭"]]
    
    static func getRandomTheme() -> [String] {
        let randomIndex = Int(arc4random_uniform(UInt32(themes.count)))
        return themes[randomIndex]
    }
}
