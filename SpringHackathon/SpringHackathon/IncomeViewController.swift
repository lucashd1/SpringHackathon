//
//  IncomeViewController.swift
//  SpringHackathon
//
//  Created by Max on 4/18/15.
//  Copyright (c) 2015 lucashd. All rights reserved.
//

import UIKit

class IncomeViewController: UIViewController {
    @IBOutlet weak var income: UITextField!
    
    var loan: Loan!

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
    
    @IBAction func next(sender: AnyObject) {
        if let inc = self.income.text {
            if inc.isEmpty == false {
                loan.income = Float(income.text.toInt()!)
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
