//
//  GameManager.swift
//  Numbers+
//
//  Created by Andrey on 18.02.2019.
//  Copyright © 2019 Andrey. All rights reserved.
//

import Foundation
import UIKit

class GameManager {

    static let main = GameManager()

    var minNumber: Int = 0
    var maxNumber: Int = 10
    var level: Int = 1
    var pointsScored: Int = 0
    var correctAnswersCounter: Int = 0
    var wrongAnswersCounter: Int = 0
    var exampleNumber: Int = 1
    var arrayOfAnswers: [String] = []
    
    //Метод установки случайных чисел в пример
    func setNumbers(numberOne: UILabel, numberTwo: UILabel) {
        numberOne.text = "\(arc4random_uniform(UInt32(maxNumber-minNumber)+1) + UInt32(minNumber))"
        numberTwo.text = "\(arc4random_uniform(UInt32(maxNumber-minNumber)+1) + UInt32(minNumber))"
    }

    //Метод скрытия объектов
    func hideObject(objects: [UIView]) {
        for someObject in objects {
            someObject.isHidden = true
        }
    }

    //Метод отображения объектов
    func showObject(objects: [UIView]) {
        for someObject in objects {
            someObject.isHidden = false
        }
    }

    //Метод проверяет ответ, устанавливает уровень сложности, добавляет баллы. Возвращает истина или ложь и правильный ответ
    func isAnswerCorrect(numberOne: UILabel, numberTwo: UILabel, answer: UITextField) -> (Bool,Int) {
        let sum = (Int(numberOne.text!))! + (Int(numberTwo.text!))!
        if Int(answer.text!) == sum {
            arrayOfAnswers.append("Правильно: \(numberOne.text!) + \(numberTwo.text!) = \(sum)")
            correctAnswersCounter += 1
            exampleNumber += 1
            addPoints()
            setLevel()
            return (true, sum)
        } else {
            arrayOfAnswers.append("ОШИБКА: \(numberOne.text!) + \(numberTwo.text!) = \(sum) а не \(answer.text!)")
            exampleNumber += 1
            wrongAnswersCounter += 1
            return (false, sum)
        }
    }
    
    //Метод повышения уровня сложности в зависимости от количества правильных ответов
    func setLevel() {
        switch correctAnswersCounter {
            case  5: level = 2; minNumber = 11; maxNumber = 20
            case 20: level = 3; minNumber = 21; maxNumber = 50
            case 30: level = 4; minNumber = 51; maxNumber = 100
            default: level += 0
        }
    }

    //Метод добавления баллов в зависимости от уровня сложности
    func addPoints() {
        switch level {
            case 1:   pointsScored += 1
            case 2:   pointsScored += 2
            case 3:   pointsScored += 3
            case 4:   pointsScored += 4
            default:  pointsScored += 0
        }
    }

    //Метод сброса всех значений до стартовых
    func resetAllValues() {
        minNumber = 0
        maxNumber = 10
        level = 1
        pointsScored = 0
        correctAnswersCounter = 0
        wrongAnswersCounter = 0
        exampleNumber = 1
        arrayOfAnswers = []
    }

    //Метод запоминания лучшего результата игры
    func rememberBestResult() {
        let defaults = UserDefaults.standard
        let bestResult = defaults.string(forKey: "BestResult")
        if bestResult == nil {
            defaults.set(GameManager.main.pointsScored, forKey: "BestResult")
        } else {
            if Int(bestResult!)! < GameManager.main.pointsScored {
                defaults.set(GameManager.main.pointsScored, forKey: "BestResult")
            }
        }
    }
}
