//
//  TableViewController.swift
//  Numbers+
//
//  Created by Andrey on 21.02.2019.
//  Copyright © 2019 Andrey. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

     override func numberOfSections(in tableView: UITableView) -> Int {
         return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return GameManager.main.arrayOfAnswers.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellOne", for: indexPath) as UITableViewCell
        let image = UIImage(named: "check")
        cell.imageView?.image = image
        cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        cell.textLabel?.text = GameManager.main.arrayOfAnswers[indexPath.row]
        return cell
    }

}
