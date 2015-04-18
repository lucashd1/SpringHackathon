//
//  EstimatedScoreViewController.swift
//  SpringHackathon
//
//  Created by Max on 4/18/15.
//  Copyright (c) 2015 lucashd. All rights reserved.
//

import UIKit

class EstimateScoreViewController: UIViewController, UIWebViewDelegate {
    @IBOutlet weak var score: UIWebView!
    @IBOutlet weak var smartLoanDescription: UILabel!
    
    var loan: Loan!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.score.delegate = self
        
        if let path = NSBundle.mainBundle().pathForResource("index", ofType: "html") {
            let urlPath = NSURL.fileURLWithPath(path)
            if let contents = String(contentsOfFile: path, encoding: NSUTF8StringEncoding, error: nil) {
                self.score.loadHTMLString(contents, baseURL: urlPath)
            }
        }
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        self.score.stringByEvaluatingJavaScriptFromString("showData(\(self.loan.estimated))")
    }
}
