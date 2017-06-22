//
//  ViewController.swift
//  HelloWorld
//
//  Created by GCWhiteShadow on 2017/6/21.
//  Copyright © 2017年 GCWhiteShadow. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    //MARK: properties
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var fontSizeLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func nameSegmentControl(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            nameLabel.text = "Hello World"
        }
        else{
            nameLabel.text = "Hello World to you"
        }
    }
    
    @IBAction func themeSwitch(_ sender: UISwitch) {
        if sender.isOn == true {
            nameLabel.textColor = UIColor.black
            fontSizeLabel.textColor = UIColor.black
            self.view.backgroundColor = UIColor.white
        }
        else {
            nameLabel.textColor = UIColor.white
            fontSizeLabel.textColor = UIColor.white
            self.view.backgroundColor = UIColor.black
        }
    }
    
    @IBAction func nameSlider(_ sender: UISlider) {
        nameLabel.font = nameLabel.font.withSize(CGFloat(Int(sender.value)))
        fontSizeLabel.text = String(Int(sender.value))
    }
    

}

