//
//  ViewController.swift
//  NavigationControll
//
//  Created by SeokkiKwon on 11/15/23.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    // 장면 간 데이터 전달
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        let dest = segue.destination as! Scene2ViewController
        dest.labelText = "첫 화면에서 값을 보냄!!"
    }
    
    // 두번째 장면이 종료되었을때 실행 되도록 연결
    @IBAction func returnedValue(segue: UIStoryboardSegue) {
        print(1)
    }
}

