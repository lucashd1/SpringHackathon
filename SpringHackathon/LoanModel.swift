//
//  LoanModel.swift
//  SpringHackathon
//
//  Created by Max on 4/18/15.
//  Copyright (c) 2015 lucashd. All rights reserved.
//

import Foundation

class Loan {
    var score = 0
    var state = ""
    var type = "Auto"
    var loan = "36_Month_New"
    var range = ""
    var apr : Float = 0
    var min : Float = 0
    var max : Float = 0
    var months: Float = 36
    var monthly: Float = 0
    var estimated = 0
    var income: Float = 0
    var total : Float = 0
    
    init(score: Int, state: String) {
        self.score = score
        self.state = state
        calcLoanRecommendation()
    }
    
    func calcLoanRecommendation() {
        if type == "Auto" {
            var maxdebt: Float = 0
            var maxDTI: Float = 0
            let avg: Float = 471*self.months
            if score >= 720 {
                self.range = "720_850"
                maxDTI = 0.4
                maxdebt = maxDTI * self.income
            }
            else if score >= 690 {
                self.range = "690_719"
                maxDTI = 0.3
                maxdebt = maxDTI * self.income
            }
            else if score >= 660 {
                self.range = "660_689"
                maxDTI = 0.3
                maxdebt = maxDTI * self.income
            }
            else if score >= 620 {
                self.range = "620_659"
                maxDTI = 0.3
                maxdebt = maxDTI * self.income
            }
            else if score >= 590 {
                self.range = "590_619"
                maxDTI = 0.17
                maxdebt = maxDTI * self.income
            }
            else {
                self.range = "500_589"
                maxDTI = 0.15
                maxdebt = maxDTI * self.income
            }
            self.min = 1000
            let curDTI = self.total / self.income
            let maxMonthly = (maxDTI * self.income) - total
            self.max = maxMonthly * self.months
            self.max = round(self.max, rnd: 500)
            if self.max < avg {
                self.max = avg
            }
        }
        else {
            var maxdebt: Float = 0
            var maxDTI: Float = 0
            let avg: Float = 1061*self.months
            if score >= 760 {
                self.range = "760_850"
                maxDTI = 0.4
                maxdebt = maxDTI * self.income
            }
            else if score >= 700 {
                self.range = "700_759"
                maxDTI = 0.4
                maxdebt = maxDTI * self.income
            }
            else if score >= 680 {
                self.range = "680_699"
                maxDTI = 0.3
                maxdebt = maxDTI * self.income
            }
            else if score >= 660 {
                self.range = "660_679"
                maxDTI = 0.3
                maxdebt = maxDTI * self.income
            }
            else if score >= 640 {
                self.range = "640_659"
                maxDTI = 0.25
                maxdebt = maxDTI * self.income
            }
            else {
                self.range = "620_639"
                maxDTI = 0.25
                let maxdebt = maxDTI * self.income
            }
            self.min = 100000
            let curDTI = self.total / self.income
            let maxMonthly = (maxDTI * self.income) - total
            self.max = maxMonthly * self.months
            self.max = round(self.max, rnd: 1000)
            if self.max < avg {
                self.max = avg
            }
        }
    }
    
    func round(val: Float, rnd: Float) -> Float {
        var res: Float = val
        let mod = res % rnd
        let mid = rnd / 2
        if mod < mid {
            res = res - mod
        }
        else {
            res = res + (rnd - mod)
        }
        return res
    }
    
    func calcAPR() {
        if let path = NSBundle.mainBundle().pathForResource("LoanJSON", ofType: "json") {
            if let data = NSData(contentsOfFile: path) {
                let json = JSON(data: data, options: NSJSONReadingOptions.AllowFragments, error: nil)
                self.apr = json[self.state][self.loan][self.range].floatValue
            }
        }
    }
    
    func calcRate() -> Float {
        return self.apr / 1200
    }
    
    func calcMonthly(principal: Float) -> Float {
        let rate = calcRate()
        let exp = pow(1+rate, self.months)
        self.monthly = (rate + (rate/(exp-1))) * principal
        return self.monthly
    }
    
    func calcInterestPaid(principal: Float) -> Float {
        let monthly = calcMonthly(principal)
        return monthly * self.months - principal
    }
    
    func calcEstimated() {
        if self.type == "Auto" {
            self.estimated = self.score - 10
        }
        else {
            self.estimated = self.score - 15
        }
        var mnths = 12
        var additional = 0;
        if self.monthly > 10000 {
            additional = 50
        }
        else if self.monthly > 5000 {
            additional = 30
        }
        else if self.monthly > 1000 {
            additional = 20
        }
        else {
            additional = 15
        }
        while(mnths != 0) {
            self.estimated += additional
            mnths = mnths - 1
        }
        if self.estimated > 990 {
            self.estimated = 990
        }
        if self.estimated < 501 {
            self.estimated = 501
        }
        println(self.estimated)
    }
}