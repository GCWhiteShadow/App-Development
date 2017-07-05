//
//  FirstViewController.swift
//  Miner Info
//
//  Created by GCWhiteShadow on 2017/6/26.
//  Copyright © 2017年 GCWhiteShadow. All rights reserved.
//

import UIKit
import CoreData
import Alamofire
import Kanna

class FirstViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var statusTable: UITableView!
    
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
    
    var name_arr = ["Total Speed", "Total Shares", "Rejected", "Run Time", "GPU 0", "GPU 1", "GPU 2", "Incorrect Shares"]
    var detail_arr = ["","","","","","","",""]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.statusTable.delegate = self
        self.statusTable.dataSource = self
        
        fetch()
        statusTable.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return name_arr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = statusTable.dequeueReusableCell(withIdentifier: "statusCell", for: indexPath) as! statusCell
        cell.labelText.text = name_arr[indexPath.row]
        cell.detailLabelText.text = detail_arr[indexPath.row]
        
        return cell
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
        
        detail_arr = [totalSpeed, totalShares, rejected, runTime, GPU0speed, GPU1speed, GPU2speed, incorrectShares]
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
        
        GPU0speed = arr[0] == "off" ? arr[0] : arr[0] + " Mh/s"
        GPU1speed = arr[1] == "off" ? arr[1] : arr[1] + " Mh/s"
        GPU2speed = arr[2] == "off" ? arr[2] : arr[2] + " Mh/s"
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
    
    func getContext () -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    func getTranscriptions () -> String{
        //create a fetch request, telling it about the entity
        let fetchRequest: NSFetchRequest<Entity> = Entity.fetchRequest()
        
        do {
            //go get the results
            let searchResults = try getContext().fetch(fetchRequest)
            print(searchResults.count)
            return searchResults[searchResults.count - 1].addr ?? ""
        } catch {
            return ""
        }
    }
    
    func fetch(){
        //print("fetch")
        let url = getTranscriptions()
        if url == "" {
            return
        }
        Alamofire.request(url).responseJSON { response in
            
            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                self.parseHTML(html: utf8Text)
                self.parsingText()
                self.printAll()
            }
        }
        
    }
    
    @IBAction func reload(_ sender: UIBarButtonItem) {
        //print("reload")
        fetch()
        statusTable.reloadData()
    }
    
}

