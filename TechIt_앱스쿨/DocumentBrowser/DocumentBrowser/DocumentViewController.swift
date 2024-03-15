//
//  DocumentViewController.swift
//  DocumentBrowser
//
//  Created by SeokkiKwon on 11/21/23.
//

import UIKit

class DocumentViewController: UIViewController {

    @IBOutlet weak var documentNameLabel: UILabel!
    @IBOutlet var documentText: UITextView!
    
    var document: Document?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // 문서를. 열기
        document?.open(completionHandler: { (success) in
            if success {
                //documentNameLabel를 현재파일명으로
                self.documentNameLabel.text = self.document?.fileURL.lastPathComponent
                self.documentText.text = self.document?.userText
            } else {
                
            }
        })
    }

    @IBAction func dismissDocumentViewController() {
        dismiss(animated: true)
    }
    
    @IBAction func saveFile(_ sender: Any) {
        document?.userText = documentText.text
        
        if let url = document?.fileURL {
            document?.save(to: url, for: .forOverwriting, completionHandler: { success in
                if success {
                    print("s")
                } else {
                    print("e")
                }
            })
        }
    }
}
