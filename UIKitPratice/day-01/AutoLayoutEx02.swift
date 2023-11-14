//
//  AutoLayoutEx02.swift
//  UIKitPratice
//
//  Created by SeokkiKwon on 11/13/23.
//

import UIKit

class AutoLayoutEx02: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let superView = self.view
        
        let helloLabel = UILabel()
        let worldLabel = UILabel()
        helloLabel.text = "Hello"
        worldLabel.text = "World"
        
        helloLabel.translatesAutoresizingMaskIntoConstraints = false
        worldLabel.translatesAutoresizingMaskIntoConstraints = false
        
        superView?.addSubview(helloLabel)
        superView?.addSubview(worldLabel)
        
        var myConstraint =
        NSLayoutConstraint(item: helloLabel, attribute: .top, relatedBy: .equal, toItem: superView, attribute: .top, multiplier: 1.0, constant: 100)
        superView?.addConstraint(myConstraint)
        myConstraint =
        NSLayoutConstraint(item: helloLabel, attribute: .centerX, relatedBy: .equal, toItem: superView, attribute: .centerX, multiplier: 1.0, constant: 0)
        superView?.addConstraint(myConstraint)
        
        var myConstraint2 =
        NSLayoutConstraint(item: worldLabel, attribute: .leading, relatedBy: .equal, toItem: helloLabel, attribute: .trailing, multiplier: 1.0, constant: 20)
        superView?.addConstraint(myConstraint2)
        
        myConstraint2 =
        NSLayoutConstraint(item: worldLabel, attribute: .firstBaseline, relatedBy: .equal, toItem: helloLabel, attribute: .firstBaseline, multiplier: 1.0, constant: 0)
        superView?.addConstraint(myConstraint2)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
