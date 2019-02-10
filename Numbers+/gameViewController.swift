//
//  gameViewController.swift
//  Numbers+
//
//  Created by Andrey on 30.01.2019.
//  Copyright © 2019 Andrey. All rights reserved.
//

import UIKit

class gameViewController: UIViewController {
    var minLevel : Int = 0
    var maxLevel : Int = 10
    var points : Int = 1
    var valueGameCount : Int = 0
    var valueTrueAnswerCount : Int = 0
    var valueFalseAnswerCount : Int = 0
    var valueTotalOperation : Int = 0
    static var arrayAnswer : [Int : String] = [:]
    @IBOutlet weak var buttonNext: UIButton!
    @IBOutlet weak var buttonCheck: UIButton!
    @IBOutlet weak var currentLevel: UILabel!
    @IBOutlet weak var answer: UITextField!
    @IBOutlet weak var trueAnswer: UILabel!
    @IBOutlet weak var infoText: UILabel!
    @IBOutlet weak var operation: UILabel!
    @IBOutlet weak var numberTwo: UILabel!
    @IBOutlet weak var numberOne: UILabel!
    @IBOutlet weak var gameCount: UILabel!
    @IBOutlet weak var trueAnswerCount: UILabel!
    @IBOutlet weak var falseAnswerCount: UILabel!
    @IBOutlet weak var totalOperation: UILabel!
    @IBOutlet weak var buttonNewGame: UIButton!
    @IBOutlet weak var buttonLog: UIButton!
    @IBAction func newGame(_ sender: UIButton) {
        gameViewController.arrayAnswer.removeAll()
        buttonNewGame.isHidden = true
        minLevel = 0
        maxLevel = 10
        points = 1
        valueGameCount = 0
        valueTrueAnswerCount = 0
        valueFalseAnswerCount = 0
        valueTotalOperation = 0
        setNumbers()
        gameCount.text = "\(valueGameCount)"
        totalOperation.text = "\(valueTotalOperation)"
        trueAnswerCount.text = "\(valueTrueAnswerCount)"
        falseAnswerCount.text = "\(valueFalseAnswerCount)"
        answer.text = nil
        infoText.textColor = UIColor.black
        infoText.text = "Верный ответ - "
        trueAnswer.text = "????"
        currentLevel.text = "Уровень \(points-1) - числа от \(minLevel) до \(maxLevel) (\(points) балла)"
        hideButton(next: true, check: false, log: true)
    }
    @IBAction func check(_ sender: UIButton) {
        valueTotalOperation += 1
        let sum = (Int(numberOne.text!))! + (Int(numberTwo.text!))!
        if Int(answer.text!) == sum {
            gameViewController.arrayAnswer[valueTotalOperation] = "Правильно \(numberOne.text!) + \(numberTwo.text!) = \(sum)"
            switch points {
                case 1:   valueGameCount += 1
                case 2:   valueGameCount += 2
                case 3:   valueGameCount += 3
                case 4:   valueGameCount += 4
                default:  valueGameCount += 0
            }
            infoText.textColor = UIColor.green
            infoText.text = "Правильно "
            trueAnswer.text = "\(sum)"
            valueTrueAnswerCount += 1
            switch valueTrueAnswerCount {
                case 5: points = 2; minLevel = 11; maxLevel = 20
                case 20: points = 3; minLevel = 21; maxLevel = 50
                case 30: points = 4; minLevel = 51; maxLevel = 100
                default: points += 0
            }
            hideButton(next: false, check: true, log: true)
        } else {
            gameViewController.arrayAnswer[valueTotalOperation] = "ОШИБКА!!! \(numberOne.text!) + \(numberTwo.text!) = \(sum) а не \(answer.text!)"
            valueFalseAnswerCount += 1
            infoText.textColor = UIColor.red
            infoText.text = "Неправильно "
            trueAnswer.text = "\(sum)"
            if valueFalseAnswerCount == 3 {
                let defaults = UserDefaults.standard
                let gameCount = defaults.string(forKey: "Best")
                if Int(gameCount!)! < valueGameCount {
                    defaults.set(valueGameCount, forKey: "Best")
                }
                currentLevel.text = "GAME OVER"
                hideButton(next: true, check: true, log: false)
                buttonNewGame.isHidden = false
            } else {
                hideButton(next: false, check: true, log: true)
            }
        }
        gameCount.text = "\(valueGameCount)"
        totalOperation.text = "\(valueTotalOperation)"
        trueAnswerCount.text = "\(valueTrueAnswerCount)"
        falseAnswerCount.text = "\(valueFalseAnswerCount)"
    }
    @IBAction func nextOperation(_ sender: UIButton) {
        currentLevel.text = "Уровень \(points-1) - числа от \(minLevel) до \(maxLevel) (\(points) балла)"
        answer.text = nil
        infoText.textColor = UIColor.black
        infoText.text = "Верный ответ - "
        trueAnswer.text = "????"
        hideButton(next: true, check: false, log: true)
        setNumbers()
    }
    func setNumbers() {
        numberOne.text = "\(arc4random_uniform(UInt32(maxLevel-minLevel)+1) + UInt32(minLevel))"
        numberTwo.text = "\(arc4random_uniform(UInt32(maxLevel-minLevel)+1) + UInt32(minLevel))"
    }
    func hideButton(next:Bool, check:Bool, log:Bool) {
        buttonCheck.isHidden = check
        buttonNext.isHidden = next
        buttonLog.isHidden = log
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        currentLevel.text = "Уровень \(points-1) - числа от \(minLevel) до \(maxLevel) (\(points) балла)"
        setNumbers()
    }
    
}
