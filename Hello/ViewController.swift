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
    
    @IBOutlet var theLabel:UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        helloArray = helloString.components(separatedBy: "\n")
        helloArray.remove(at: 0)
        
        initArray()
        
    }
    
    
    func initArray() {
        
        if let savedArray = UserDefaults.standard.array(forKey: "array1") {
            print("Not first launch, pulling array...")
            
            theArray = savedArray as! [String]
            
        }
        else {
            print("First launch, shuffleing array...")
            
            var helloShuffle = [String]()
            
            while helloArray.count > 0 {
                let randomIndex = arc4random_uniform(UInt32(helloArray.count))
                helloShuffle.append(helloArray.remove(at: Int(randomIndex)))
                
            }
            
            UserDefaults.standard.set(helloShuffle, forKey: "array1")
            theArray = helloShuffle
            
        }
        
        
        showHello()
        
    }
    
    func showHello() {
        
        theLabel.text = theArray[0]
        theArray.remove(at: 0)
        UserDefaults.standard.set(theArray, forKey: "array1")
        
        
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }



}

