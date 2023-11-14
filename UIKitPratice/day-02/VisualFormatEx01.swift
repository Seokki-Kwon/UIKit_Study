//
//  VisualFormatEx01.swift
//  UIKitPratice
//
//  Created by SeokkiKwon on 11/14/23.
//

import UIKit

class VisualFormatEx01: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        createLayout()
    }
    
    func createLayout() {
        let superView = self.view!
        let imageView = UIImageView()
        imageView.image = UIImage(named: "신혜선")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        
        superView.addSubview(imageView)
        
        let viewDicts = ["imageView":imageView]
        
        var vConstraint = NSLayoutConstraint.constraints(withVisualFormat: "[imageView(200)]", metrics: nil, views: viewDicts)
        var hConstraint = NSLayoutConstraint.constraints(withVisualFormat: "[imageView(200)]", metrics: nil, views: viewDicts)
        
        let centerXConst = NSLayoutConstraint(item: imageView, attribute: .centerX, relatedBy: .equal, toItem: superView, attribute: .centerX, multiplier: 1.0, constant: 0.0)
        
        let centerYConst = NSLayoutConstraint(item: imageView, attribute: .centerY, relatedBy: .equal, toItem: superView, attribute: .centerY, multiplier: 1.0, constant: 0.0)
        superView.addConstraints(vConstraint + hConstraint + [centerXConst] + [centerYConst])
        
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
