//
//  ViewController.swift
//  Numbers+
//
//  Created by Andrey on 27.01.2019.
//  Copyright © 2019 Andrey. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var minLevel : Int = 0
    var maxLevel : Int = 10
    var points : Int = 1
    var valueGameCount : Int = 0
    var valueTrueAnswerCount : Int = 0
    var valueFalseAnswerCount : Int = 0
    var valueTotalOperation : Int = 0
    @IBOutlet weak var buttonNext: UIButton!
    @IBOutlet weak var buttonCheck: UIButton!
    @IBOutlet weak var currentLevel: UILabel!
    @IBOutlet weak var levelZero: UIButton!
    @IBOutlet weak var levelOne: UIButton!
    @IBOutlet weak var levelTwo: UIButton!
    @IBOutlet weak var levelThree: UIButton!
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
    @IBAction func levelChoose (_ sender: UIButton) {
        switch sender.restorationIdentifier {
        case "zero":
            setLevel(minLevel: 0, maxLevel: 10, points: 1)
        case "one":
            setLevel(minLevel: 11, maxLevel: 20, points: 2)
        case "two":
            setLevel(minLevel: 21, maxLevel: 50, points: 3)
        case "three":
            setLevel(minLevel: 51, maxLevel: 100, points: 4)
        default:
            return
        }
    }
    @IBAction func check(_ sender: UIButton) {
        valueTotalOperation += 1
        let sum = (Int(numberOne.text!))! + (Int(numberTwo.text!))!
        if Int(answer.text!) == sum {
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
        } else {
            infoText.textColor = UIColor.red
            infoText.text = "Неправильно "
            trueAnswer.text = "\(sum)"
            valueFalseAnswerCount += 1
        }
        showLevel(value : "true")
        gameCount.text = "\(valueGameCount)"
        totalOperation.text = "\(valueTotalOperation)"
        trueAnswerCount.text = "\(valueTrueAnswerCount)"
        falseAnswerCount.text = "\(valueFalseAnswerCount)"
        hideButton(next: false, check: true)
    }
    @IBAction func nextOperation(_ sender: UIButton) {
        answer.text = nil
        setNumbers()
        infoText.textColor = UIColor.black
        infoText.text = "Верный ответ - "
        trueAnswer.text = "????"
        showLevel(value: "false")
        hideButton(next: true, check: false)
    }
    func showLevel(value : String) {
        if value == "true" {
            levelZero.isHidden = false
            levelOne.isHidden = false
            levelTwo.isHidden = false
            levelThree.isHidden = false
        } else {
            levelZero.isHidden = true
            levelOne.isHidden = true
            levelTwo.isHidden = true
            levelThree.isHidden = true
        }
    }
    func setNumbers() {
        numberOne.text = "\(arc4random_uniform(UInt32(maxLevel-minLevel)+1) + UInt32(minLevel))"
        numberTwo.text = "\(arc4random_uniform(UInt32(maxLevel-minLevel)+1) + UInt32(minLevel))"
    }
    func hideButton(next:Bool, check:Bool) {
        buttonCheck.isHidden = check
        buttonNext.isHidden = next
    }
    func setLevel(minLevel:Int, maxLevel:Int, points:Int) {
        self.minLevel = minLevel
        self.maxLevel = maxLevel
        self.points = points
        currentLevel.text = "Уровень \(points-1) - числа от \(minLevel) до \(maxLevel) (\(points) балла)"
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        currentLevel.text = "Уровень \(points-1) - числа от \(minLevel) до \(maxLevel) (\(points) балла)"
        setNumbers()
    }
 
}

