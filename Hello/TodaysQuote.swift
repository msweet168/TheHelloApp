//
//  TodaysQuote.swift
//  Hello
//
//  Created by Mitchell Sweet on 10/25/16.
//  Copyright © 2016 Mitchell Sweet. All rights reserved.
//

import UIKit

extension UIColor {
    class var redCode1: UIColor {
        return UIColor(red: 0/255, green: 122/255, blue: 255/255, alpha: 1)
    }
    class var liGreenCode1: UIColor {
        return #colorLiteral(red: 0.6745098039, green: 0.9450980392, blue: 0.6235294118, alpha: 1)
    }
    class var liPurpleCode1: UIColor {
        return #colorLiteral(red: 0.7803921569, green: 0.7921568627, blue: 0.9098039216, alpha: 1)
    }
    class var yellowCode1: UIColor {
        return #colorLiteral(red: 0.9568627451, green: 0.8235294118, blue: 0.4588235294, alpha: 1)
    }
    class var tealCode1: UIColor {
        return #colorLiteral(red: 0.4235294118, green: 0.7098039216, blue: 0.6862745098, alpha: 1)
    }
    class var darkTealCode1: UIColor {
        return #colorLiteral(red: 0.3137254902, green: 0.5647058824, blue: 0.7529411765, alpha: 1)
    }
    class var pinkCode1: UIColor {
        return #colorLiteral(red: 0.8588235294, green: 0.3725490196, blue: 0.5764705882, alpha: 1)
    }
    class var liYellowCode1: UIColor {
        return #colorLiteral(red: 0.937254902, green: 0.9725490196, blue: 0.6784313725, alpha: 1)
    }
}

class TodaysQuote: UIViewController {
    
    let helloString = try! String(contentsOfFile:
        Bundle.main.path(forResource: "Hello", ofType: "txt")!)
    var helloArray = [String]()
    var theArray = [String]()
    var todaysDate = String()
    
    
    @IBOutlet var helloLabel:UILabel!
    @IBOutlet var notificationToggle:UISwitch!
    @IBOutlet var dateLabel:UILabel!
    @IBOutlet var topBar:UIView!
    @IBOutlet var favoriteButton:UIButton!
    @IBOutlet var leftButton:UIButton!
    @IBOutlet var rightButton:UIButton!
    @IBOutlet var shareButton:UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        
        let date = NSDate()
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        todaysDate = formatter.string(from: date as Date)
        print(todaysDate)
        
        viewSetup()
        initArray()
        
    }
    
    func viewSetup() {
        self.topBar.backgroundColor = UIColor(red: 216/255, green: 216/255, blue: 216/255, alpha: 0.3)
        leftButton.layer.borderColor = UIColor.black.cgColor
        leftButton.layer.borderWidth = 2
        dateLabel.text = "Your Hello Quote for \(todaysDate)"
        
        /*
        leftButton.titleLabel?.numberOfLines = 1
        leftButton.titleLabel?.adjustsFontSizeToFitWidth = true
        leftButton.titleLabel?.lineBreakMode = NSLineBreakMode.byClipping
        
        rightButton.titleLabel?.numberOfLines = 1
        rightButton.titleLabel?.adjustsFontSizeToFitWidth = true
        rightButton.titleLabel?.lineBreakMode = NSLineBreakMode.byClipping
        */
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
            helloArray = helloArray.filter { $0 != "Hello Sarah, hello Kate, hello Patricia, hello Izzy, hello Camille, hello Anastasia, hello Vicky, hello Gigi, hello soul mate." }
            
            
            
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
            
            Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(go), userInfo: nil, repeats: false)
            
        }
        
        showHello1()
        
    }
    
    func go() {
        self.performSegue(withIdentifier: "goToIntro", sender: self)
        
    }
    
    
    func showHello1() {
        
        
        if UserDefaults.standard.string(forKey: "saveDate")! != todaysDate{
            advanceArray()
            UserDefaults.standard.set(todaysDate, forKey: "saveDate")
            print("Next day, advanceing array...")
        }
        
        helloLabel.text = "\"\(theArray[0])\""
        
        let randomColor: [UIColor] = [.redCode1, .liGreenCode1, .liPurpleCode1, .yellowCode1, .tealCode, .darkTealCode1, .pinkCode, .liYellowCode1]
        let randomNumber = Int(arc4random_uniform(8))
        helloLabel.textColor = randomColor[randomNumber]
        
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
    
    @IBAction func goFavorites(sender:AnyObject) {
        self.performSegue(withIdentifier: "goFavs", sender: self)
    }

}
