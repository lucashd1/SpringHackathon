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
    @IBOutlet weak var difference: UILabel!
    
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
        
        if let font = UIFont(name: "IntroRegular", size: 26) {
            self.difference.font = font
        }
        
        if diff < 0 {
            self.difference.text = "- \(diff)"
            self.difference.textColor = UIColor.redColor()
        } else {
            self.difference.text = "+ \(diff)"
            self.difference.textColor = UIColor(red: 0.153, green: 0.651, blue: 0.780, alpha: 1.0)
        }
    }
}
