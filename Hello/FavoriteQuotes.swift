//
//  FavoriteQuotes.swift
//  Hello
//
//  Created by Mitchell Sweet on 10/26/16.
//  Copyright © 2016 Mitchell Sweet. All rights reserved.
//

import UIKit

class FavoriteQuotes: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var headerBar:UIView!
    @IBOutlet var leftButton2:UIButton!
    @IBOutlet var rightButton2:UIButton!
    @IBOutlet var tableView:UITableView!
    
    
    var favArray = [""]
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        favArray = UserDefaults.standard.array(forKey: "favArray") as! [String]
        
        print(favArray)
        
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "favCell")
        
        viewSetup()
        
    }
    
    
    func viewSetup() {
        self.headerBar.backgroundColor = UIColor(red: 216/255, green: 216/255, blue: 216/255, alpha: 0.3)
        rightButton2.layer.borderColor = UIColor.black.cgColor
        rightButton2.layer.borderWidth = 2

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.favArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell:UITableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "favCell")! as UITableViewCell
        
        cell.textLabel?.text = self.favArray[indexPath.row]
        cell.textLabel?.textColor = UIColor.white
        cell.textLabel?.font = UIFont (name: "Menlo-Regular", size: 17)
        cell.backgroundColor = UIColor.clear
        cell.textLabel?.numberOfLines = 0
        
        if favArray == [] {
            cell.textLabel?.text = "You have no favorites."
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        
        let textToShare = self.favArray[indexPath.row]
        
        let objectsToShare = [textToShare] as [Any]
        let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
        
        activityVC.excludedActivityTypes = [UIActivityType.airDrop, UIActivityType.addToReadingList]
        
        activityVC.popoverPresentationController?.sourceView = tableView
        self.present(activityVC, animated: true, completion: nil)

        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete {
            favArray.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
            
            UserDefaults.standard.set(favArray, forKey: "favArray")
            
            print("Favorites have been edited. Here is the new array of favorites: \(favArray)")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func goToday(sender:AnyObject) {
        dismiss(animated: false, completion: nil)
    }
}
