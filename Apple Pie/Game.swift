//
//  Game.swift
//  Apple Pie
//
//  Created by joshua james on 10/20/19.
//  Copyright © 2019 atoms spawn. All rights reserved.
//

import Foundation
import AVFoundation





struct Game {
    
    
    

    
    var word: String
    var incorrectMovesRemaining: Int
    var guessedLetters: [Character]
    // correct guess affirmation
    //sound file
    
    

    
    //correct guess affermation above
    var formattedWord: String {
        var guessedWord = ""
        for letter in word {
            if guessedLetters.contains(letter) {
                guessedWord += "\(letter)"
                
            } else {
                guessedWord += "_"
            }
        }
        return guessedWord
    }
    mutating func playerGuessed(letter: Character) {
        guessedLetters.append(letter)
        if !word.contains(letter) {
            incorrectMovesRemaining -= 1
        }
        
    }
}
