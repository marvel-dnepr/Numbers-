import UIKit

class UIViewUtility {
    
    static let main = UIViewUtility()
    
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
}

