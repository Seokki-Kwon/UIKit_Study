//
//  AutoLayoutEx01.swift
//  UIKitPratice
//
//  Created by SeokkiKwon on 11/13/23.
//

import UIKit

class AutoLayoutEx01: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        createLayout()
        // Do any additional setup after loading the view.
    }
    
    func createLayout() {
        let superView = self.view
        
        let helloLabel = UILabel()
        let worldLabel = UILabel()
        helloLabel.text = "Hello"
        worldLabel.text = "World"
        helloLabel.translatesAutoresizingMaskIntoConstraints = false
        worldLabel.translatesAutoresizingMaskIntoConstraints = false
        
        superView?.addSubview(helloLabel)
        superView?.addSubview(worldLabel)
        
        let constaints = [
            helloLabel.centerYAnchor.constraint(equalTo: superView!.centerYAnchor),
            helloLabel.leadingAnchor.constraint(equalTo: superView!.leadingAnchor, constant: 20),
            worldLabel.firstBaselineAnchor.constraint(equalTo: helloLabel.firstBaselineAnchor, constant: 0),
            worldLabel.leadingAnchor.constraint(equalTo: helloLabel.trailingAnchor, constant: 20)
        ]
        
        superView?.addConstraints(constaints)
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
