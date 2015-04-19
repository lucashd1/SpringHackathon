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
    @IBOutlet weak var report: UITextView!
    
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
        setTextField()
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        self.score.stringByEvaluatingJavaScriptFromString("showData(\(self.loan.estimated))")
    }
    
    func setTextField() {
        let type = "\(self.loan.type.uppercaseString) LOAN"
        let princ = self.loan.principal
        let length: Float = self.loan.months / 12
        let apr = self.loan.apr
        let diff = self.loan.estimated - self.loan.score
        self.report.text = "If you were to take out an \(type) of $\(princ)0 over \(length) YEARS at an APR OF \(apr)%, your credit score would change by \(diff) points in the next year."
    }
}
