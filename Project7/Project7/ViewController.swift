//
//  ViewController.swift
//  Project7
//
//  Created by Ivan Erwin Lopez Ansaldo on 8/12/19.
//  Copyright © 2019 Ivan Erwin Lopez Ansaldo. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

  var petitions = [Petition]()
  var filteredPetitions = [Petition]()
  var searchButton: UIButton {
    let button = UIButton()
    button.setTitle("Search", for: .normal)
    button.setTitleColor(.systemBlue, for: .normal)
    button.backgroundColor = .white
    button.addTarget(self, action: #selector(didTapSearchButton), for: .touchUpInside)
    return button
  }
  var searchText = String() {
    didSet {
      filteredPetitions = petitions
      if searchText != "" {
        filteredPetitions = filteredPetitions.filter {
          $0.title.contains(searchText) || $0.body.contains(searchText)
        }
      }
      tableView.reloadData()
    }
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    setupView()
    let urlString: String
    if navigationController?.tabBarItem.tag == 0 {
      urlString = "https://www.hackingwithswift.com/samples/petitions-1.json"
    } else {
      urlString = "https://www.hackingwithswift.com/samples/petitions-2.json"
    }
    if let url = URL(string: urlString) {
      if let data = try? Data(contentsOf: url) {
        parse(json: data)
        return
      }
    }
    showError()
  }

  func setupView() {
    navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Credits", style: .plain, target: self, action: #selector(didTapRightBarButtonItem))
  }

  @objc func didTapRightBarButtonItem() {
    let ac = UIAlertController(title: "Credits", message: "Data comes from the We The People API of the Whitehouse.", preferredStyle: .alert)
    ac.addAction(UIAlertAction(title: "OK", style: .default))
    present(ac, animated: true)
  }

  @objc func didTapSearchButton() {
    let ac = UIAlertController(title: "Search", message: nil, preferredStyle: .alert)
    ac.addTextField { (textField) in
      if self.searchText != "" {
        textField.text = self.searchText
      } else {
        textField.placeholder = "Enter some text or word..."
      }
    }
    ac.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak self] (_) in
      if let text = ac.textFields?[0].text {
        self?.searchText = text
      }
    }))
    present(ac, animated: true)
  }

  func parse(json: Data) {
    let decoder = JSONDecoder()
    if let jsonPetitions = try? decoder.decode(Petitions.self, from: json) {
      petitions = jsonPetitions.results
      filteredPetitions = petitions
      tableView.reloadData()
    }
  }

  func showError() {
    let ac = UIAlertController(title: "Loading error",
                               message: "There was a problem loading the feed; please check your connection and try again.",
                               preferredStyle: .alert)
    ac.addAction(UIAlertAction(title: "OK", style: .default))
    present(ac, animated: true)
  }

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return filteredPetitions.count
  }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
    let petition = filteredPetitions[indexPath.row]
    cell.textLabel?.text = petition.title
    cell.detailTextLabel?.text = petition.body
    return cell
  }

  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let vc = DetailViewController()
    vc.detailItem = filteredPetitions[indexPath.row]
    navigationController?.pushViewController(vc, animated: true)
  }

  override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    return searchButton
  }
}
