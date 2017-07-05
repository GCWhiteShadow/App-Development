//
//  ViewController.swift
//  SimpleToolbox
//
//  Created by GCWhiteShadow on 2017/6/22.
//  Copyright © 2017年 GCWhiteShadow. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var numLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func numTextField(_ sender: UITextField) {
        let num: Float = Float(sender.text ?? "0.0")!
        
        
        numLabel.text = String(num)
    }

}

