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
        var oneThousand = 2
        var fiveHundred = 5
        var oneHundred = 5
    }
    
    @IBOutlet weak var playerBBetMoney: UILabel!
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
    var playerADenomination = Denomination()
    var playerBDenomination = Denomination(player: "B", oneThousand: 2, fiveHundred: 5, oneHundred: 5)
    let diceImageNames = ["one", "two", "three", "four", "five", "six"]
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        playerDenominationArray.append(playerADenomination)
        playerDenominationArray.append(playerBDenomination)
        rotatePlayerBLabel()
        resetGame()
        print(playerADenomination)
    }

    @IBAction func add500(_ sender: UIButton) {
    }
    
    @IBAction func add1000(_ sender: UIButton) {
        var betNumberA = Int(playerABetMoney.text!)!
        if playerADenomination.oneThousand > 0 {
            playerADenomination.oneThousand -= 1
            betNumberA += 1000
            playerABetMoney.text = "\(betNumberA)"
        }
        denominationConnectLabel()
    }
    
    
    @IBAction func rollBtn(_ sender: Any) {
        var diceNumAArray = [Int]()
        var diceNumBArray = [Int]()
        var diceASum = 0
        var diceBSum = 0
        for diceImage in playerADiceImages {
            let randomNum = Int.random(in: 0...5)
            diceImage.image = UIImage(named: diceImageNames[randomNum])
            //為了比較數字有無相等
            diceNumAArray.append(randomNum + 1)
            diceASum += randomNum + 1
        }
        for diceImage in playerBDiceImages {
            let randomNum = Int.random(in: 0...5)
            diceImage.image = UIImage(named: diceImageNames[randomNum])
            //為了比較數字有無相等
            diceNumBArray.append(randomNum + 1)
            diceBSum += randomNum + 1
        }
        let betMoneyA = Int(playerABetMoney.text!)!
        print(betMoneyA)
        let betMoneyB = Int(playerBBetMoney.text!)!
        var remainMoneyA = Int(playerARemainMoney.text!)!
        var remainMoneyB = Int(playerBRemainMoney.text!)!
        if bigOrSmallSegment.selectedSegmentIndex == 0 {
            if diceNumAArray[0] == diceNumAArray[1], diceNumAArray[0] == diceNumAArray[2] {
                //1:10
                remainMoneyA += betMoneyB * 10
                remainMoneyB -= betMoneyB * 10
                if remainMoneyB <= 0 {
                    wordingLabelA.text = "You Win!"
                    wordingLabelB.text = "Over."
                } else {
                    wordingLabelA.text = "You Win!"
                    wordingLabelB.text = "You Lose!"
                }
            } else if diceASum > diceBSum {
                remainMoneyA += betMoneyB
                remainMoneyB -= betMoneyB
                wordingLabelA.text = "You Win!"
                wordingLabelB.text = "You Lose!"
            } else if diceASum < diceBSum {
                remainMoneyA -= betMoneyA
                remainMoneyB += betMoneyA
                wordingLabelA.text = "You Lose!"
                wordingLabelB.text = "You Win!"
            } else if diceASum == diceBSum {
                wordingLabelA.text = "Deuce!"
                wordingLabelB.text = "Deuce!"
            } else if diceNumBArray[0] == diceNumBArray[1], diceNumBArray[0] == diceNumBArray[2]{
                //1:10
                remainMoneyA -= betMoneyA * 10
                remainMoneyB += betMoneyA * 10
                wordingLabelA.text = "You Lose!"
                wordingLabelB.text = "You Win!"
            }
        } else {
            if diceNumAArray[0] == diceNumAArray[1], diceNumAArray[0] == diceNumAArray[2] {
                wordingLabelA.text = "You Win!"
                wordingLabelB.text = "You Lose!"
            } else if diceASum > diceBSum {
                wordingLabelB.text = "You Win!"
                wordingLabelA.text = "You Lose!"
            } else if diceASum < diceBSum {
                wordingLabelB.text = "You Lose!"
                wordingLabelA.text = "You Win!"
            } else if diceASum == diceBSum {
                wordingLabelA.text = "Deuce!"
                wordingLabelB.text = "Deuce!"
            } else if diceNumBArray[0] == diceNumBArray[1], diceNumBArray[0] == diceNumBArray[2]{
                wordingLabelA.text = "You Lose!"
                wordingLabelB.text = "You Win!"
            }
        }
        betMoneyZero()
        playerARemainMoney.text = "\(remainMoneyA)"
        playerBRemainMoney.text = "\(remainMoneyB)"
    }
 
    
    func denominationConnectLabel() {
        //palyerA
        denominationLabels[0].text = String(playerADenomination.oneThousand)
        denominationLabels[1].text = String(playerADenomination.fiveHundred)
        denominationLabels[2].text = String(playerADenomination.oneHundred)
        
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
        playerABetMoney.text = "100"
        playerADenomination = Denomination()
        // playerB
        wordingLabelB.text = "Let’s Roll"
        playerBRemainMoney.text = "5000"
        playerBBetMoney.text = "100"
        playerBDenomination = Denomination()
        denominationConnectLabel()
    }
    func betMoneyZero(){
        playerBBetMoney.text = "0"
        playerABetMoney.text = "0"
    }
}

