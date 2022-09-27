//
//  ViewController.swift
//  DiceBigOrSmall
//
//  Created by JubeHuang黃冬伊 on 2022/9/26.
//

import UIKit

class ViewController: UIViewController {
    struct Denomination {
        var player = "A"
//        var oneThousand = 2
//        var fiveHundred = 5
//        var oneHundred = 5
        var money:[Int]
    }
    
    @IBOutlet weak var bLabel: UILabel!
    @IBOutlet weak var playerLabel: UILabel!
    @IBOutlet weak var playerBRemainLabel: UILabel!
    @IBOutlet weak var playerBRemainMoney: UILabel!
    @IBOutlet var denominationLabels: [UILabel]!
    @IBOutlet weak var playerABetMoney: UILabel!
    @IBOutlet weak var playerARemainMoney: UILabel!
    @IBOutlet var playerBDiceImages: [UIImageView]!
    @IBOutlet weak var wordingLabelB: UILabel!
    @IBOutlet weak var wordingLabelA: UILabel!
    @IBOutlet weak var bigOrSmallSegment: UISegmentedControl!
    @IBOutlet var playerADiceImages: [UIImageView]!
    var playerDenominationArray = [Denomination]()
    var playerADenomination = Denomination(player: "A", money: [2, 5, 5])
    var playerBDenomination = Denomination(player: "B", money: [2, 5, 5])
    let diceImageNames = ["one", "two", "three", "four", "five", "six"]
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        playerDenominationArray.append(playerADenomination)
        playerDenominationArray.append(playerBDenomination)
        rotatePlayerBLabel()
        resetGame()
    }


    @IBAction func clearABtn(_ sender: Any) {
        playerABetMoney.text = "0"
    }
    @IBAction func rollBtn(_ sender: Any) {
        for diceImage in playerADiceImages {
            diceImage.image = UIImage(named: diceImageNames.randomElement()!)
        }
        for diceImage in playerBDiceImages {
            diceImage.image = UIImage(named: diceImageNames.randomElement()!)
        }
    }
 
    
    func denominationConnectLabel() {
        //palyerA
        for i in 0...2 {
            denominationLabels[i].text = String(playerDenominationArray[0].money[i])
        }
        
    }
    func rotatePlayerBLabel(){
        wordingLabelB.transform = CGAffineTransform(rotationAngle: .pi)
        playerBRemainLabel.transform = CGAffineTransform(rotationAngle: .pi)
        playerBRemainMoney.transform = CGAffineTransform(rotationAngle: .pi)
        bLabel.transform = CGAffineTransform(rotationAngle: .pi)
        playerLabel.transform = CGAffineTransform(rotationAngle: .pi)
    }
    func resetGame(){
        // playerA
        wordingLabelA.text = "Let’s Roll"
        playerARemainMoney.text = "5000"
        playerABetMoney.text = "+100"
        playerADenomination = Denomination(player: "A", money: [2, 5, 5])
        // playerB
        wordingLabelB.text = "Let’s Roll"
        playerBRemainMoney.text = "5000"
        //playerBBetMoney.text = "+100"
        playerBDenomination = Denomination(player: "B", money: [2, 5, 5])
        denominationConnectLabel()
    }
}

