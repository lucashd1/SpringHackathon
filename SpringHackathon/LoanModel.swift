//
//  LoanModel.swift
//  SpringHackathon
//
//  Created by Max on 4/18/15.
//  Copyright (c) 2015 lucashd. All rights reserved.
//

import Foundation

class LoanCalculator {
    var loan: Loan!
    
    func calcRate(apr: Double) -> Double {
        return self.loan.apr / 1200
    }
    
    func calcMonthly(rate: Double, months: Int, principal: Double) -> Double {
        let exp = pow(1+rate, Double(months))
        return (rate + (rate/(exp-1))) * principal
    }
    
    func calcInterestPaid(monthly: Double, months: Double, principal: Double) -> Double {
        return monthly * months - principal
    }
    
}

class Loan {
    var score = 0
    var state = ""
    var type = ""
    var loan = ""
    var range = ""
    var apr = 0.0
    
    init(score: Int, state: String, type: String, loan: String) {
        self.score = score
        self.state = state
        self.type = type
        self.loan = loan
        calcRange()
    }
    
    func calcRange() {
        if type == "Auto" {
            if score >= 720 {
                self.range = "720_850"
            }
            else if score >= 690 {
                self.range = "690_719"
            }
            else if score >= 660 {
                self.range = "660_689"
            }
            else if score >= 620 {
                self.range = "620_659"
            }
            else if score >= 590 {
                self.range = "590_619"
            }
            else {
                self.range = "500_589"
            }
        }
        else {
            if score >= 760 {
                self.range = "760_850"
            }
            else if score >= 700 {
                self.range = "700_759"
            }
            else if score >= 680 {
                self.range = "680_699"
            }
            else if score >= 660 {
                self.range = "660_679"
            }
            else if score >= 640 {
                self.range = "640_659"
            }
            else {
                self.range = "620_639"
            }
        }
    }
}

class LoanDataParser {
    var loan: Loan
    
    func loadJson() {
        if let path = NSBundle.mainBundle().pathForResource("LoanJSON", ofType: "json") {
            if let data = NSData(contentsOfFile: path) {
                let json = JSON(data: data, options: NSJSONReadingOptions.AllowFragments, error: nil)
                loan.apr = json[self.loan.state][self.loan.loan][self.loan.range].doubleValue
            }
        }
    }
    
    init(loan: Loan) {
        self.loan = loan
    }
}