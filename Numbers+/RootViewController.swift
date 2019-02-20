//
//  rootViewController.swift
//  Numbers+
//
//  Created by Andrey on 30.01.2019.
//  Copyright © 2019 Andrey. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {
   
    @IBOutlet weak var labelBestResult: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        let defaults = UserDefaults.standard
        labelBestResult.text = defaults.string(forKey: "BestResult")
    }
}

