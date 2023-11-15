//
//  VisualFormatEx02.swift
//  UIKitPratice
//
//  Created by SeokkiKwon on 11/14/23.
//

import UIKit

class VisualFormatEx02: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let superView = self.view!
        
        let leftView = UIView()
        leftView.backgroundColor = .red
        leftView.translatesAutoresizingMaskIntoConstraints = false
        
        let rightView = UIView()
        rightView.backgroundColor = .green
        rightView.translatesAutoresizingMaskIntoConstraints = false
        
        superView.addSubview(leftView)
        superView.addSubview(rightView)
        
        let viewsDict = ["leftView": leftView, "rightView":rightView]
        
        let vRightConstraint = NSLayoutConstraint.constraints(withVisualFormat: "V:[rightView(50)]", metrics: nil, views: viewsDict)
        
        let vConstraint = NSLayoutConstraint.constraints(withVisualFormat: "V:[leftView(50)]", metrics: nil, views: viewsDict)
        let hConstraint = NSLayoutConstraint.constraints(withVisualFormat: "|-[leftView(200)]-[rightView(100)]-|", metrics: nil, views: viewsDict)
        
        NSLayoutConstraint.activate(vRightConstraint + vConstraint + hConstraint)
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
