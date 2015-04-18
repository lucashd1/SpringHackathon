//
//  JsonLoader.swift
//  SpringHackathon
//
//  Created by Vanessa Forney on 4/17/15.
//  Copyright (c) 2015 lucashd. All rights reserved.
//

import Foundation

public class JsonLoader {
    func loadJson() {
        if let path = NSBundle.mainBundle().pathForResource("BellJSON", ofType: "json") {
            if let data = NSData(contentsOfFile: path) {
                let json = JSON(data: data, options: NSJSONReadingOptions.AllowFragments, error: nil)
                println("\(json)")
            }
        }
    }
}