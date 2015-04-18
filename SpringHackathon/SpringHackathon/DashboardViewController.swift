//
//  ViewController.swift
//  SpringHackathon
//
//  Created by Lucas David on 4/16/15.
//  Copyright (c) 2015 lucashd. All rights reserved.
//

import UIKit

class DashboardViewController: UIViewController {
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var score: UILabel!
    
    var user: User?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        

        name.text = user!.name
        score.text = "\(user!.score)"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

