//
//  AutoLayoutEx03.swift
//  UIKitPratice
//
//  Created by SeokkiKwon on 11/13/23.
//

import UIKit

class AutoLayoutEx03: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        createLayout()
        // Do any additional setup after loading the view.
    }
    
    func createLayout() {
        let superView = self.view!
        
        let label = UILabel()
        label.text = "AutoLayout Example"
        label.translatesAutoresizingMaskIntoConstraints = false
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "신혜선")

        superView.addSubview(label)
        superView.addSubview(imageView)
        
        let constraints = [
            imageView.centerXAnchor.constraint(equalTo: superView.centerXAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 100),
            imageView.heightAnchor.constraint(equalToConstant: 100),
            imageView.topAnchor.constraint(equalTo: superView.topAnchor, constant: 100),
            label.centerXAnchor.constraint(equalTo: imageView.centerXAnchor),
            label.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10),
            label.widthAnchor.constraint(equalToConstant: 100)
        ]
        
        NSLayoutConstraint.activate(constraints)
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
