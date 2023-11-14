//
//  AutoLayoutEx05.swift
//  UIKitPratice
//
//  Created by SeokkiKwon on 11/13/23.
//

import UIKit

class AutoLayoutEx05: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        createLayout()
    }
    
    func createLayout() {
        let superView = self.view
        
        let redView = UIView()
        let greenView = UIView()
        
        redView.translatesAutoresizingMaskIntoConstraints = false
        greenView.translatesAutoresizingMaskIntoConstraints = false
      
        redView.backgroundColor = .red
        greenView.backgroundColor = .green
        
      
        superView?.addSubview(redView)
        superView?.addSubview(greenView)
        let constraint = [
            redView.topAnchor.constraint(equalTo: superView!.topAnchor),
            redView.leadingAnchor.constraint(equalTo: superView!.leadingAnchor),
            redView.heightAnchor.constraint(equalTo: superView!.heightAnchor, multiplier: 1/3),
            redView.widthAnchor.constraint(equalTo: superView!.widthAnchor, multiplier: 1/2),
            
            greenView.topAnchor.constraint(equalTo: superView!.topAnchor),
            greenView.leadingAnchor.constraint(equalTo: redView.trailingAnchor),
            
            // redView의 witdh, height를 기준으로 레이아웃을 설정
            greenView.heightAnchor.constraint(equalTo: redView.heightAnchor),
            greenView.trailingAnchor.constraint(equalTo: superView!.trailingAnchor)
//            greenView.widthAnchor.constraint(equalTo: superView!.widthAnchor, multiplier: 1/2)
            
        ]
        NSLayoutConstraint.activate(constraint)
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
