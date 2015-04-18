//
//  ViewController.swift
//  SpringHackathon
//
//  Created by Lucas David on 4/16/15.
//  Copyright (c) 2015 lucashd. All rights reserved.
//

import UIKit

class DashboardViewController: UIViewController, UIWebViewDelegate {
    @IBOutlet weak var score: UIWebView!
    
    var user: User?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.score.delegate = self
        
        if let tabBarController = self.tabBarController as? TabBarController {
            self.user = tabBarController.user
        }
        
        if let path = NSBundle.mainBundle().pathForResource("index", ofType: "html") {
            let urlPath = NSURL.fileURLWithPath(path)
            if let contents = String(contentsOfFile: path, encoding: NSUTF8StringEncoding, error: nil) {
                print("\(contents)")
                self.score.loadHTMLString(contents, baseURL: urlPath)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        self.score.stringByEvaluatingJavaScriptFromString("showData(660)")
    }
}

