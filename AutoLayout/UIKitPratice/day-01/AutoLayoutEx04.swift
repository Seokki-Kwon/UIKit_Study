//
//  AutoLayoutEx04.swift
//  UIKitPratice
//
//  Created by SeokkiKwon on 11/13/23.
//

import UIKit

class AutoLayoutEx04: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        createLayout()
        // Do any additional setup after loading the view.
    }
    
    func createLayout() {
        let superview = self.view!

                let button = UIButton()
                button.setTitle("Tap Me", for: .normal)
                button.backgroundColor = .blue
                button.setTitleColor(.white, for: .normal)
                button.translatesAutoresizingMaskIntoConstraints = false
                view.addSubview(button)

                let constraints = [
                    button.bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: -50),
                    button.leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: 20),
                    button.trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: -20)
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
