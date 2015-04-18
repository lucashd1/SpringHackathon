//
//  LoanEstimatorViewController.swift
//  SpringHackathon
//
//  Created by Vanessa Forney on 4/17/15.
//  Copyright (c) 2015 lucashd. All rights reserved.
//

import UIKit

class LoanEstimatorViewController: UIViewController {
    @IBOutlet weak var selector: UISegmentedControl!
    @IBOutlet weak var minLoan: UILabel!
    @IBOutlet weak var maxLoan: UILabel!
    @IBOutlet weak var loanTerm: UISegmentedControl!
    @IBOutlet weak var loanTermUnit: UILabel!
    @IBOutlet weak var apr: UILabel!
    @IBOutlet weak var monthlyPayment: UILabel!
    @IBOutlet weak var estimateScoreButton: UIButton!
    
    var user: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let tabBarController = self.tabBarController as? TabBarController {
            self.user = tabBarController.user
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "toEstimatedScore" {
            if let destinationViewController = segue.destinationViewController as? EstimateScoreViewController {
                destinationViewController.estimatedScore = 500 // replace
            }
        }
    }
    
    // Home 30 year fixed, 15 year fixed
    // Auto 36 month new, 48 month new, 60 month new
}
