//
//  ViewController.swift
//  Hello
//
//  Created by Mitchell Sweet on 10/19/16.
//  Copyright © 2016 Mitchell Sweet. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let helloString = try! String(contentsOfFile:
        Bundle.main.path(forResource: "Hello", ofType: "txt")!)
    var helloArray = [String]()
    var theArray = [String]()
    var todaysDate = String()
    
    @IBOutlet var theLabel:UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let date = NSDate()
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        todaysDate = formatter.string(from: date as Date)
        print(todaysDate)
        
        initArray()
        
    }
    
    
    func initArray() {
        
        if let savedArray = UserDefaults.standard.array(forKey: "saveArray") {
            print("Not first launch, pulling array...")
            
            theArray = savedArray as! [String]
            
        }
        else {
            print("First launch, shuffleing array...")
            
            helloArray = helloString.components(separatedBy: "\n")
            helloArray.remove(at: 0)
            helloArray.removeSubrange(helloArray.count-2..<helloArray.count)
            
            
            var helloShuffle = [String]()
            
            while helloArray.count > 0 {
                let randomIndex = arc4random_uniform(UInt32(helloArray.count))
                helloShuffle.append(helloArray.remove(at: Int(randomIndex)))
                
            }
            
            UserDefaults.standard.set(helloShuffle, forKey: "archiveArray")
            UserDefaults.standard.set(helloShuffle, forKey: "saveArray")
            theArray = helloShuffle
            print(helloShuffle)
            
            UserDefaults.standard.set(todaysDate, forKey: "saveDate")
        }
        
        
        showHello()
        
    }
    
    func showHello() {
        
    
        if UserDefaults.standard.string(forKey: "saveDate")! != todaysDate{
            advanceArray()
            UserDefaults.standard.set(todaysDate, forKey: "saveDate")
            print("Next day, advanceing array...")
        }
        
        theLabel.text = theArray[0]
        
        
    }
    
    func getArchived() -> [String]{
        return UserDefaults.standard.array(forKey: "archiveArray") as! [String]
    }
    
    func advanceArray() {
        theArray.remove(at: 0)
        UserDefaults.standard.set(theArray, forKey: "saveArray")
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

