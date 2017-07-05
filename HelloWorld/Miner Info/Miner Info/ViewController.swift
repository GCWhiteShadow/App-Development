//
//  ViewController.swift
//  Miner Monitor
//
//  Created by GCWhiteShadow on 2017/6/24.
//  Copyright © 2017年 GCWhiteShadow. All rights reserved.
//

import UIKit
import Alamofire
import Kanna

class ViewController: UIViewController {
    
    @IBOutlet weak var label0: UILabel!
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var label3: UILabel!
    @IBOutlet weak var label4: UILabel!
    @IBOutlet weak var label5: UILabel!
    @IBOutlet weak var label6: UILabel!
    @IBOutlet weak var label7: UILabel!
    
    var webContent1 = ""
    var webContent2 = ""
    var webContent3 = ""
    
    var totalSpeed = ""
    var totalShares = ""
    var rejected = ""
    var runTime = ""
    var GPU0speed = ""
    var GPU1speed = ""
    var GPU2speed = ""
    var incorrectShares = ""
    
    var name_arr = ["Total Speed", "Total Shares", "Rejected", "Run Time", "GPU 0", "GPU 1", "GPU2", "Incorrect Shares"]
    var detail_arr: [String] = ["","","","","","","",""]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        fetch()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func parseHTML(html: String) -> Void {
        if let doc = Kanna.HTML(html: html, encoding: String.Encoding.utf8) {
            
            for link in doc.xpath("//font[@color='#00ffff']") {
                self.webContent1 = self.webContent2
                self.webContent2 = self.webContent3
                self.webContent3 = link.text!
            }
        }
    }
    
    func printAll(){
        /*
        print("Total Speed: \(totalSpeed)")
        print("Total Shares: \(totalShares)")
        print("Rejected: \(rejected)")
        print("Run time: \(runTime)")
        print("GPU0: \(GPU0speed)")
        print("GPU1: \(GPU1speed)")
        print("GPU2: \(GPU2speed)")
        print("Incorrect Shares: \(incorrectShares)")
        */
        label0.text = "Total Speed: \(totalSpeed)"
        label1.text = "Total Shares: \(totalShares)"
        label2.text = "Rejected: \(rejected)"
        label3.text = "Run time: \(runTime)"
        label4.text = "GPU 0: \(GPU0speed)"
        label5.text = "GPU 1: \(GPU1speed)"
        label6.text = "GPU 2: \(GPU2speed)"
        label7.text = "Incorrect Shares: \(incorrectShares)"
    }
    
    func process1(){
        let s = CharacterSet(charactersIn: " ,-/ETHSRMotalhrehsjctdimp\n")
        var arr: [String] = webContent1.components(separatedBy: s)
        for i in (0..<arr.count).reversed() {
            if arr[i] == "" || arr[i] == ":" {
                arr.remove(at: i)
            }
        }
        totalSpeed = arr[0] + " Mh/s"
        totalShares = arr[1]
        rejected = arr[2]
        runTime = arr[3]
    }
    
    func process2(){
        let s = CharacterSet(charactersIn: " ,")
        var arr: [String] = webContent2.components(separatedBy: s)
        for i in (0..<arr.count).reversed() {
            if Float(arr[i]) == nil && arr[i] != "off"{
                arr.remove(at: i)
            }
        }
        
        GPU0speed = arr[0] == "off" ? arr[0] : arr[0] + "Mh/s"
        GPU1speed = arr[1] == "off" ? arr[1] : arr[1] + "Mh/s"
        GPU2speed = arr[2] == "off" ? arr[2] : arr[2] + "Mh/s"
    }
    
    func process3(){
        var arr: [String] = webContent3.components(separatedBy: "Incorrect ETH shares: ")
        incorrectShares = arr[1]
    }
    
    func parsingText(){
        process1()
        process2()
        process3()
    }
        
    func fetch(){
        Alamofire.request("http://140.113.69.67:3333").responseJSON { response in
            
            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                self.parseHTML(html: utf8Text)
                self.parsingText()
                self.printAll()
            }
        }
        
    }
    
    @IBAction func reloadButton(_ sender: UIButton) {
        fetch()
    }
    
}

