//
//  gameViewController.swift
//  Numbers+
//
//  Created by Andrey on 30.01.2019.
//  Copyright © 2019 Andrey. All rights reserved.
//

import UIKit

class gameViewController: UIViewController {
    var nLevel : Int = 0
    var nNumbers : Int = 10
    var nCount : Int = 1
    var level : Int = 10
    var valueGameCount : Int = 0
    var valueTrueAnswerCount : Int = 0
    var valueFalseAnswerCount : Int = 0
    var valueTotalOperation : Int = 0
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
    @IBAction func newGame(_ sender: UIButton) {
        buttonNewGame.isHidden = true
        nLevel = 0
        nNumbers = 10
        nCount = 1
        level = 10
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
        currentLevel.text = "Уровень 0 - числа до 10 (1 балл)"
        hideButton(next: true, check: false)
    }
    @IBAction func check(_ sender: UIButton) {
        valueTotalOperation += 1
        let sum = (Int(numberOne.text!))! + (Int(numberTwo.text!))!
        if Int(answer.text!) == sum {
            switch level {
                case 10:    valueGameCount += 1
                case 20:    valueGameCount += 2
                case 50:    valueGameCount += 3
                case 100:   valueGameCount += 4
                default:    valueGameCount += 0
            }
            infoText.textColor = UIColor.green
            infoText.text = "Правильно "
            trueAnswer.text = "\(sum)"
            valueTrueAnswerCount += 1
            switch valueTrueAnswerCount {
                case 10: level = 20; nLevel = 1; nNumbers = 20; nCount = 2
                case 20: level = 50; nLevel = 2; nNumbers = 50; nCount = 3
                case 30: level = 100; nLevel = 3; nNumbers = 100; nCount = 4
                default: level += 0
            }
            hideButton(next: false, check: true)
        } else {
            valueFalseAnswerCount += 1
            infoText.textColor = UIColor.red
            infoText.text = "Неправильно "
            trueAnswer.text = "\(sum)"
            if valueFalseAnswerCount == 3 {
                currentLevel.text = "GAME OVER"
                hideButton(next: true, check: true)
                buttonNewGame.isHidden = false
            } else {
                hideButton(next: false, check: true)
            }
        }
        gameCount.text = "\(valueGameCount)"
        totalOperation.text = "\(valueTotalOperation)"
        trueAnswerCount.text = "\(valueTrueAnswerCount)"
        falseAnswerCount.text = "\(valueFalseAnswerCount)"
    }
    @IBAction func nextOperation(_ sender: UIButton) {
        currentLevel.text = "Уровень \(nLevel) - числа до \(nNumbers) (\(nCount) балл)"
        answer.text = nil
        infoText.textColor = UIColor.black
        infoText.text = "Верный ответ - "
        trueAnswer.text = "????"
        hideButton(next: true, check: false)
        setNumbers()
    }
    func setNumbers() {
        numberOne.text = "\(arc4random_uniform(UInt32(level)))"
        numberTwo.text = "\(arc4random_uniform(UInt32(level)))"
    }
    func hideButton(next:Bool, check:Bool) {
        buttonCheck.isHidden = check
        buttonNext.isHidden = next
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        currentLevel.text = "Уровень 0 - числа до 10 (1 балл)"
        setNumbers()
    }
    
}
