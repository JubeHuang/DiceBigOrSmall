//
//  ViewController.swift
//  DiceBigOrSmall
//
//  Created by JubeHuang黃冬伊 on 2022/9/26.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    struct Denomination {
        var player = "A"
        var oneThousand = 2
        var fiveHundred = 5
        var oneHundred = 4
    }
    @IBOutlet weak var playerBBetMoney: UILabel!
    @IBOutlet weak var reStartABtn: UIButton!
    @IBOutlet var denominationBLabels: [UILabel]!
    @IBOutlet weak var reStartBbtn: UIButton!
    @IBOutlet weak var betBImage: UIImageView!
    @IBOutlet weak var rollBtnB: UIButton!
    @IBOutlet weak var oneThousandBLabel: UILabel!
    @IBOutlet weak var fiveHundredLabel: UILabel!
    @IBOutlet weak var oneHundredLabel: UILabel!
    @IBOutlet weak var rollBtnA: UIButton!
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
    var playerADenomination = Denomination()
    var playerBDenomination = Denomination(player: "B", oneThousand: 2, fiveHundred: 5, oneHundred: 4)
    let diceImageNames = ["one", "two", "three", "four", "five", "six"]
    let player = AVPlayer()
    override func viewDidLoad() {
        super.viewDidLoad()
        rotatePlayerBLabel()
        resetGame()
        hideRestartBtn(bool: true)
        //亂數放圖片
        for diceImage in playerADiceImages {
            let randomNum = Int.random(in: 0...5)
            diceImage.image = UIImage(named: diceImageNames[randomNum])
        }
        for diceImage in playerBDiceImages {
            let randomNum = Int.random(in: 0...5)
            diceImage.image = UIImage(named: diceImageNames[randomNum])
        }
    }
