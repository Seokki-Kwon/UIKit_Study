//
//  ViewController.swift
//  Filemanager
//
//  Created by SeokkiKwon on 11/20/23.
//

import UIKit

class ViewController: UIViewController {
    let fileManager = FileManager.default
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
//        ex_01()
//        ex_02()
//        ex_03()
//        ex_04()
          ex_05()
    }
    
    // 디렉토리 및 파일 예제 01
    // <현재 디렉토리>에 있는 모든 파일의 이름과 크기를 출력하는 코드를 작성해보세요.
    func ex_01() {
        let currentPath = fileManager.currentDirectoryPath
        do {
            let files = try fileManager.contentsOfDirectory(atPath: currentPath)
            for file in files.sorted() {
                let filePath = currentPath + "/" + file
                if let attribs: NSDictionary = try? fileManager.attributesOfItem(atPath: filePath) as NSDictionary,
                   let size = attribs["NSFileSize"] as? Int64 {
                        print("fileName: \(file) fileSize: \(size) bytes")
                    }
                }
            } catch {
                print(error)
            }
    }
    
    //디렉토리 및 파일 예제 02
    //특정 디렉토리에 있는 모든 <이미지> 파일을 새로운 디렉토리로 복사하는 코드를 작성해보세요.
    //이미지 파일은 확장자가 .jpg, .png, .gif 인 파일로 가정합니다.
    //또는 Documents 디렉토리에 저장해 놓은 .dat 파일을 Documents/Backup 디렉토리를 생성하여 복사하는 코드를 작성해보세요.
    func ex_02() {
        do {
            let sourcePath = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0].path // 현재 로그인한 유저의 Document 경로 가져오기
            let destinationPath = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("Backup").path

            try fileManager.createDirectory(atPath: destinationPath, withIntermediateDirectories: true) // Backup 디렉토리 생성
            let files = try fileManager.contentsOfDirectory(atPath: sourcePath)
            for file in files {
                let filePath = sourcePath + "/" + file
                let fileExtension = (file as NSString).pathExtension.lowercased() // 파일 확장자 확인
                if fileExtension == "dat" {
                    let destinationFile = destinationPath + "/" + file // Document/Backup/파일명
                    try fileManager.copyItem(atPath: filePath, toPath: destinationFile)
                }
            }
        } catch {
            
        }
    }
    
    func ex_03() {
        do {
            let sourceFile = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("test.dat").path// 현재 로그인한 유저의 Document 경로 가져오기
            let destinationFile = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("reversed.txt").path
            let data = try Data(contentsOf: URL(fileURLWithPath: sourceFile)) // sourceFile 의 내용을 Data로 받을 수 있다.
            // data를 utf8 형식으로 인코딩
        
            if let text = String(data: data, encoding: .utf8) {
                let reversedText = String(text.reversed()) + "\n"
                if let reversedData = reversedText.data(using: .utf8) {
                    try reversedData.write(to: URL(fileURLWithPath: destinationFile)) // URL을 넘겨서 데이터 저장
                    print("File saved path in \(destinationFile)")
                }
            }
        } catch {
            
        }
    }
    
    func ex_04() {
       
            let sourceFile = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("number.dat").path
            let destinationFile = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("result.txt").path
            
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: sourceFile))
                if let text = String(data: data, encoding: .utf8) {
                    let numbers = text.split(separator: ",").compactMap{Int($0)} // 숫자만 저장된 배열로 변환
                    let sum = numbers.reduce(0, +)
                    let avg = Double(sum) / Double(numbers.count)
                    let summary = "합계: \(sum)\n 평균: \(avg)"
                    if let summaryData = summary.data(using: .utf8) {
                        try summaryData.write(to: URL(fileURLWithPath: destinationFile))
                        print("File saved \(destinationFile)")
                    }
                }
            } catch let error {
                print("Error :\(error.localizedDescription)")
        }
    }
    
    func ex_05() {
        let sourceFile = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("test.dat").path
        let destinationFile = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("result2.txt").path
        
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: sourceFile))
            if let text = String(data: data, encoding: .utf8) {
                let words = text.split(separator: " ").map {$0.lowercased()}
                var freq = [String:Int]()
                for word in words {
                    freq[word, default: 0] += 1
                }
                var result = ""
                for (word, count) in freq {
                    result += "\(word):\(count)\n"
                }
                if let resultData = result.data(using: .utf8) {
                    try resultData.write(to: URL(fileURLWithPath: destinationFile))
                }
            }
        } catch let error {
            print("Error :\(error.localizedDescription)")
        }
    }

}

