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
    @IBOutlet weak var principal: UILabel!
    @IBOutlet weak var slider: UISlider!
    
    var user: User?
    var loan: Loan!
    
    func updateValues() {
        // Principal.
        self.principal.text = "$\(Int(slider.value))"
        
        // APR.
        self.loan.calcAPR()
        self.apr.text = NSString(format: "%.2f%%", self.loan.apr) as String
        
        // Monthly payment.
        let monthly = self.loan.calcMonthly(self.slider.value)
        self.monthlyPayment.text = NSString(format: "$%.2f", monthly) as String
    }
    
    func updateLoanRecommendation() {
        self.loan.calcLoanRecommendation()
        var f = self.loan.min / 1000
        var r = self.loan.min % 1000
        self.minLoan.text = "$\(Int(f))k"
        f = self.loan.max / 1000
        r = self.loan.max % 1000
        self.maxLoan.text = "$\(Int(f))k"
        slider.minimumValue = self.loan.min
        slider.maximumValue = self.loan.max
        slider.value = slider.minimumValue
    }
    
    @IBAction func selectorChanged(sender: AnyObject) {
        loanTerm.removeAllSegments()

        switch selector.selectedSegmentIndex {
        case 1:
            loanTerm.insertSegmentWithTitle("15", atIndex: 0, animated: true)
            loanTerm.insertSegmentWithTitle("30", atIndex: 1, animated: true)
            loanTermUnit.text = "years"
            self.loan.type = "Mortgage"
            self.loan.loan = "15_Year_Fixed"
            self.loan.months = 15.0 * 12.0
            
        case 0:
            loanTerm.insertSegmentWithTitle("36", atIndex: 0, animated: true)
            loanTerm.insertSegmentWithTitle("48", atIndex: 1, animated: true)
            loanTerm.insertSegmentWithTitle("60", atIndex: 2, animated: true)
            loanTermUnit.text = "months"
            self.loan.type = "Auto"
            self.loan.loan = "36_Month_New"
            self.loan.months = 36.0
            
        default:
            println("Default case")
        }
        
        loanTerm.selectedSegmentIndex = 0
        self.updateLoanRecommendation()
        self.updateValues()
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
        } else {
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
        self.updateLoanRecommendation()
        self.updateValues()
    }
    
    @IBAction func sliderChanged(sender: UISlider) {
        var roundVal: Float = 0
        if self.loan.type == "Auto" {
            roundVal = 500
        }
        else {
            roundVal = 1000
        }
        round(roundVal)
        self.updateValues()
    }
    
    func round(val: Float) {
        let mod = self.slider.value % val
        let mid = val / 2
        if mod < mid {
            slider.value -= mod
        }
        else {
            slider.value += (val - mod)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let tabBarController = self.tabBarController as? TabBarController {
            self.user = tabBarController.user
        }
        
        if let font = UIFont(name: "IntroSemiBoldCaps", size: 14) {
            estimateScoreButton.titleLabel!.font =  font
        }
        self.slider.setThumbImage(UIImage(named: "slider"), forState: UIControlState.Normal)
        self.slider.setThumbImage(UIImage(named: "slider"), forState: UIControlState.Selected)
        self.slider.setThumbImage(UIImage(named: "slider"), forState: UIControlState.Highlighted)
        
        self.updateLoanRecommendation()
        self.updateValues()
        
        let backButton = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.Bordered, target: nil, action: nil)
        self.navigationItem.backBarButtonItem = backButton
        
        let attributes = [NSForegroundColorAttributeName:UIColor(red: 92/255, green: 82/255, blue: 87/255, alpha: 1), NSFontAttributeName: UIFont(name: "IntroSemiBoldCaps", size: 14)!]
        
        selector.setTitleTextAttributes(attributes, forState: UIControlState.Normal)
        selector.setTitleTextAttributes(attributes, forState: UIControlState.Highlighted)
        selector.setTitleTextAttributes(attributes, forState: UIControlState.Selected)
        loanTerm.setTitleTextAttributes(attributes, forState: UIControlState.Normal)
        loanTerm.setTitleTextAttributes(attributes, forState: UIControlState.Highlighted)
        loanTerm.setTitleTextAttributes(attributes, forState: UIControlState.Selected)
        self.principal.font = self.principal.font.fontWithSize(22)
        self.apr.font = self.apr.font.fontWithSize(22)
        self.monthlyPayment.font = self.monthlyPayment.font.fontWithSize(22)
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
