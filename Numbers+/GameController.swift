//
//  GameController.swift
//  Numbers+
//
//  Created by Andrey on 19.02.2019.
//  Copyright © 2019 Andrey. All rights reserved.
//

import Foundation
import UIKit

class GameController: UIViewController {
    @IBOutlet weak var labelNumberOne: UILabel!
    @IBOutlet weak var labelNumberTwo: UILabel!
    @IBOutlet weak var textFieldAnswer: UITextField!
    @IBOutlet weak var labelCommentAnswers: UILabel!
    @IBOutlet weak var labelLevelNumber: UILabel!
    @IBOutlet weak var labelExampleNumber: UILabel!
    @IBOutlet weak var labelWrongAnswers: UILabel!
    @IBOutlet weak var labelPointsScored: UILabel!
    @IBOutlet weak var buttonNewGame: UIButton!
    @IBOutlet weak var buttonCheck: UIButton!
    @IBOutlet weak var buttonLog: UIButton!
    @IBOutlet weak var buttonNext: UIButton!
    
    @IBAction func buttonNewGame(_ sender: UIButton) {
        GameManager.main.resetAllValues()
        changeValuesInLabels()
        GameManager.main.hideObject(objects: [buttonNext, buttonNewGame, labelCommentAnswers, buttonLog])
        GameManager.main.showObject(objects: [buttonCheck])
        GameManager.main.setNumbers(numberOne: labelNumberOne, numberTwo: labelNumberTwo)
    }
    
    @IBAction func buttonCheck(_ sender: UIButton) {
        let (isAnswerCorrect, correctAnswer) = GameManager.main.isAnswerCorrect(numberOne: labelNumberOne, numberTwo: labelNumberTwo, answer: textFieldAnswer)
        if isAnswerCorrect == true {
            labelCommentAnswers.textColor = UIColor.blue
            labelCommentAnswers.text = "ПРАВИЛЬНО"
            GameManager.main.hideObject(objects: [buttonCheck])
            GameManager.main.showObject(objects: [buttonNext, labelCommentAnswers])
        } else {
            labelCommentAnswers.textColor = UIColor.red
            labelCommentAnswers.text = "НЕ ВЕРНО!!!! ОТВЕТ = \(correctAnswer)"
            if GameManager.main.wrongAnswersCounter == 3 {
                GameManager.main.rememberBestResult()
                GameManager.main.hideObject(objects: [buttonCheck])
                GameManager.main.showObject(objects: [buttonNewGame, labelCommentAnswers, buttonLog])
            } else {
                GameManager.main.hideObject(objects: [buttonCheck])
                GameManager.main.showObject(objects: [buttonNext, labelCommentAnswers])
            }
        }
    }
    
    @IBAction func buttonNext(_ sender: UIButton) {
        changeValuesInLabels()
        GameManager.main.hideObject(objects: [labelCommentAnswers, buttonNext])
        GameManager.main.showObject(objects: [buttonCheck])
        GameManager.main.setNumbers(numberOne: labelNumberOne, numberTwo: labelNumberTwo)
    }
    
    func changeValuesInLabels() {
        labelLevelNumber.text = "Уровень - \(GameManager.main.level)"
        labelPointsScored.text = "Количество баллов - \(GameManager.main.pointsScored)"
        labelExampleNumber.text = "Пример - \(GameManager.main.exampleNumber)"
        labelWrongAnswers.text = "Ошибки - \(GameManager.main.wrongAnswersCounter)"
        textFieldAnswer.text = nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GameManager.main.resetAllValues()
        GameManager.main.setNumbers(numberOne: labelNumberOne, numberTwo: labelNumberTwo)
    }
}
