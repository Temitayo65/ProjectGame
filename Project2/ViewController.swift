//
//  ViewController.swift
//  Project2
//
//  Created by ADMIN on 17/08/2022.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    
    var countries = [String]()
    var score = 0
    var correctAnswer = 0
    var questionsAsked = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        countries += ["estonia","ireland", "italy", "poland","russia","france","germany","monaco","nigeria","spain","uk","us"]
        setUI()
        askQuestion(action: nil)
    }
    
    
    func setUI(){
        button1.layer.borderWidth = 1
        button2.layer.borderWidth = 1
        button3.layer.borderWidth = 1
        button1.layer.borderColor = UIColor.lightGray.cgColor
        button2.layer.borderColor = UIColor.lightGray.cgColor
        button3.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    
    func setButtonUI(){
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
        title = countries[correctAnswer].uppercased() + "            Score: \(score)"
    }
    
    func askQuestion(action: UIAlertAction!){
        countries.shuffle()
        questionsAsked += 1
        correctAnswer = Int.random(in: 0...2)
        setButtonUI()
    }
    
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        var title: String
        if sender.tag == correctAnswer{
            title = "Correct"
            score += 1
        }else{
            title = "Wrong"
            score -= 1
        }
        
        if questionsAsked < 10{
            let message: String
            if title == "Wrong"{
                message = """
                Your score is \(score)
                The correct answer is flag \(correctAnswer + 1 )
                """
            }
            else{
                message = "Your score is \(score)"
            }
            
            let ac = UIAlertController(title: title, message: message , preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Continue", style: .default , handler: askQuestion))
            present(ac, animated: true)
        }
        else{
            let ac = UIAlertController(title: title, message: "Your final score is \(score)/10", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Try again", style: .cancel){_ in
                self.score = 0
                self.correctAnswer = 0
                self.questionsAsked = 0
                self.countries.shuffle()
                self.setButtonUI()
            })
            present(ac, animated: true)
        }
        
        
    }
    

    

}

