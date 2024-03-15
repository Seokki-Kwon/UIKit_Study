//
//  StoryBoard.swift
//  UIKitPratice
//
//  Created by SeokkiKwon on 11/15/23.
//

import UIKit

class StoryBoard: UIViewController {
    var imgPic1: UIImage?
    var imgPic2: UIImage?
    var imgViewSize: CGSize?
    var isFirstPic = false
    
    @IBOutlet var imgView: UIImageView!
    // strong / weak
    // 메모리 회수 정책
    // strong: 선언된 변수 다른 곳에서 참조하고 있으면 제거되지 않고 유지
    // weak: 선언된 변수를 다른곳에서 참조하더라도 시스템에서 임의적으로 제거
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 뷰가 초기화될때 미리 이미를 담아두면 미리 이미지 데이터를 로드할 수 있다
        imgPic1 = UIImage(named: "신혜선")
        imgPic2 = UIImage(named: "신혜선3")
        imgViewSize = CGSize(width: imgView.frame.width, height: imgView.frame.height)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnChangeImg(_ sender: Any) {
        if isFirstPic {
            imgView.image = imgPic1
        } else {
            imgView.image = imgPic2
        }
        isFirstPic.toggle()
    }
    
    @IBAction func switchingSize(_ sender: UISwitch) {
        if sender.isOn {
            imgView.frame.size = CGSize(width: imgView.frame.width / 2.0, height: imgView.frame.height / 2.0)
        } else {
            imgView.frame.size = CGSize(width: imgView.frame.width * 2.0, height: imgView.frame.height * 2.0)
        }
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
