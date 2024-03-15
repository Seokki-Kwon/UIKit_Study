//
//  ViewController.swift
//  CameraControl
//
//  Created by SeokkiKwon on 11/24/23.
//

import UIKit
import MobileCoreServices
import UniformTypeIdentifiers

import AVKit
import AVFoundation

// UIImagePickerControllerDelegate - 이미지를 선택하고 카메라를 찍었을때의 다양한 동작을 도와줌
// UINavigationControllerDelegate - 앨범 사진을 선택했을 떄, 화면 전환을 네비게이션으로 이동
class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    //  UIImagePickerController를 통해서 카메라 장치와 사진 라이브러리에 대한 액세스를 제공
    // 앱 내에서 비디오, 사진 촬영 및 기존 앨범 미디어 데이터를 사용자에게 표시 가능
    @IBOutlet var imageView: UIImageView!
    
    // 뒷 부분에서 필요한 Boolean 속성 선언
    
    var newMedia: Bool?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    // 사진촬영
    @IBAction func useCamera(_ sender: Any) {
        // isSourceTypeAvailable 해당 장치가 카메라를 지원하는 유형인지 확인
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            let imagePicker = UIImagePickerController()
            
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerController.SourceType.camera // 이미지피커 유형을 카메라로 설정
            imagePicker.mediaTypes = [UTType.image.identifier]
            imagePicker.allowsEditing = false
            
            self.present(imagePicker, animated: true, completion: nil)
            
            newMedia = true
        }
    }
    
    // 앨범
    @IBAction func useCameraRoll(_ sender: Any) {
        // 앨범 저장 유형을 지원하는지 확인
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.savedPhotosAlbum){
            
            let imagePicker = UIImagePickerController()
            
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary // 앨범유형
            imagePicker.mediaTypes = [UTType.image.identifier]
            imagePicker.allowsEditing = false
            
            self.present(imagePicker, animated: true, completion: nil) // 화면 보여주기
            
            newMedia = false
        }
    }
    
    // 사용자 이미지가 선택되었을때
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]){
        let mediaType = info[.mediaType] as! NSString
        
        self.dismiss(animated: true, completion: nil)
        
        if mediaType.isEqual(to: UTType.image.identifier) {
            let image = info[.originalImage] as! UIImage
            // 이미지뷰에 이미질를 뛰우기
            imageView.image = image
            
            // 사진촬영인 경우
            if newMedia == true {
                UIImageWriteToSavedPhotosAlbum(image, self, #selector(ViewController.image(image: didFinishSavingWithError:contextInfo:)), nil)
            }
        }
    }
    
    @objc func image(image: UIImage, didFinishSavingWithError error: NSErrorPointer, contextInfo: UnsafeRawPointer) {
        if error != nil {
            print("error")
        }
    }
    
    // 동영상 보여주기
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let dest = segue.destination as! AVPlayerViewController
        let url = URL(string: "")
        
        if let movieURL = url {
            dest.player = AVPlayer(url: movieURL)
        }
    }
}

