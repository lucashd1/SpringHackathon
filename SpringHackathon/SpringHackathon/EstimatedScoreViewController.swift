//
//  EstimatedScoreViewController.swift
//  SpringHackathon
//
//  Created by Max on 4/18/15.
//  Copyright (c) 2015 lucashd. All rights reserved.
//

import UIKit

class EstimateScoreViewController: UIViewController {
    @IBOutlet weak var estimatedScoreLabel: UILabel!
    
    var estimatedScore: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        estimatedScoreLabel.text = "\(estimatedScore)"
    }
}
