//
//  ViewController.swift
//  SpringHackathon
//
//  Created by Lucas David on 4/16/15.
//  Copyright (c) 2015 lucashd. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        var loader = JsonLoader()
        loader.loadJson()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

