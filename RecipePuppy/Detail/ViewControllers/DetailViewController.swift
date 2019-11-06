//
//  DetailViewController.swift
//  RecipePuppy
//
//  Created by wearemobilefirst on 04/11/2019.
//  Copyright © 2019 badi. All rights reserved.
//

import UIKit
import WebKit

final class DetailViewController: UIViewController, AlertControllerDisplayable {
    
    private enum State {
        case idle
        case fetching
        case error(String?)
    }
    
    
    @IBOutlet private var webView: WKWebView!
    @IBOutlet private var activityIndicator: UIActivityIndicatorView!
    private var viewModel: DetailViewModel?
    
    private var state = State.idle {
        didSet {
            switch state {
            case .idle:
                activityIndicator.stopAnimating()
                webView.isHidden = false
            case .fetching:
                activityIndicator.startAnimating()
                webView.isHidden = false
            case .error(let message):
                activityIndicator.stopAnimating()
                webView.isHidden = true
                displayAlert(with: AlertConfiguration(body: message ?? "Oops, something went wrong, please try again"))
            }
        }
    }
    
    
    func configure(with viewModel: DetailViewModel) {
        self.viewModel = viewModel
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.navigationDelegate = self
        initate()
    }
    
    
    func initate() {
        guard let viewModel = self.viewModel else { return }
        webView.load(URLRequest(url: viewModel.url))
    }
    
}

// MARK: - UIWebViewDelegate

extension DetailViewController: WKNavigationDelegate {

    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        state = .fetching
    }

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        state = .idle
    }

    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        state = .error(error.localizedDescription)
    }

}
