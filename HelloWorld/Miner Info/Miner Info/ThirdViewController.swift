//
//  ThirdViewController.swift
//  Miner Info
//
//  Created by GCWhiteShadow on 2017/6/26.
//  Copyright © 2017年 GCWhiteShadow. All rights reserved.
//

import UIKit
import CoreData

class ThirdViewController: UIViewController {
    
    @IBOutlet weak var inputText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        inputText.text = getTranscriptions()
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ThirdViewController.dismissKeyboard))
        
        view.addGestureRecognizer(tap)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    func getContext () -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    func storeTranscription (URL: String) {
        let context = getContext()
        
        //retrieve the entity that we just created
        let entity =  NSEntityDescription.entity(forEntityName: "Entity", in: context)
        
        let transc = NSManagedObject(entity: entity!, insertInto: context)
        
        //set the entity values
        transc.setValue(URL, forKey: "addr")
        
        //save the object
        do {
            try context.save()
            print("saved!")
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        } catch {
            
        }
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
    
    @IBAction func saveButton(_ sender: UIButton) {
        storeTranscription(URL: inputText.text ?? "0.0.0.0")
    }
    
    @IBAction func clearData(_ sender: UIBarButtonItem) {
        let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Entity")
        let request = NSBatchDeleteRequest(fetchRequest: fetch)
        
        do {
            _ = try getContext().execute(request)
        } catch {
            fatalError("Failed to execute request: \(error)")
        }
        
        inputText.text = ""
        
        let context = getContext()
        
        //retrieve the entity that we just created
        let entity =  NSEntityDescription.entity(forEntityName: "Entity", in: context)
        
        let transc = NSManagedObject(entity: entity!, insertInto: context)
        
        //set the entity values
        transc.setValue("", forKey: "addr")
        
        //save the object
        do {
            try context.save()
            print("saved!")
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        }
    }
}
