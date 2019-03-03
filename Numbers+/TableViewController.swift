//
//  TableViewController.swift
//  Numbers+
//
//  Created by Andrey on 21.02.2019.
//  Copyright © 2019 Andrey. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    var arrayOfAnswers: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let xib = UINib(nibName: "MyCell", bundle: Bundle.main)
        tableView?.register(xib, forCellReuseIdentifier: "MyCell")
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfAnswers.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath) as UITableViewCell
        let check = UIImage(named: "check")
        let x = UIImage(named: "x")
        let lbl = cell.contentView.viewWithTag(1) as! UILabel
        let img = cell.contentView.viewWithTag(2) as! UIImageView
        lbl.text = arrayOfAnswers[indexPath.row]
        if arrayOfAnswers[indexPath.row].contains("Правильно") {
            img.image = check
        } else {
            img.image = x
        }
        return cell
    }

}
