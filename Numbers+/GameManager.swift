//
//  GameManager.swift
//  Numbers+
//
//  Created by Andrey on 18.02.2019.
//  Copyright © 2019 Andrey. All rights reserved.
//

import Foundation

class GameManager {

    static let main = GameManager()

    var minNumber: Int = 0
    var maxNumber: Int = 10
    var level: Int = 1
    var pointsScored: Int = 0
    var correctAnswersCounter: Int = 0
    var wrongAnswersCounter: Int = 0
    var numberOfPossibleErrors: Int = 3
    var exampleNumber: Int = 1
    var arrayOfAnswers: [String] = []
    var commentAnswers: String = ""
    var levelNumberText = "Уровень - "
    var pointsScoredText = "Количество баллов - "
    var exampleNumberText = "Пример - "
    var wrongAnswersText = "Ошибки - "
   
    //Метод установки случайных чисел в пример
    func setNumbers() -> String {
        return "\(arc4random_uniform(UInt32(maxNumber-minNumber)+1) + UInt32(minNumber))"
    }

    //Метод проверяет ответ, записывает пример в массив, ведет счет правильных и не правильных ответов, ведет счет общего количества примеров, устанавливает уровень сложности, добавляет баллы и запоминает лучший результат. Возвращает результат проверки
    func isAnswerCorrect(numberOne: Int, numberTwo: Int, answer: String) -> (String) {
        if answer == "" {
            commentAnswers = "ВВЕДИТЕ ОТВЕТ!!!!!!"
            return "Nil"
        } else {
            let sum = numberOne + numberTwo
            if Int(answer) == sum {
                arrayOfAnswers.append("\(exampleNumber). Правильно: \(numberOne) + \(numberTwo) = \(sum)")
                commentAnswers = "ПРАВИЛЬНО"
                correctAnswersCounter += 1
                exampleNumber += 1
                addPoints()
                setLevel()
                return "Yes"
            } else {
                arrayOfAnswers.append("\(exampleNumber). ОШИБКА: \(numberOne) + \(numberTwo) = \(sum) а не \(String(describing: answer))")
                commentAnswers = "НЕ ВЕРНО!!!! ОТВЕТ = \(sum)"
                exampleNumber += 1
                wrongAnswersCounter += 1
                if wrongAnswersCounter == numberOfPossibleErrors {
                    rememberBestResult()
                    return "No. Game over"
                } else {
                    return "No"
                }
            }
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

