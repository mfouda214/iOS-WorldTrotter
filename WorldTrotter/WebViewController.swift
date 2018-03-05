//
//  WebViewController.swift
//  WorldTrotter
//
//  Created by Mohamed Sobhi  Fouda on 3/5/18.
//  Copyright © 2018 Mohamed Sobhi Fouda. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController, WKUIDelegate {
    
    var webView: WKWebView!
    
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let myURL = URL(string: "https://www.google.com")
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
    }
}
