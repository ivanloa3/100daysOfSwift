//
//  DetailViewController.swift
//  Project1
//
//  Created by Ivan Erwin Lopez Ansaldo on 7/1/19.
//  Copyright © 2019 Ivan Erwin Lopez Ansaldo. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet var imageView: UIImageView!
    
    var selectedImage: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.largeTitleDisplayMode = .never
        if let imageToLoad = selectedImage {
            title = imageToLoad
            imageView.image = UIImage(named: imageToLoad)
        }
    }
    
    override var prefersHomeIndicatorAutoHidden: Bool {
        return navigationController!.hidesBarsOnTap
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.hidesBarsOnTap = false
    }
}
