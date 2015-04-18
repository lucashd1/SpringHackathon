//
//  LoanEstimatorViewController.swift
//  SpringHackathon
//
//  Created by Vanessa Forney on 4/17/15.
//  Copyright (c) 2015 lucashd. All rights reserved.
//

import UIKit

class LoanEstimatorViewController: UIViewController {
    enum LoanType {
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
    @IBOutlet weak var principal: UILabel!
    @IBOutlet weak var slider: UISlider!
    
    var user: User?
    var selected = LoanType.Auto
    var loan: Loan!
    
    @IBAction func selectorChanged(sender: AnyObject) {
        switch selector.selectedSegmentIndex {
        case 1:
            loanTerm.removeAllSegments()
            loanTerm.insertSegmentWithTitle("15", atIndex: 0, animated: true)
            loanTerm.insertSegmentWithTitle("30", atIndex: 1, animated: true)
            loanTermUnit.text = "years"
            selected = LoanType.Mortgage
            self.loan.type = "Mortgage"
            
        case 0:
            loanTerm.removeAllSegments()
            loanTerm.insertSegmentWithTitle("36", atIndex: 0, animated: true)
            loanTerm.insertSegmentWithTitle("48", atIndex: 1, animated: true)
            loanTerm.insertSegmentWithTitle("60", atIndex: 2, animated: true)
            loanTermUnit.text = "months"
            selected = LoanType.Auto
            self.loan.type = "Auto"
            
        default:
            println("test")
        }
        self.loan.calcRest()
        self.minLoan.text = "$\(self.loan.min)0"
        self.maxLoan.text = "$\(self.loan.max)0"
        slider.minimumValue = self.loan.min
        slider.maximumValue = self.loan.max
        slider.value = slider.minimumValue
    }
    
    @IBAction func loanTermChanged(sender: AnyObject) {
        if self.loan.type == "Auto" {
            switch loanTerm.selectedSegmentIndex {
            case 2:
                self.loan.loan = "60_Month_New"
                self.loan.months = 60.0
            
            case 1:
                self.loan.loan = "48_Month_New"
                self.loan.months = 48.0
                
            case 0:
                self.loan.loan = "36_Month_New"
                self.loan.months = 36.0
                
            default:
                println("error")
            }
        }
        else {
            switch loanTerm.selectedSegmentIndex {
            case 1:
                self.loan.loan = "30_Year_Fixed"
                self.loan.months = 30.0 * 12.0
                
            case 0:
                self.loan.loan = "15_Year_Fixed"
                self.loan.months = 15.0 * 12.0
                
            default:
                println("error")
            }
        }
    }
    
    @IBAction func sliderChanged(sender: UISlider) {
        var current = Double(sender.value)
        var costString = NSString(format:"$%.2f", current)
        principal.text = costString as String
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let tabBarController = self.tabBarController as? TabBarController {
            self.user = tabBarController.user
        }
        
        if let font = UIFont(name: "IntroSemiBoldCaps", size: 14) {
            estimateScoreButton.titleLabel!.font =  font
        }
        self.minLoan.text = "$\(self.loan.min)0"
        self.maxLoan.text = "$\(self.loan.max)0"
        slider.minimumValue = self.loan.min
        slider.maximumValue = self.loan.max
        slider.value = slider.minimumValue
        let current = Double(slider.value)
        let costString = NSString(format:"$%.2f", current)
        principal.text = costString as String
    }
    
    @IBAction func calculate(sender: AnyObject) {
        self.loan.calcAPR()
        self.apr.text = "%\(self.loan.apr)"
        let monthly = self.loan.calcMonthly(self.slider.value)
        self.monthlyPayment.text = NSString(format: "$%.2f", monthly) as String
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "toEstimatedScore" {
            if let destinationViewController = segue.destinationViewController as? EstimateScoreViewController {
                self.loan.calcEstimated()
                destinationViewController.loan = self.loan
            }
        }
    }
}
