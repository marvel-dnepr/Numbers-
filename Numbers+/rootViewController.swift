//
//  rootViewController.swift
//  Numbers+
//
//  Created by Andrey on 30.01.2019.
//  Copyright © 2019 Andrey. All rights reserved.
//

import UIKit

class rootViewController: UIViewController {
   
    @IBOutlet weak var labelBestScore: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        let defaults = UserDefaults.standard
        labelBestScore.text = defaults.string(forKey: "Best")
    }
}

