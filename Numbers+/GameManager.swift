//
//  GameManager.swift
//  Numbers+
//
//  Created by Andrey on 18.02.2019.
//  Copyright © 2019 Andrey. All rights reserved.
//

import Foundation
import UIKit

enum StatusGame {
    case stillPlaying
    case gameOver
}

class GameManager {

    static let main = GameManager()

    var numberOne: UInt32 = 0
    var numberTwo: UInt32 = 0
    var minNumber: Int = 1
    var maxNumber: Int = 10
    var level: Int = 1
    var pointsScored: Int = 0
    var correctAnswersCounter: Int = 0
    var wrongAnswersCounter: Int = 0
    var numberOfPossibleErrors: Int = 3
    var exampleNumber: Int = 1
    var arrayOfAnswers: [String] = []
    var statusGame = StatusGame.stillPlaying
    var statusSum = true
    var statusSub = false
    var statusMult = false
    var statusDivide = false
    var statusGameType = false
    var textColorSumSwitchLabel = UIColor.black
    var textColorSubSwitchLabel = UIColor.gray
    var textColorMultSwitchLabel = UIColor.gray
    var textColorDivideSwitchLabel = UIColor.gray
    var textColorGameTypeSwitchText = UIColor.gray
    var action: Int = 1
    var sign = "+"
    var trueAnswer: Int = 0
    var lastAnswer: UInt32 = 0
    
    //Метод старта новой игры
    func starNewGame() {
        resetAllValues()
        setAction()
        generateNumbers()
    }
    
    //Мето случайного выбора (+ - * /) и установки действия в пример
    func setAction() {
        action = 0
        while action == 0 {
            let someAction = Int(arc4random_uniform(UInt32(5)))
            switch someAction {
            case 1: if statusSum == true {action = 1; sign = "+"} //+
            case 2: if statusSub == true {action = 2; sign = "-"} //-
            case 3: if statusMult == true {action = 3; sign = "*"} // умножить
            case 4: if statusDivide == true {action = 4; sign = "/"} // разделить
            default: action = 0
            }
        }
    }
    
    //Метод генерирования случайных чисел, если выбрано деление, тогда подбирает числа чтоб деление было без остатка и числа были не одинаковыми и делитель не равнялся единице. Если выбрано умножить, тогда исключаются единицы.
    func generateNumbers() {
        if GameManager.main.statusGameType == false {
            if GameManager.main.sign == "/" {
                var a = 1
                while a != 0 {
                    self.numberOne = arc4random_uniform(UInt32(maxNumber-minNumber)+1) + UInt32(minNumber)
                    self.numberTwo = arc4random_uniform(UInt32(maxNumber-minNumber)+1) + UInt32(minNumber)
                    a = Int(GameManager.main.numberOne) % Int(GameManager.main.numberTwo)
                    if GameManager.main.numberOne == GameManager.main.numberTwo || GameManager.main.numberTwo == 1 {
                        a = 1
                    }
                }
            } else if GameManager.main.sign == "*" {
                var a = 1
                while a != 0 {
                    self.numberOne = arc4random_uniform(UInt32(maxNumber-minNumber)+1) + UInt32(minNumber)
                    self.numberTwo = arc4random_uniform(UInt32(maxNumber-minNumber)+1) + UInt32(minNumber)
                    if GameManager.main.numberOne == 1 || GameManager.main.numberTwo == 1 {
                        a = 1
                    } else {a = 0}
                }
            } else {
                self.numberOne = arc4random_uniform(UInt32(maxNumber-minNumber)+1) + UInt32(minNumber)
                self.numberTwo = arc4random_uniform(UInt32(maxNumber-minNumber)+1) + UInt32(minNumber)
            }
        } else {
            if GameManager.main.sign == "/" {
                var a = 1
                while a != 0 {
                    self.numberOne = GameManager.main.lastAnswer
                    self.numberTwo = arc4random_uniform(UInt32(maxNumber-minNumber)+1) + UInt32(minNumber)
                    a = Int(GameManager.main.numberOne) % Int(GameManager.main.numberTwo)
                    if GameManager.main.numberOne == GameManager.main.numberTwo || GameManager.main.numberTwo == 1 {
                        a = 1
                    }
                }
            } else if GameManager.main.sign == "*" {
                var a = 1
                while a != 0 {
                    self.numberOne = GameManager.main.lastAnswer
                    self.numberTwo = arc4random_uniform(UInt32(maxNumber-minNumber)+1) + UInt32(minNumber)
                    if GameManager.main.numberTwo == 1 {
                        a = 1
                    } else {a = 0}
                }
            } else {
                self.numberOne = GameManager.main.lastAnswer
                self.numberTwo = arc4random_uniform(UInt32(maxNumber-minNumber)+1) + UInt32(minNumber)
            }
        }
    }
    //Метод проверяет ответ, записывает пример в массив, ведет счет правильных и не правильных ответов, ведет счет общего количества примеров, устанавливает уровень сложности, добавляет баллы и запоминает лучший результат. Возвращает результат проверки
    func isAnswerCorrect(answer: Int) -> Bool {
        switch sign {
            case "+": trueAnswer = Int(numberOne + numberTwo)
            case "-": trueAnswer = Int(numberOne) - Int(numberTwo)
            case "*": trueAnswer = Int(numberOne * numberTwo)
            case "/": trueAnswer = Int(numberOne / numberTwo)
            default: trueAnswer = Int(numberOne + numberTwo)
        }
        if answer == trueAnswer {
            arrayOfAnswers.append("\(exampleNumber). Правильно: \(numberOne) \(sign) \(numberTwo) = \(trueAnswer)")
            correctAnswersCounter += 1
            exampleNumber += 1
            addPoints()
            setLevel()
            GameManager.main.lastAnswer = UInt32(answer)
            return true
        } else {
            arrayOfAnswers.append("\(exampleNumber). ОШИБКА: \(numberOne) \(sign) \(numberTwo) = \(trueAnswer) а не \(answer)")
            exampleNumber += 1
            wrongAnswersCounter += 1
            GameManager.main.lastAnswer = UInt32(trueAnswer)
            if wrongAnswersCounter == numberOfPossibleErrors {
                rememberBestResult()
                statusGame = .gameOver
            } else {
                statusGame = .stillPlaying
            }
            return false
        }
    }
    
    //Метод повышения уровня сложности в зависимости от количества правильных ответов
    func setLevel() {
        switch correctAnswersCounter {
            //Убрал ограничение минимального числа, чтоб правильно работал подбор чисел при делении
            case  5: level = 2; /*minNumber = 11;*/ maxNumber = 20
            case 20: level = 3; /*minNumber = 21;*/ maxNumber = 50
            case 30: level = 4; /*minNumber = 51;*/ maxNumber = 100
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
        minNumber = 1
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

    //Метод генерирования подсказки. ПРИДУМАТЬ АЛГОРИТМ !!!!!!!
    func getHint(numberOne : Int, numberTwo : Int) -> Int {
        let hint = numberOne + numberTwo
        return hint
    }

}

