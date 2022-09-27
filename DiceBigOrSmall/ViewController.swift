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
    @IBOutlet var denominationLabels: [UILabel]!
    @IBOutlet weak var playerABetMoney: UILabel!
    @IBOutlet weak var playerARemainMoney: UILabel!
    @IBOutlet var playerBDiceImages: [UIImageView]!
    @IBOutlet weak var wordingLabel: UILabel!
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
    }


    @IBAction func rollBtn(_ sender: Any) {
        for diceImage in playerADiceImages {
            diceImage.image = UIImage(named: diceImageNames.randomElement()!)
        }
    }
    @IBAction func playerAbetStepper(_ sender: Any) {
    }
    func denominationConnectLabel() {
        //palyerA
        for i in 0...2 {
            denominationLabels[i].text = String(playerDenominationArray[0].money[i])
        }
        
    }
}

