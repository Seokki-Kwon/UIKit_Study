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
    
    @IBAction func useCamera(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            let imagePicker = UIImagePickerController()
            
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerController.SourceType.camera
            imagePicker.mediaTypes = [UTType.image.identifier]
            imagePicker.allowsEditing = false
            
            self.present(imagePicker, animated: true, completion: nil)
            
            newMedia = true
        }
    }
    
    @IBAction func useCameraRoll(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.savedPhotosAlbum){
            let imagePicker = UIImagePickerController()
            
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
            imagePicker.mediaTypes = [UTType.image.identifier]
            imagePicker.allowsEditing = false
            
            self.present(imagePicker, animated: true, completion: nil)
            
            newMedia = false
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]){
        let mediaType = info[.mediaType] as! NSString
        
        self.dismiss(animated: true, completion: nil)
        
        if mediaType.isEqual(to: UTType.image.identifier) {
            let image = info[.originalImage] as! UIImage
            
            imageView.image = image
            
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let dest = segue.destination as! AVPlayerViewController
        let url = URL(string: "")
        
        if let movieURL = url {
            dest.player = AVPlayer(url: movieURL)
        }
    }
}

