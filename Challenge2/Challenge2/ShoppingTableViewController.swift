//
//  ViewController.swift
//  Challenge2
//
//  Created by Ivan Erwin Lopez Ansaldo on 8/8/19.
//  Copyright © 2019 Ivan Erwin Lopez Ansaldo. All rights reserved.
//

import UIKit

class ShoppingTableViewController: UITableViewController {

    var shoppingList = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        
        tableView.tableFooterView = UIView(frame: .zero)
        
    }
    
    private func configureNavigationBar() {
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapAdd))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareShoppingList))
        
        title = "Shopping List"
    }
    
    @objc func didTapAdd() {
        let ac = UIAlertController(title: "Add Product", message: nil, preferredStyle: .alert)
        ac.addTextField()
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let addAction = UIAlertAction(title: "Add", style: .default) {[weak self, weak ac] _ in
            guard let self = self else {return}
            self.isProductEmpty(product: ac?.textFields?[0].text)
        }
        ac.addAction(cancelAction)
        ac.addAction(addAction)
        
        present(ac, animated: true)
    }
    
    private func isProductEmpty(product: String?) {
        if let product = product, product.count > 0 {
            addProduct(with: product)
        } else {
            let ac = UIAlertController(title: "Error", message: "Product added is empty", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
            ac.addAction(okAction)
            present(ac, animated: true)
        }
    }
    
    private func addProduct(with product: String) {
        shoppingList.insert(product, at: 0)
        
        let indexPath = IndexPath(row: 0, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
    }
    
    @objc func shareShoppingList() {
        let list = shoppingList.joined(separator: "\n")
        let activityController = UIActivityViewController(activityItems: [list], applicationActivities: [])
        activityController.popoverPresentationController?.barButtonItem = navigationItem.leftBarButtonItem
        present(activityController, animated: true)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shoppingList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.textLabel?.text = shoppingList[indexPath.row]
        return cell
    }
}