//playerA
    @IBAction func add500(_ sender: UIButton) {
        var betNumberA = Int(playerABetMoney.text!)!
        if playerADenomination.fiveHundred > 0 {
            playerADenomination.fiveHundred -= 1
            betNumberA += 500
            playerABetMoney.text = "\(betNumberA)"
            if playerBBetMoney.text != "0" {
                enableRollBtn(bool: true, opacity: 1)
            }
        }
        denominationConnectLabel()
    }
    @IBAction func add100(_ sender: Any) {
        var betNumberA = Int(playerABetMoney.text!)!
        if playerADenomination.oneHundred > 0 {
            playerADenomination.oneHundred -= 1
            betNumberA += 100
            playerABetMoney.text = "\(betNumberA)"
            if playerBBetMoney.text != "0" {
                enableRollBtn(bool: true, opacity: 1)
            }
        }
        denominationConnectLabel()
    }
    @IBAction func add1000(_ sender: UIButton) {
        var betNumberA = Int(playerABetMoney.text!)!
        if playerADenomination.oneThousand > 0 {
            playerADenomination.oneThousand -= 1
            betNumberA += 1000
            playerABetMoney.text = "\(betNumberA)"
            if playerBBetMoney.text != "0" {
                enableRollBtn(bool: true, opacity: 1)
            }
        }
        denominationConnectLabel()
    }
    
    //playberB
    @IBAction func add100B(_ sender: Any) {
        var betNumberB = Int(playerBBetMoney.text!)!
        if playerBDenomination.oneHundred > 0 {
            playerBDenomination.oneHundred -= 1
            betNumberB += 100
            playerBBetMoney.text = "\(betNumberB)"
            if playerABetMoney.text != "0" {
                enableRollBtn(bool: true, opacity: 1)
            }
        }
        denominationConnectLabel()
    }
    @IBAction func add500B(_ sender: Any) {
        var betNumberB = Int(playerBBetMoney.text!)!
        if playerBDenomination.fiveHundred > 0 {
            playerBDenomination.fiveHundred -= 1
            betNumberB += 500
            playerBBetMoney.text = "\(betNumberB)"
            if playerABetMoney.text != "0" {
                enableRollBtn(bool: true, opacity: 1)
            }
        }
        denominationConnectLabel()
    }
    @IBAction func add1000B(_ sender: Any) {
        var betNumberB = Int(playerBBetMoney.text!)!
        if playerBDenomination.oneThousand > 0 {
            playerBDenomination.oneThousand -= 1
            betNumberB += 1000
            playerBBetMoney.text = "\(betNumberB)"
            if playerABetMoney.text != "0" {
                enableRollBtn(bool: true, opacity: 1)
            }
        }
        denominationConnectLabel()
    }
    var diceASum = 0
    var diceBSum = 0
    var diceNumAArray = [Int]()
    var diceNumBArray = [Int]()
    @IBAction func rollBtn(_ sender: UIButton) {
        //音效
        let fileUrl = Bundle.main.url(forResource: "diceRollSoundEffect", withExtension: "mp3")!
        let playerItem = AVPlayerItem(url: fileUrl)
        player.replaceCurrentItem(with: playerItem)
        player.play()
        let betMoneyA = Int(playerABetMoney.text!)!
        let betMoneyB = Int(playerBBetMoney.text!)!
        var remainMoneyA = Int(playerARemainMoney.text!)!
        var remainMoneyB = Int(playerBRemainMoney.text!)!
        //tag
        switch sender.tag {
        case 1:
            //換骰子照片
            for diceImage in playerADiceImages {
                let randomNum = Int.random(in: 0...5)
                diceImage.image = UIImage(named: diceImageNames[randomNum])
                //為了比較數字有無相等
                diceNumAArray.append(randomNum + 1)
                diceASum += randomNum + 1
            }
            //animation
            UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.3, delay: 0, options: .curveEaseIn) {
                for i in 0...2 {
                    let number = Float.random(in: 360...720)
                    self.playerADiceImages[i].transform = CGAffineTransform(rotationAngle: .pi * CGFloat(number))
                }
            }
            wordingLabelA.text="waiting"
            rollBtnA.layer.opacity = 0.3
            rollBtnA.isEnabled = false
        case 2:
            for diceImage in playerBDiceImages {
                let randomNum = Int.random(in: 0...5)
                diceImage.image = UIImage(named: diceImageNames[randomNum])
                diceNumBArray.append(randomNum + 1)
                diceBSum += randomNum + 1
            }
            UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.3, delay: 0, options: .curveEaseIn) {
                for i in 0...2 {
                    let number = Float.random(in: 360...720)
                    self.playerBDiceImages[i].transform = CGAffineTransform(rotationAngle: .pi * CGFloat(number))
                }
            }
            wordingLabelB.text="waiting"
            rollBtnB.layer.opacity = 0.3
            rollBtnB.isEnabled = false
        default:
            break
        }
        // A & B 都骰了骰子
        if diceASum > 0 && diceBSum > 0 {
            betMoneyZero()
            //比大
            if bigOrSmallSegment.selectedSegmentIndex == 0 {
                if diceASum > diceBSum || (diceNumAArray[0] == diceNumAArray[1] && diceNumAArray[0] == diceNumAArray[2]) {
                    remainMoneyA += betMoneyB
                    remainMoneyB -= betMoneyB
                    wordingLabelA.text = "You Win!"
                    wordingLabelB.text = "You Lose!"
                } else if diceASum < diceBSum || (diceNumBArray[0] == diceNumBArray[1] && diceNumBArray[0] == diceNumBArray[2]) {
                    remainMoneyA -= betMoneyA
                    remainMoneyB += betMoneyA
                    wordingLabelA.text = "You Lose!"
                    wordingLabelB.text = "You Win!"
                } else if diceASum == diceBSum {
                    remainMoneyA += betMoneyA
                    remainMoneyB += betMoneyB
                    wordingLabelA.text = "Deuce!"
                    wordingLabelB.text = "Deuce!"
                }
                //用完錢幣數量 結束
                if ((playerADenomination.oneThousand == 0 && playerADenomination.fiveHundred == 0) && playerADenomination.oneHundred == 0) || ((playerBDenomination.oneThousand == 0 && playerBDenomination.fiveHundred == 0) && playerBDenomination.oneHundred == 0) {
                    if remainMoneyA > remainMoneyB {
                        wordingLabelB.text = "Over."
                        wordingLabelA.text = "Winner!"
                    } else if remainMoneyA < remainMoneyB {
                        wordingLabelA.text = "Over."
                        wordingLabelB.text = "Winner!"
                    } else {
                        wordingLabelA.text = "Win Win"
                        wordingLabelB.text = "Win Win"
                    }
                    hideRestartBtn(bool: false)
                }
            //比小
            } else if bigOrSmallSegment.selectedSegmentIndex == 1{
                if diceASum > diceBSum || (diceNumBArray[0] == diceNumBArray[1] && diceNumBArray[0] == diceNumBArray[2]){
                    remainMoneyA -= betMoneyA
                    remainMoneyB += betMoneyA
                    wordingLabelB.text = "You Win!"
                    wordingLabelA.text = "You Lose!"
                } else if diceASum < diceBSum || (diceNumAArray[0] == diceNumAArray[1] && diceNumAArray[0] == diceNumAArray[2]) {
                    remainMoneyA += betMoneyB
                    remainMoneyB -= betMoneyB
                    wordingLabelB.text = "You Lose!"
                    wordingLabelA.text = "You Win!"
                } else if diceASum == diceBSum {
                    remainMoneyA += betMoneyA
                    remainMoneyB += betMoneyB
                    wordingLabelA.text = "Deuce!"
                    wordingLabelB.text = "Deuce!"
                }
                if ((playerADenomination.oneThousand == 0 && playerADenomination.fiveHundred == 0) && playerADenomination.oneHundred == 0) || ((playerBDenomination.oneThousand == 0 && playerBDenomination.fiveHundred == 0) && playerBDenomination.oneHundred == 0) {
                    if remainMoneyA > remainMoneyB {
                        wordingLabelB.text = "Over."
                        wordingLabelA.text = "Winner!"
                    } else if remainMoneyA < remainMoneyB {
                        wordingLabelA.text = "Over."
                        wordingLabelB.text = "Winner!"
                    } else {
                        wordingLabelA.text = "Win Win"
                        wordingLabelB.text = "Win Win"
                    }
                    hideRestartBtn(bool: false)
                }
            }
            diceASum = 0
            diceBSum = 0
        }
        playerARemainMoney.text = "\(remainMoneyA)"
        playerBRemainMoney.text = "\(remainMoneyB)"
    }
    
    @IBAction func reStartBtn(_ sender: UIButton) {
        resetGame()
        hideRestartBtn(bool: true)
        UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.3, delay: 0, options: .curveEaseIn) {
            for i in 0...2 {
                self.playerADiceImages[i].transform = CGAffineTransform(rotationAngle: 0)
                self.playerBDiceImages[i].transform = CGAffineTransform(rotationAngle: 0)
            }
        }
    }
    
    // function
    func denominationConnectLabel() {
        //palyerA
        denominationLabels[0].text = String(playerADenomination.oneThousand)
        denominationLabels[1].text = String(playerADenomination.fiveHundred)
        denominationLabels[2].text = String(playerADenomination.oneHundred)
        //playerB
        denominationBLabels[0].text = String(playerBDenomination.oneThousand)
        denominationBLabels[1].text = String(playerBDenomination.fiveHundred)
        denominationBLabels[2].text = String(playerBDenomination.oneHundred)
    }
    func rotatePlayerBLabel(){
        wordingLabelB.transform = CGAffineTransform(rotationAngle: .pi)
        playerBRemainLabel.transform = CGAffineTransform(rotationAngle: .pi)
        playerBRemainMoney.transform = CGAffineTransform(rotationAngle: .pi)
        bLabel.transform = CGAffineTransform(rotationAngle: .pi)
        playerLabel.transform = CGAffineTransform(rotationAngle: .pi)
        betBImage.transform = CGAffineTransform(rotationAngle: .pi)
        rollBtnB.transform = CGAffineTransform(rotationAngle: .pi)
        playerBBetMoney.transform = CGAffineTransform(rotationAngle: .pi)
        oneThousandBLabel.transform = CGAffineTransform(rotationAngle: .pi)
        oneHundredLabel.transform = CGAffineTransform(rotationAngle: .pi)
        fiveHundredLabel.transform = CGAffineTransform(rotationAngle: .pi)
        for i in 0...2 {
            denominationBLabels[i].transform = CGAffineTransform(rotationAngle: .pi)
        }
        reStartBbtn.transform = CGAffineTransform(rotationAngle: .pi)
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
        enableRollBtn(bool:true, opacity: 1)
    }
    func betMoneyZero(){
        playerBBetMoney.text = "0"
        playerABetMoney.text = "0"
    }
    func enableRollBtn(bool:Bool, opacity: Float) {
        rollBtnA.layer.opacity = opacity
        rollBtnA.isEnabled = bool
        rollBtnB.layer.opacity = opacity
        rollBtnB.isEnabled = bool
    }
    func hideRestartBtn(bool: Bool) {
        reStartBbtn.isHidden = bool
        reStartABtn.isHidden = bool
    }
}
