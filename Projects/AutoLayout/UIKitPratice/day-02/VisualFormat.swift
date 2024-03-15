//
//  VisualFormat.swift
//  UIKitPratice
//
//  Created by SeokkiKwon on 11/14/23.
//

import UIKit

class VisualFormat: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        createLayout()
    }
    
    func createLayout() {
        let superView = self.view!
        
        let myLabel = UILabel()
        myLabel.text = "My Label"
        myLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let myButton = UIButton()
        myButton.setTitle("My Button", for: .normal)
        myButton.backgroundColor = .blue
        myButton.translatesAutoresizingMaskIntoConstraints = false
        
        superView.addSubview(myButton)
        superView.addSubview(myLabel)
        // string 포맷형식으로 제약조건을 설정할 수 있다.
        let viewDict = ["myLabel": myLabel, "myButton":myButton]
        // 수직 제약조건 생성 및 추가
        let constraint = NSLayoutConstraint.constraints(withVisualFormat: "V:|-[myButton]-|", metrics: nil, views: viewDict)
        
        // 수평 제약 조건 생성 및 추가
        // viewDict의 값을 참조해서 레이아웃을 맞춘다.
        let btnAndlabelConst = NSLayoutConstraint.constraints(withVisualFormat: "|-[myButton]-[myLable(==myButton)]-|", options: NSLayoutConstraint.FormatOptions.alignAllLastBaseline, metrics: nil, views: viewDict)
        superView.addConstraints(constraint + btnAndlabelConst)
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
