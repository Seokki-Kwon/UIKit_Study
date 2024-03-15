//
//  Scene2ViewController.swift
//  NavigationControll
//
//  Created by SeokkiKwon on 11/15/23.
//

import UIKit

class Scene2ViewController: UIViewController {
    // 두 번째 장면의 레이블
    @IBOutlet var sceneLabel: UILabel!
    // 장면 간 데이터 전달
    var labelText: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sceneLabel.text = labelText
        // Do any additional setup after loading the view.
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
