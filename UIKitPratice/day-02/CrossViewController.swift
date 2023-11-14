//
//  CrossViewController.swift
//  UIKitPratice
//
//  Created by SeokkiKwon on 11/14/23.
//

import UIKit

class CrossViewController: UIViewController {
    @IBOutlet weak var myLabel: UILabel!
    @IBOutlet weak var myButton: UIButton!
    @IBOutlet weak var viewB: UIView!
    @IBOutlet weak var centerConstration: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // 기존 제약 조건을 제거
        viewB.removeConstraint(centerConstration) // viewB 내부의 center 제약조건 제거
        
        // 교차 계층 제약 조건 추가
        myLabel.trailingAnchor.constraint(equalTo: myButton.trailingAnchor).isActive = true
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
