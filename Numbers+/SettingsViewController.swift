import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var labelSum: UILabel!
    @IBOutlet weak var labelSub: UILabel!
    @IBOutlet weak var labelMult: UILabel!
    @IBOutlet weak var labelDivide: UILabel!
    @IBOutlet weak var textGameType: UITextView!
    @IBOutlet weak var switchSum: UISwitch!
    @IBOutlet weak var switchSub: UISwitch!
    @IBOutlet weak var switchMult: UISwitch!
    @IBOutlet weak var switchDivide: UISwitch!
    @IBOutlet weak var switchGameType: UISwitch!
    
    @IBAction func sumSwitch(_ sender: UISwitch) {
        if switchSub.isOn == false && switchMult.isOn == false && switchDivide.isOn == false {
            switchSum.isOn = true
        } else {
            if GameManager.main.statusSum == false {
                GameManager.main.statusSum = true
                GameManager.main.textColorSumSwitchLabel = UIColor.black
                labelSum.textColor = GameManager.main.textColorSumSwitchLabel
            } else {
                GameManager.main.statusSum = false
                GameManager.main.textColorSumSwitchLabel = UIColor.gray
                labelSum.textColor = GameManager.main.textColorSumSwitchLabel
            }
        }
    }
    @IBAction func subtractionSwitch(_ sender: UISwitch) {
        if switchSum.isOn == false && switchMult.isOn == false && switchDivide.isOn == false {
            switchSub.isOn = true
        } else {
            if GameManager.main.statusSub == false {
                GameManager.main.statusSub = true
                GameManager.main.textColorSubSwitchLabel = UIColor.black
                labelSub.textColor = GameManager.main.textColorSubSwitchLabel
            } else {
                GameManager.main.statusSub = false
                GameManager.main.textColorSubSwitchLabel = UIColor.gray
                labelSub.textColor = GameManager.main.textColorSubSwitchLabel
            }
        }
    }
    
    @IBAction func multiplicationSwitch(_ sender: UISwitch) {
        if switchSum.isOn == false && switchSub.isOn == false && switchDivide.isOn == false {
            switchMult.isOn = true
        } else {
            if GameManager.main.statusMult == false {
                GameManager.main.statusMult = true
                GameManager.main.textColorMultSwitchLabel = UIColor.black
                labelMult.textColor = GameManager.main.textColorMultSwitchLabel
            } else {
                GameManager.main.statusMult = false
                GameManager.main.textColorMultSwitchLabel = UIColor.gray
                labelMult.textColor = GameManager.main.textColorMultSwitchLabel
            }
        }
    }
    
    @IBAction func divideSwitch(_ sender: UISwitch) {
        if switchSum.isOn == false && switchMult.isOn == false && switchSub.isOn == false {
            switchDivide.isOn = true
        } else {
            if GameManager.main.statusDivide == false {
                GameManager.main.statusDivide = true
                GameManager.main.textColorDivideSwitchLabel = UIColor.black
                labelDivide.textColor = GameManager.main.textColorDivideSwitchLabel
            } else {
                GameManager.main.statusDivide = false
                GameManager.main.textColorDivideSwitchLabel = UIColor.gray
                labelDivide.textColor = GameManager.main.textColorDivideSwitchLabel
            }
        }
    }
    
    @IBAction func gameType(_ sender: UISwitch) {
        if GameManager.main.statusGameType == false {
            GameManager.main.statusGameType = true
            GameManager.main.textColorGameTypeSwitchText = UIColor.black
            textGameType.textColor = GameManager.main.textColorGameTypeSwitchText
        } else {
            GameManager.main.statusGameType = false
            GameManager.main.textColorGameTypeSwitchText = UIColor.gray
            textGameType.textColor = GameManager.main.textColorGameTypeSwitchText
        }

    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //при появлении окна настроек отображаються последние изменения
        switchSum.isOn = GameManager.main.statusSum
        labelSum.textColor = GameManager.main.textColorSumSwitchLabel
        
        switchSub.isOn = GameManager.main.statusSub
        labelSub.textColor = GameManager.main.textColorSubSwitchLabel
        
        switchMult.isOn = GameManager.main.statusMult
        labelMult.textColor = GameManager.main.textColorMultSwitchLabel
        
        switchDivide.isOn = GameManager.main.statusDivide
        labelDivide.textColor = GameManager.main.textColorDivideSwitchLabel
    
        switchGameType.isOn = GameManager.main.statusGameType
        textGameType.textColor = GameManager.main.textColorGameTypeSwitchText
    }
    
}
