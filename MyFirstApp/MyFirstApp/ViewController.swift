//
//  ViewController.swift
//  MyFirstApp
//
//  Created by 석기권 on 2024/02/08.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var myButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func buttonPressed(_ sender: UIButton) {
        mainLabel.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        
        mainLabel.text = "안녕하세요"
        mainLabel.textColor = .green
        
        mainLabel.textAlignment = .right
        
        myButton.backgroundColor = .purple
        myButton.setTitleColor(.black, for: .normal)
    }
    
}

