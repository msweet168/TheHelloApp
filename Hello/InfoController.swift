//
//  InfoController.swift
//  Hello
//
//  Created by Mitchell Sweet on 10/22/16.
//  Copyright © 2016 Mitchell Sweet. All rights reserved.
//

import UIKit

class InfoController: UIViewController {
    
    @IBOutlet var versionLabel:UILabel!
    @IBOutlet var developerLabel:UILabel!
    @IBOutlet var websiteLabel:UILabel!
    
    
    var stringToColor1 = "let"
    var stringToColor2 = "1.0"
    var stringToColor3 = "\"Mitchell Sweet\""
    var stringToColor4 = "\"sweetdevelop.com\""
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        changeColors()
        
    }
    
    func changeColors() {
        
        let range = (versionLabel.text! as NSString).range(of: stringToColor1)
        let range11 = (versionLabel.text! as NSString).range(of: stringToColor1)
        let range111 = (versionLabel.text! as NSString).range(of: stringToColor1)
        
        let range2 = (versionLabel.text! as NSString).range(of: stringToColor2)
        
        let range3 = (developerLabel.text! as NSString).range(of: stringToColor3)
        
        let range4 = (websiteLabel.text! as NSString).range(of: stringToColor4)
        
        
        let attributedText = NSMutableAttributedString.init(string: versionLabel.text!)
        attributedText.addAttribute(NSForegroundColorAttributeName, value: #colorLiteral(red: 0.7333333333, green: 0.07450980392, blue: 0.4823529412, alpha: 1) , range: range)
        attributedText.addAttribute(NSForegroundColorAttributeName, value: #colorLiteral(red: 0.4999950528, green: 0.4843581319, blue: 0.7445307374, alpha: 1) , range: range2)
        
        let attributedText2 = NSMutableAttributedString.init(string: developerLabel.text!)
        attributedText2.addAttribute(NSForegroundColorAttributeName, value: #colorLiteral(red: 0.7333333333, green: 0.07450980392, blue: 0.4823529412, alpha: 1) , range: range11)
        attributedText2.addAttribute(NSForegroundColorAttributeName, value: UIColor.red , range: range3)
        
        let attributedText3 = NSMutableAttributedString.init(string: websiteLabel.text!)
        attributedText3.addAttribute(NSForegroundColorAttributeName, value: #colorLiteral(red: 0.7333333333, green: 0.07450980392, blue: 0.4823529412, alpha: 1) , range: range111)
        attributedText3.addAttribute(NSForegroundColorAttributeName, value: UIColor.red , range: range4)
        
        versionLabel.attributedText = attributedText
        developerLabel.attributedText = attributedText2
        websiteLabel.attributedText = attributedText3
        

    }
    
    
    @IBAction func back(sender:AnyObject) {
        goBack()
    }
    
    func goBack() {
        dismiss(animated: true, completion: nil)
        
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
