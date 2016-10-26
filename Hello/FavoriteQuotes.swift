//
//  FavoriteQuotes.swift
//  Hello
//
//  Created by Mitchell Sweet on 10/26/16.
//  Copyright © 2016 Mitchell Sweet. All rights reserved.
//

import UIKit

class FavoriteQuotes: UIViewController {
    
    @IBOutlet var headerBar:UIView!
    @IBOutlet var leftButton2:UIButton!
    @IBOutlet var rightButton2:UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewSetup()
        
    }
    
    func viewSetup() {
        self.headerBar.backgroundColor = UIColor(red: 216/255, green: 216/255, blue: 216/255, alpha: 0.3)
        rightButton2.layer.borderColor = UIColor.black.cgColor
        rightButton2.layer.borderWidth = 2

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func goToday(sender:AnyObject) {
        dismiss(animated: false, completion: nil)
    }
}
