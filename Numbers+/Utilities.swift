//
//  Utilities.swift
//  Numbers+
//
//  Created by Andrey on 12.02.2019.
//  Copyright © 2019 Andrey. All rights reserved.
//

import Foundation

class Hint {
    var numberOne : Int = 0
    var numberTwo : Int = 0
    var flag : Int = 0
    func getHint(numberOne : Int, numberTwo : Int) -> [Int] {
        if numberOne > 1 && numberTwo > 1 && numberOne != numberTwo {
            if numberOne > numberTwo {
                switch numberOne {
                    case 9:
                        self.numberOne = 1
                        self.numberTwo = numberTwo - 1
                        self.flag = 2
                    case 10, 100:
                        self.numberOne = numberOne
                        self.numberTwo = numberTwo
                        self.flag = 0
                    default :
                        self.numberOne = numberOne - numberTwo
                        self.numberTwo = numberTwo
                        self.flag = 1
                }
            } else {
                self.numberOne = numberOne
                self.numberTwo = numberTwo - numberOne
                self.flag = 2
            }
        } else {
            self.numberOne = numberOne
            self.numberTwo = numberTwo
            self.flag = 0
        }
    return [self.numberOne, self.numberTwo, self.flag]
    }
}
