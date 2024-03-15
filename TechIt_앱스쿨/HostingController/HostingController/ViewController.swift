//
//  ViewController.swift
//  HostingController
//
//  Created by SeokkiKwon on 11/20/23.
//

import UIKit
import SwiftUI

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // SwiftUI 전용뷰로 띄우는 방법
        // 컨테이너를 이용하는 방법
        // 코드를 이용하는 방법
        
        let swiftUIController = UIHostingController(rootView: SwiftUIView(text: "Integration One"))
        
        // addChild는 컨트롤 관리
        addChild(swiftUIController)
        swiftUIController.view.translatesAutoresizingMaskIntoConstraints = false
        
        // 뷰 관리
        self.view.addSubview(swiftUIController.view)
        
        swiftUIController.view.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        swiftUIController.view.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }

    @IBSegueAction func showSwiftUIView(_ coder: NSCoder) -> UIViewController? {
        return UIHostingController(coder: coder, rootView: SwiftUIView(text: "Integration One"))
    }
    
    
    @IBSegueAction func embedSwiftUIView(_ coder: NSCoder) -> UIViewController? {
        return UIHostingController(coder: coder, rootView: SwiftUIView(text: "Integration Two"))
    }
}

