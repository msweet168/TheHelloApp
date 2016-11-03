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
    var differenceDate = NSDate()
    
    
    @IBOutlet var helloLabel:UILabel!
    @IBOutlet var notificationToggle:UISwitch!
    @IBOutlet var dateLabel:UILabel!
    @IBOutlet var topBar:UIView!
    @IBOutlet var favoriteButton:UIButton!
    @IBOutlet var leftButton:UIButton!
    @IBOutlet var rightButton:UIButton!
    @IBOutlet var shareButton:UIButton!
    @IBOutlet var streakLabel:UILabel!
    @IBOutlet var remainingLabel:UILabel!
    
    
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
            
            UserDefaults.standard.set(false, forKey: "favorited")
            UserDefaults.standard.set(1, forKey: "streak")
            //UserDefaults.standard.set(NSDate(), forKey: "lasttime")
            
            var favArray = [""]
            UserDefaults.standard.set(favArray, forKey: "favArray")
            
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
            
            advanceArray(advances: 1)
            //advanceArray(advances: daysSinceLast(lastDate: UserDefaults.standard.object(forKey: "differenceDate") as! NSDate))
            //print("Advanced by \(daysSinceLast(lastDate: UserDefaults.standard.object(forKey: "differenceDate") as! NSDate))")
            
            UserDefaults.standard.set(todaysDate, forKey: "saveDate")
            UserDefaults.standard.set(NSDate(), forKey: "differenceDate")
            print("Next day, advanceing array...")
            UserDefaults.standard.set(false, forKey: "favorited")
            
            advanceStreak()
            
        }
        
        
        if UserDefaults.standard.bool(forKey: "favorited") {
            disableFavoriteButton()
        }
        
        helloLabel.text = "\"\(theArray[0])\""
        remainingLabel.text = "Remaining Quotes: \(theArray.count)"
        streakLabel.text = "Quotes viewed: \(UserDefaults.standard.integer(forKey: "streak"))"
        
        let randomColor: [UIColor] = [.redCode1, .liGreenCode1, .liPurpleCode1, .yellowCode1, .tealCode, .darkTealCode1, .pinkCode, .liYellowCode1]
        let randomNumber = Int(arc4random_uniform(8))
        helloLabel.textColor = randomColor[randomNumber]
        
    }
    
    
    
    func getArchived() -> [String]{
        return UserDefaults.standard.array(forKey: "archiveArray") as! [String]
    }
    
    func advanceArray(advances: Int) {
        theArray.remove(at: 0)
        UserDefaults.standard.set(theArray, forKey: "saveArray")
    }
    
    func addFavorite(quote: String) {
        var favArray = UserDefaults.standard.array(forKey: "favArray")
        favArray?.insert(quote, at: 0)
        UserDefaults.standard.set(favArray, forKey: "favArray")
        
    }
    
    func disableFavoriteButton() {
        favoriteButton.isEnabled = false
        favoriteButton.setTitle("Favorited", for: .normal)
        favoriteButton.layer.borderColor = UIColor.green.cgColor
        favoriteButton.layer.borderWidth = 1
        UserDefaults.standard.set(true, forKey: "favorited")
    }
    
    func undoFavorite() {
        favoriteButton.isEnabled = true
        favoriteButton.setTitle("Favorite", for: .normal)
        favoriteButton.layer.borderColor = nil
        favoriteButton.layer.borderWidth = 0
        UserDefaults.standard.set(false, forKey: "favorited")
    }
    
    func shareQuote(quote: String) {
        let textToShare = quote
        
            let objectsToShare = [textToShare] as [Any]
            let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
            
            activityVC.excludedActivityTypes = [UIActivityType.airDrop, UIActivityType.addToReadingList]
            
            activityVC.popoverPresentationController?.sourceView = shareButton
            self.present(activityVC, animated: true, completion: nil)
    }
    
    func advanceStreak() {
        print("Streak Advnaced")
        
        var currentStreak = UserDefaults.standard.integer(forKey: "streak")
        currentStreak+=1;
        UserDefaults.standard.set(currentStreak, forKey: "streak")
    
        
    }
    
    func daysSinceLast(lastDate: NSDate) -> Int {
        let calendar = NSCalendar.current
        
        let date1 = calendar.startOfDay(for: lastDate as Date)
        let date2 = calendar.startOfDay(for: NSDate() as Date)
        
        let diff = calendar.dateComponents([.day], from: date1, to: date2)
        
        return diff.day!;
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func goFavorites(sender:AnyObject) {
        self.performSegue(withIdentifier: "goFavs", sender: self)
    }
    
    @IBAction func favoriteButton(sender:AnyObject) {
        
        if let currentQuote = helloLabel.text {
            addFavorite(quote: currentQuote)
            disableFavoriteButton()
            
            let alert = UIAlertController(title: "Favorited", message: "Quote was added to favorites.", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
            alert.addAction(defaultAction)
            let undoAction = UIAlertAction(title: "Undo", style: .destructive, handler: {(alert: UIAlertAction!) in self.undoFavorite()})
            alert.addAction(undoAction)
            
            present(alert, animated: true, completion: nil)
        }
        else
        {
            let alert = UIAlertController(title: "Error", message: "The quote could not be added to favorites.", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "Dismiss", style: .cancel, handler: nil)
            alert.addAction(defaultAction)
            present(alert, animated: true, completion: nil)
        }
        
    }
    
    @IBAction func share(sender:AnyObject) {
        if let currentQuote = helloLabel.text {
            shareQuote(quote: currentQuote)
        }
    }


}
