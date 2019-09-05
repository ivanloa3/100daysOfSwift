//
//  ViewController.swift
//  Project2
//
//  Created by Ivan Erwin Lopez Ansaldo on 7/1/19.
//  Copyright © 2019 Ivan Erwin Lopez Ansaldo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    
    var scoreLabel = UILabel()

    var countries = [String]()
    var correctAnswer = 1
    var score = 0 {
        didSet {
            scoreLabel.text = "Score: \(score)"
            scoreLabel.sizeToFit()
        }
    }
    var counter = 0 {
        didSet {
            if counter == 10 {
                let restartAction = UIAlertAction(title: "Start again", style: .default, handler: restartGame)
                showAlert("Final score", "Score: \(score)\nQuestions: \(counter)", [restartAction])
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        button1.layer.borderWidth = 1
        button2.layer.borderWidth = 1
        button3.layer.borderWidth = 1
        
        button1.layer.borderColor = UIColor.lightGray.cgColor
        button2.layer.borderColor = UIColor.lightGray.cgColor
        button3.layer.borderColor = UIColor.lightGray.cgColor
        
        scoreLabel.textColor = .darkGray
        
        let rightItem = UIBarButtonItem(customView: scoreLabel)
        navigationItem.rightBarButtonItem = rightItem
        
        score = 0
        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
        
        askQuestion()
    }

    func askQuestion(action: UIAlertAction! = nil) {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        title = countries[correctAnswer].uppercased()
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
    }
    
    func restartGame(action: UIAlertAction! = nil) {
        counter = 0
        score = 0
        askQuestion()
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        
        var title: String
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: askQuestion)
        
        if sender.tag == correctAnswer {
            title = "Correct"
            score += 1
            counter += 1
            showAlert(title, "Your score is \(score)", [okAction])
        } else {
            title = "Wrong"
            counter += 1
            showAlert(title, "That's the flag of \(countries[sender.tag].uppercased())", [okAction])
        }
    }
    
    func showAlert(_ title: String, _ message: String, _ actions: [UIAlertAction] = []) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        _ = actions.map({alert.addAction($0)})
        self.present(alert, animated: true)
    }
}

