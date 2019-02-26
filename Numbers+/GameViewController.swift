import UIKit

class GameViewController: UIViewController {
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
        UIViewUtilities.main.hideObject(objects: [buttonNext, buttonNewGame, labelCommentAnswers, buttonLog])
        UIViewUtilities.main.showObject(objects: [buttonCheck])
        setTwoNumbers()
    }
    
    @IBAction func buttonCheck(_ sender: UIButton) {
        let resultOfChecking = GameManager.main.isAnswerCorrect(numberOne: Int(labelNumberOne.text!)!, numberTwo: Int(labelNumberTwo.text!)!, answer: textFieldAnswer.text!)
        switch resultOfChecking {
        case "Nil":
            labelCommentAnswers.textColor = UIColor.red
            labelCommentAnswers.text = GameManager.main.commentAnswers
            UIViewUtilities.main.showObject(objects: [labelCommentAnswers])
        case "Yes":
            UIViewUtilities.main.hideObject(objects: [buttonCheck])
            labelCommentAnswers.textColor = UIColor.blue
            labelCommentAnswers.text = GameManager.main.commentAnswers
            UIViewUtilities.main.showObject(objects: [buttonNext, labelCommentAnswers])
        case "No":
            UIViewUtilities.main.hideObject(objects: [buttonCheck])
            labelCommentAnswers.textColor = UIColor.red
            labelCommentAnswers.text = GameManager.main.commentAnswers
            UIViewUtilities.main.showObject(objects: [buttonNext, labelCommentAnswers])
        case "No. Game over":
            labelWrongAnswers.text = "\(GameManager.main.wrongAnswersText)\(GameManager.main.wrongAnswersCounter)"
            UIViewUtilities.main.hideObject(objects: [buttonCheck])
            labelCommentAnswers.textColor = UIColor.red
            labelCommentAnswers.text = GameManager.main.commentAnswers
            UIViewUtilities.main.showObject(objects: [buttonNewGame, labelCommentAnswers, buttonLog])
        default: GameManager.main.resetAllValues()
        }
    }
    
    @IBAction func buttonNext(_ sender: UIButton) {
        changeValuesInLabels()
        UIViewUtilities.main.hideObject(objects: [labelCommentAnswers, buttonNext])
        UIViewUtilities.main.showObject(objects: [buttonCheck])
        setTwoNumbers()
    }
    
    func changeValuesInLabels() {
        labelLevelNumber.text = "\(GameManager.main.levelNumberText)\(GameManager.main.level)"
        labelPointsScored.text = "\(GameManager.main.pointsScoredText)\(GameManager.main.pointsScored)"
        labelExampleNumber.text = "\(GameManager.main.exampleNumberText)\(GameManager.main.exampleNumber)"
        labelWrongAnswers.text = "\(GameManager.main.wrongAnswersText)\(GameManager.main.wrongAnswersCounter)"
        textFieldAnswer.text = nil
    }
    
    func setTwoNumbers () {
        labelNumberOne.text = GameManager.main.setNumbers()
        labelNumberTwo.text = GameManager.main.setNumbers()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GameManager.main.resetAllValues()
        setTwoNumbers()
    }
}
