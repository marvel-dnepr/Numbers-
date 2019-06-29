import UIKit

class GameViewController: UIViewController {
    @IBOutlet weak var labelNumberOne: UILabel!
    @IBOutlet weak var labelNumberTwo: UILabel!
    @IBOutlet weak var labelSign: UILabel!
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
        GameManager.main.starNewGame()
        updateLabels()
        UIViewUtility.main.hideObject(objects: [buttonNext, buttonNewGame, labelCommentAnswers, buttonLog])
        buttonCheck.isHidden = false
    }
    
    @IBAction func buttonCheck(_ sender: UIButton) {
        if textFieldAnswer.text?.isEmpty == true {
            labelCommentAnswers.textColor = UIColor.red
            labelCommentAnswers.text = "ВВЕДИТЕ ОТВЕТ !!!"
            labelCommentAnswers.isHidden = false
        } else {
            let resultOfChecking = GameManager.main.isAnswerCorrect(answer: Int(textFieldAnswer.text!)!)
            switch resultOfChecking {
            case true:
                labelCommentAnswers.textColor = UIColor.blue
                labelCommentAnswers.text = "ПРАВИЛЬНО"
                buttonCheck.isHidden  = true
                buttonNext.isHidden = false
                labelCommentAnswers.isHidden = false
            case false:
                if GameManager.main.statusGame == .stillPlaying {
                    labelCommentAnswers.textColor = UIColor.red
                    labelCommentAnswers.text = "НЕ ВЕРНО!!!! ОТВЕТ = \(GameManager.main.trueAnswer)"
                    labelWrongAnswers.text = "Ошибки - \(GameManager.main.wrongAnswersCounter)"
                    buttonCheck.isHidden  = true
                    buttonNext.isHidden = false
                    labelCommentAnswers.isHidden = false
                } else {
                    labelWrongAnswers.text = "Ошибки - \(GameManager.main.wrongAnswersCounter)"
                    buttonCheck.isHidden = true
                    labelCommentAnswers.textColor = UIColor.red
                    labelCommentAnswers.text = "Game Over !!!"
                    UIViewUtility.main.showObject(objects: [buttonNewGame, labelCommentAnswers, buttonLog])
                }
            }
        }
    }
    
    @IBAction func buttonNext(_ sender: UIButton) {
        buttonNext.isHidden = true
        labelCommentAnswers.isHidden = true
        buttonCheck.isHidden = false
        GameManager.main.setAction()
        GameManager.main.generateNumbers()
        updateLabels()
    }
    
    func updateLabels() {
        labelNumberOne.text = "\(GameManager.main.numberOne)"
        labelNumberTwo.text = "\(GameManager.main.numberTwo)"
        labelSign.text = GameManager.main.sign
        labelLevelNumber.text = "Уровень - \(GameManager.main.level)"
        labelPointsScored.text = "Количество баллов - \(GameManager.main.pointsScored)"
        labelExampleNumber.text = "Пример - \(GameManager.main.exampleNumber)"
        labelWrongAnswers.text = "Ошибки - \(GameManager.main.wrongAnswersCounter)"
        textFieldAnswer.text = nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GameManager.main.starNewGame()
        updateLabels()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TableViewController
        destinationVC.arrayOfAnswers = GameManager.main.arrayOfAnswers
    }
}
