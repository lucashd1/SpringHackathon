//
//  IncomeViewController.swift
//  SpringHackathon
//
//  Created by Max on 4/18/15.
//  Copyright (c) 2015 lucashd. All rights reserved.
//

import UIKit

extension String {
    var floatValue: Float {
        return (self as NSString).floatValue
    }
}

class IncomeViewController: UIViewController {
    @IBOutlet weak var income: UITextField!
    @IBOutlet weak var smartLoanDescription: UILabel!
    
    var loan: Loan!

    @IBAction func incomeChanged(sender: AnyObject) {
        self.income.addTarget(self, action: Selector("editIncome:"), forControlEvents: UIControlEvents.EditingChanged)
    }
    
    func editIncome(theTextField: UITextField) -> Void {
        var currentValue: NSString = self.income.text
        var strippedValue: NSString = currentValue.stringByReplacingOccurrencesOfString("[^0-9]", withString: "", options: .RegularExpressionSearch,
            range: NSMakeRange(0, currentValue.length))
        var formattedString = ""
        
        if strippedValue.length > 0 {
            var formatter = NSNumberFormatter()
            formatter.numberStyle = .DecimalStyle

            var number = formatter.numberFromString(strippedValue as String)
            formatter.numberStyle = .CurrencyStyle
            
            var formattedNumber = formatter.stringFromNumber(number!)!
            var range = Range(start: advance(formattedNumber.startIndex, 1), end: advance(formattedNumber.endIndex, -3))
            formattedString = formattedNumber.substringWithRange(range)
            
        }
        
        self.income.text = formattedString
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let backButton = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.Bordered, target: nil, action: nil)
        self.navigationItem.backBarButtonItem = backButton
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        self.view.endEditing(true)
    }
    
    @IBAction func next(sender: AnyObject) {
        if let inc = self.income.text {
            if inc.isEmpty == false {
                loan.income = income.text.floatValue
                self.performSegueWithIdentifier("showLoanEstimator", sender: self)
            }
        }
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "showLoanEstimator" {
            if let destVC = segue.destinationViewController as? LoanEstimatorViewController {
                destVC.loan = self.loan
            }
        }
    }

}
