//
//  User.swift
//  SpringHackathon
//
//  Created by Vanessa Forney on 4/17/15.
//  Copyright (c) 2015 lucashd. All rights reserved.
//

import Foundation

public class User {
    var date: String = ""
    var name: String = ""
    var state: String = ""
    var score: Int = 0
    var total: Float = 0
}

public class JsonLoader {
    var user: User?
    
    func loadJson() {
        if let path = NSBundle.mainBundle().pathForResource("BellJSON", ofType: "json") {
            if let data = NSData(contentsOfFile: path) {
                let json = JSON(data: data, options: NSJSONReadingOptions.AllowFragments, error: nil)
                let address = json["Reports"]["SINGLE_REPORT_TU"]["NEW-CurrentAddr"]["TUC"][0]["address"].stringValue
                let splitAddress = address.componentsSeparatedByString(" ")
                
                user = User()
                user?.date = json["Reports"]["SINGLE_REPORT_TU"]["ReportDate"]["TUC"].stringValue
                user?.name = json["Reports"]["SINGLE_REPORT_TU"]["Name"]["TUC"].stringValue
                user?.score = json["Reports"]["SINGLE_REPORT_TU"]["CreditScore"]["TUC"].intValue
                user?.state = splitAddress[splitAddress.count - 2]
                user?.total = json["Reports"]["SINGLE_REPORT_TU"]["TotalMonthlyPayments"]["TUC"].floatValue
            }
        }
    }
    
    init() {
        
    }
}