//
//  ViewController.swift
//  Apple Pie
//
//  Created by joshua james on 10/20/19.
//  Copyright © 2019 atoms spawn. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    //play sound
    var audioPlayer = AVAudioPlayer()
    //end play sound
    @IBOutlet weak var treeImageView: UIImageView!
    @IBOutlet weak var correctWordLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet var letterButton: [UIButton]!
    
    
    
    var listOfWords = ["buccaneer", "swift", "glorious", "incandenscent", "bug", "program"]
    let incorrectMovesAllowed = 7
    var totalWins = 0 {
        didSet {
            newRound()
        }
    }
    
    var totalLosses = 0 {
        didSet {
            newRound()
        }
    }
    var currentGame: Game!
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        sender.isEnabled = false
        let letterString = sender.title(for: .normal)!
        let letter = Character(letterString.lowercased())
        currentGame.playerGuessed(letter: letter)
        playSound(file: "correctAnswer", ext: "mp3")
        updateGameState()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //play sound
        
        
        //end play sound
        //sound file
        
        
        newRound()
    }
    
    //play sound
    
    func playSound(file:String, ext:String) -> Void{
    do {
    if let fileURL = Bundle.main.path(forResource: "correctAnswer", ofType: "mp3") {
        audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: fileURL))
        print("continue processing")
        audioPlayer.play()
    } else {
    print("Error No Sound File")
    }
    } catch  {
        print("cant play audio")
    }
    }
    //end play sound
    

    func newRound() {
        if !listOfWords.isEmpty {
            let newWord = listOfWords.removeFirst()
            currentGame = Game(word: newWord, incorrectMovesRemaining: incorrectMovesAllowed, guessedLetters: [])
            enableLetterButtons(true)
            updateUI()
        } else {
            enableLetterButtons(false)
        }
    }
    
    func enableLetterButtons(_ enable: Bool) {
        for button in letterButton {
            button.isEnabled = enable
        }
    }
    
    func updateUI() {
        var letters = [String]()
        for letter in currentGame.formattedWord {
            letters.append(String(letter))
        }
        let wordWithSpacing = letters.joined(separator: " ")
        
        
        correctWordLabel.text = wordWithSpacing
        scoreLabel.text = "Wins: \(totalWins), Losses: \(totalLosses)"
        treeImageView.image = UIImage(named: "Tree \(currentGame.incorrectMovesRemaining)")
        
        
    }
    func updateGameState() {
        if currentGame.incorrectMovesRemaining == 0 {
            totalLosses += 1
        } else if currentGame.word == currentGame.formattedWord {
            totalWins += 1
        } else {
            updateUI()
        }
    }
}

