//
//  DetailViewController.swift
//  Challenge2
//
//  Created by Ivan Erwin Lopez Ansaldo on 8/6/19.
//  Copyright © 2019 Ivan Erwin Lopez Ansaldo. All rights reserved.
//

import WebKit

class DetailViewController: UIViewController, WKNavigationDelegate {
    
    var website: String!
    private var webView: WKWebView!
    private var progressView: UIProgressView!
    
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }
    
    override func viewDidLoad() {
        
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)

        navigationItem.largeTitleDisplayMode = .never
        
        progressView = UIProgressView(progressViewStyle: .bar)
        progressView.sizeToFit()
        let progressButton = UIBarButtonItem(customView: progressView)
        let backButton = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(makeNavegation))
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let rightButton = UIBarButtonItem(title: "Forward", style: .plain, target: self, action: #selector(makeNavegation))
        
        toolbarItems = [backButton,spacer,progressButton,spacer,rightButton]
        
        guard let site = website ,let url = URL(string: "https://\(site)") else {return}
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isToolbarHidden = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.isToolbarHidden = true
    }
    
    @objc private func makeNavegation(sender: UIBarButtonItem) {
        if sender.title == "Back" {
            if self.webView.canGoBack {
                self.webView.goBack()
            }
        } else {
            if self.webView.canGoForward {
                self.webView.goForward()
            }
        }
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        title = webView.title
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            progressView.progress = Float(webView.estimatedProgress)
        }
    }
}
