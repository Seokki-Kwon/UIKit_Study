//
//  ViewController.swift
//  TextFieldProject
//
//  Created by 권석기 on 3/13/24.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textField.delegate = self
        
        setup()
    }
    
    func setup() {
        view.backgroundColor = .gray
        textField.keyboardType = .emailAddress
        textField.placeholder = "이메일 입력"
        textField.clearButtonMode = .always
        textField.returnKeyType = .next
        
        // UIWindow(터치, 화면의 입력을 받아들이는 객체) => 화면
        // textField가 응답객체가 된다.
        textField.becomeFirstResponder()
    }
    
    // 텍스트필드의 입력을 시작할때 호출(시작할지 말지의 여부 허락하는것)
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        print(#function)
        return true
    }
    
    // 시점 -
    func textFieldDidBeginEditing(_ textField: UITextField) {
        // 애니메이션같은 추가적인 동작 구현가능
        print(#function)
    }
    
    // 텍스트를 비우는 동작을 허락여부
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        print(#function)
        return true
    }
    
    // 텍스트필드의 실제 입력이 끝날을때 호출(시점)
    func textFieldDidEndEditing(_ textField: UITextField) {
        print(#function)
    }
    
    // 텍스트필드의 글자가 입력될때마다 지워질떄 호출
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let maxLength = 10
        let currentString: NSString = (textField.text ?? "") as NSString
        let newString: NSString = currentString.replacingCharacters(in: range, with: string) as NSString
        return newString.length <= maxLength
    }

    // 텍스트필드의 엔터키가 눌러지면 다음동작을 허락할지 여부
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        print(#function)
//        return true
        if textField.text == "" {
            textField.placeholder = "Type Something!"
            return false
        } else {
            return true
        }
    }
    
    // 텍스트필드의 입력이 끝날때 호출 (끝날지 말지)
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        print(#function)
        return true
    }
    
    @IBAction func doneButtonTapped(_ sender: UIButton) {
        textField.resignFirstResponder()
    }
    
    // 뷰컨에 있는 화면의 탭을 감지하는 메서드
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true) // 뷰전체의 응답을 끝낸다(?)
    }
    
}

