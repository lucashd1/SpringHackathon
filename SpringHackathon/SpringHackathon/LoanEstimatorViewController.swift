//
//  LoanEstimatorViewController.swift
//  SpringHackathon
//
//  Created by Vanessa Forney on 4/17/15.
//  Copyright (c) 2015 lucashd. All rights reserved.
//

import UIKit

class LoanEstimatorViewController: UIViewController {
    enum Loan {
        case Auto, Mortgage
    }
    
    @IBOutlet weak var selector: UISegmentedControl!
    @IBOutlet weak var minLoan: UILabel!
    @IBOutlet weak var maxLoan: UILabel!
    @IBOutlet weak var loanTerm: UISegmentedControl!
    @IBOutlet weak var loanTermUnit: UILabel!
    @IBOutlet weak var apr: UILabel!
    @IBOutlet weak var monthlyPayment: UILabel!
    @IBOutlet weak var estimateScoreButton: UIButton!
    
    @IBAction func selectorChanged(sender: AnyObject) {
        switch selector.selectedSegmentIndex {
        case 0:
            loanTerm.removeAllSegments()
            loanTerm.insertSegmentWithTitle("15", atIndex: 0, animated: true)
            loanTerm.insertSegmentWithTitle("30", atIndex: 1, animated: true)
            loanTermUnit.text = "years"
            selected = Loan.Mortgage
            
        case 1:
            loanTerm.removeAllSegments()
            loanTerm.insertSegmentWithTitle("36", atIndex: 0, animated: true)
            loanTerm.insertSegmentWithTitle("48", atIndex: 1, animated: true)
            loanTerm.insertSegmentWithTitle("60", atIndex: 2, animated: true)
            loanTermUnit.text = "months"
            selected = Loan.Auto
            
        default:
            println("test")
        }
    }
    
    var user: User?
    var selected = Loan.Auto
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let tabBarController = self.tabBarController as? TabBarController {
            self.user = tabBarController.user
        }
        
        if let font = UIFont(name: "IntroSemiBoldCaps", size: 14) {
            estimateScoreButton.titleLabel!.font =  font
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "toEstimatedScore" {
            if let destinationViewController = segue.destinationViewController as? EstimateScoreViewController {
                destinationViewController.estimatedScore = 500 // replace
            }
        }
    }
}
