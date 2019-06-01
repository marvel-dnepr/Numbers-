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
    var minNumber: Int = 0
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
    var statusSub = true
    var statusMult = true
    var statusDivide = true
    var statusGameType = false
    var textColorSumSwitchLabel = UIColor.black
    var textColorSubSwitchLabel = UIColor.black
    var textColorMultSwitchLabel = UIColor.black
    var textColorDivideSwitchLabel = UIColor.black
    var textColorGameTypeSwitchText = UIColor.gray
    
    
    
    
    //Метод старта новой игры
    func starNewGame() {
        resetAllValues()
        generateNumbers()
    }
   
    //Метод генерирования случайных чисел
    func generateNumbers() {
        self.numberOne = arc4random_uniform(UInt32(maxNumber-minNumber)+1) + UInt32(minNumber)
        self.numberTwo = arc4random_uniform(UInt32(maxNumber-minNumber)+1) + UInt32(minNumber)
    }

    //Метод проверяет ответ, записывает пример в массив, ведет счет правильных и не правильных ответов, ведет счет общего количества примеров, устанавливает уровень сложности, добавляет баллы и запоминает лучший результат. Возвращает результат проверки
    func isAnswerCorrect(answer: Int) -> Bool {
        let sum = numberOne + numberTwo
        if answer == sum {
            arrayOfAnswers.append("\(exampleNumber). Правильно: \(numberOne) + \(numberTwo) = \(sum)")
            correctAnswersCounter += 1
            exampleNumber += 1
            addPoints()
            setLevel()
            return true
        } else {
            arrayOfAnswers.append("\(exampleNumber). ОШИБКА: \(numberOne) + \(numberTwo) = \(sum) а не \(answer)")
            exampleNumber += 1
            wrongAnswersCounter += 1
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

    //Метод генерирования подсказки. ПРИДУМАТЬ АЛГОРИТМ !!!!!!!
    func getHint(numberOne : Int, numberTwo : Int) -> Int {
        let hint = numberOne + numberTwo
        return hint
    }

}

