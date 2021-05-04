//
//  ViewController.swift
//  CatchTheRabbit
//
//  Created by Tolga on 4.05.2021.
//

import UIKit

class ViewController: UIViewController {

    //Views
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var highscoreLabel: UILabel!
    @IBOutlet weak var rabbit1: UIImageView!
    @IBOutlet weak var rabbit2: UIImageView!
    @IBOutlet weak var rabbit3: UIImageView!
    @IBOutlet weak var rabbit4: UIImageView!
    @IBOutlet weak var rabbit5: UIImageView!
    @IBOutlet weak var rabbit6: UIImageView!
    @IBOutlet weak var rabbit7: UIImageView!
    @IBOutlet weak var rabbit8: UIImageView!
    @IBOutlet weak var rabbit9: UIImageView!
    
    //Variables
    var score = 0
    var timer = Timer()
    var counter = 0
    var rabbitArray = [UIImageView]()
    var hideTimer = Timer()
    var highScore = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //Highscore Check
        let storedHighScore = UserDefaults.standard.object(forKey: "highscore")
        if(storedHighScore == nil){
            highScore = 0
            highscoreLabel.text = "Highscore: \(highScore)"
        }
        
        if let newScore = storedHighScore as? Int {
            highScore = newScore
            highscoreLabel.text = "Highscore: \(highScore)"
        }
        //Score
        scoreLabel.text = "Score : \(score)"
        
        //Time
        counter = 20
        timer = Timer.scheduledTimer(timeInterval: 0.8, target: self, selector: #selector(decreaseTime) , userInfo: nil, repeats: true)
        hideTimer = Timer.scheduledTimer(timeInterval: 0.7, target: self, selector: #selector(showRabbit), userInfo: nil, repeats: true)
        
        //Rabbit Images
        let gestireRecognizer1 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let gestireRecognizer2 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let gestireRecognizer3 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let gestireRecognizer4 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let gestireRecognizer5 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let gestireRecognizer6 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let gestireRecognizer7 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let gestireRecognizer8 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let gestireRecognizer9 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        
        rabbit1.isUserInteractionEnabled = true
        rabbit2.isUserInteractionEnabled = true
        rabbit3.isUserInteractionEnabled = true
        rabbit4.isUserInteractionEnabled = true
        rabbit5.isUserInteractionEnabled = true
        rabbit6.isUserInteractionEnabled = true
        rabbit7.isUserInteractionEnabled = true
        rabbit8.isUserInteractionEnabled = true
        rabbit9.isUserInteractionEnabled = true
        
        rabbit1.addGestureRecognizer(gestireRecognizer1)
        rabbit2.addGestureRecognizer(gestireRecognizer2)
        rabbit3.addGestureRecognizer(gestireRecognizer3)
        rabbit4.addGestureRecognizer(gestireRecognizer4)
        rabbit5.addGestureRecognizer(gestireRecognizer5)
        rabbit6.addGestureRecognizer(gestireRecognizer6)
        rabbit7.addGestureRecognizer(gestireRecognizer7)
        rabbit8.addGestureRecognizer(gestireRecognizer8)
        rabbit9.addGestureRecognizer(gestireRecognizer9)
        
        rabbitArray = [rabbit1, rabbit2, rabbit3, rabbit4, rabbit5, rabbit6, rabbit7, rabbit8,rabbit9]
        
        hideRabbit()
        showRabbit()
    }
    
    @objc func increaseScore(){
        score += 1
        scoreLabel.text = "Score : \(score)"
    }
    
    @objc func decreaseTime(){
        counter -= 1
        timeLabel.text = "Time: \(counter)"
        
        
        if(counter <= 0){
            timer.invalidate()
            hideTimer.invalidate()
            
            hideRabbit()
            
            //Highscore
            if (self.score > self.highScore){
                self.highScore = self.score
                highscoreLabel.text = "Highscore: \(self.highScore)"
                UserDefaults.standard.set(self.highScore, forKey: "highscore")
            }
            
            
            let alert = UIAlertController(title: "Time's Up", message: "Do you want to play again?", preferredStyle: UIAlertController.Style.alert)
            let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil)
            let replayButton = UIAlertAction(title: "Replay", style: UIAlertAction.Style.default){
                (UIAlertAction) in
                //Replay Function
                self.score = 0
                self.scoreLabel.text = "Score: \(self.score)"
                self.counter = 20
                self.timeLabel.text = "Time: \(self.counter)"
                
                self.timer = Timer.scheduledTimer(timeInterval: 0.8, target: self, selector: #selector(self.decreaseTime) , userInfo: nil, repeats: true)
                self.hideTimer = Timer.scheduledTimer(timeInterval: 0.7, target: self, selector: #selector(self.showRabbit), userInfo: nil, repeats: true)
            }
            alert.addAction(okButton)
            alert.addAction(replayButton)
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    
    func hideRabbit(){
        for rabbit in rabbitArray{
            rabbit.isHidden = true
        }
    }
    
    @objc func showRabbit(){
        hideRabbit()
        let random = Int(arc4random_uniform(UInt32(rabbitArray.count - 1)))
        rabbitArray[random].isHidden = false
    }
    
    

}

