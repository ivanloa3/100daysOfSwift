//
//  TableViewController.swift
//  Challenge2
//
//  Created by Ivan Erwin Lopez Ansaldo on 8/6/19.
//  Copyright © 2019 Ivan Erwin Lopez Ansaldo. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    let websites = ["google.com","apple.com","raywenderlich.com","hackingwithswift.com"]

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Websites"
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return websites.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.textLabel?.text = websites[indexPath.row]
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = DetailViewController()
        detailVC.website = websites[indexPath.row]
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

