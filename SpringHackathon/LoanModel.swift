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
    var range = ""
    var apr = 0.0
}

class LoanDataParser {
    var loan: Loan
    
    func loadJson() {
        if let path = NSBundle.mainBundle().pathForResource("LoanJSON", ofType: "json") {
            if let data = NSData(contentsOfFile: path) {
                let json = JSON(data: data, options: NSJSONReadingOptions.AllowFragments, error: nil)
                
                loan.apr = json[self.loan.state][self.loan.type][self.loan.range].doubleValue
            }
        }
    }
    
    init(loan: Loan) {
        self.loan = loan
    }
}