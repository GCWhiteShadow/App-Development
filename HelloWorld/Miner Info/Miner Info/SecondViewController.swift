//
//  SecondViewController.swift
//  Miner Info
//
//  Created by GCWhiteShadow on 2017/6/26.
//  Copyright © 2017年 GCWhiteShadow. All rights reserved.
//

import UIKit
import Alamofire

extension Character {
    var asciiValue: UInt32? {
        return String(self).unicodeScalars.filter{$0.isASCII}.first?.value
    }
}

extension String {
    
    subscript (i: Int) -> Character {
        return self[index(startIndex, offsetBy: i)]
    }
    
    subscript (i: Int) -> String {
        return String(self[i] as Character)
    }
    
    subscript (r: Range<Int>) -> String {
        let start = index(startIndex, offsetBy: r.lowerBound)
        let end = index(startIndex, offsetBy: r.upperBound - r.lowerBound)
        return self[Range(start ..< end)]
    }
}

class SecondViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var priceTable: UITableView!
    
    var tickerName = ["USDT_BTC", "USDT_ETH", "USDT_ETC", "USDT_ZEC", "USDT_XMR"]
    var currencyName = ["BTC", "ETH", "ETC", "ZEC", "XMR"]
    
    var elements : [[String : Any]] = [["":0],["":0],["":0],["":0],["":0]]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.priceTable.delegate = self
        self.priceTable.dataSource = self
        fetch()
        priceTable.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tickerName.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = priceTable.dequeueReusableCell(withIdentifier: "currencyCell", for: indexPath) as! SingleCurrencyCell
        
        cell.currencyType.text = self.currencyName[indexPath.row]
        
        let price = self.elements[indexPath.row]["last"] ?? 0.0
        var tmp_str: String = String(describing: price)
        var tar_int: Int = 0
        for i in 0..<tmp_str.characters.count {
            if tmp_str[i] == "." {
                tar_int = i + 2
                break
            }
        }
        cell.pricing.text = tmp_str[0..<tar_int] + " USD"
        
        return cell
    }
    
    func parsing(data: Data){
        do {
            if let json = try JSONSerialization.jsonObject(with: data) as? [String: Any] {
                elements = []
                for i in 0..<tickerName.count {
                    let element = json[tickerName[i]] as! [String: Any]
                    elements.append(element)
                }
            }
        } catch {
            print("Error deserializing JSON: \(error)")
        }
    }
    
    func fetch(){
        Alamofire.request("https://poloniex.com/public?command=returnTicker").responseJSON { response in
            if let result = response.data {
                self.parsing(data: result)
            }
            
        }
    }
    
    @IBAction func reloadButton(_ sender: UIBarButtonItem) {
        fetch()
        priceTable.reloadData()
    }
    
}

