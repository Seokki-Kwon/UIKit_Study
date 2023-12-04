//
//  ViewController.swift
//  LiveSpeech
//
//  Created by SeokkiKwon on 12/4/23.
//

import UIKit
import Speech
class ViewController: UIViewController {
    
    @IBOutlet var transcribeButton: UIButton!
    @IBOutlet var stopButton: UIButton!
    @IBOutlet var myTextView: UITextView!
    
    // SFSpeechRecognizer 음성인식 프로세스를 시작하는데 필요한 개체
    // SFSpeechRecognitionRequest 음성을 인식하기 위한 요청
    // SFSpeechRecognitionTask 음성인식 작업 상태 확인, 취소, 종료 신호를 보내는게 가능 cancel, finish, state(모니터링)
    private let speechReconizer = SFSpeechRecognizer(locale: Locale(identifier: "ko-KR"))
    private var speechRecognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    private var speechRecognitionTask: SFSpeechRecognitionTask?
    private var audioEngine = AVAudioEngine()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        authorizeSR()
        // Do any additional setup after loading the view.
    }
    
    func authorizeSR() {
        // 앱이 실횡되면 음성인식 가능여부(?)를 확인
        SFSpeechRecognizer.requestAuthorization { authStatus in
            
            OperationQueue.main.addOperation {
                switch authStatus {
                case .authorized:
                    self.transcribeButton.isEnabled = true
                    
                case .denied:
                    self.transcribeButton.isEnabled = false
                    self.transcribeButton.setTitle("Speech recognition access denied by user", for: .disabled)
                    
                case .restricted:
                    self.transcribeButton.isEnabled = false
                    self.transcribeButton.setTitle(
                        "Speech recognition restricted on device", for: .disabled)
                    
                case .notDetermined:
                    self.transcribeButton.isEnabled = false
                    self.transcribeButton.setTitle(
                        "Speech recognition not authorized", for: .disabled)
                @unknown default:
                    print("Unknown state")
                }
            }
        }
    }
    
    
    @IBAction func startTramscribing(_ sender: Any) {
        transcribeButton.isEnabled = false
        stopButton.isEnabled = true
        
        do {
            try startSession()
        } catch {
            
        }
    }
    
    func startSession() throws {
        //새로운 작업을 시작하기전 이미 task가 존재하는 경우 기존 task를 제거
        if let recognitionTask = speechRecognitionTask {
            recognitionTask.cancel()
            self.speechRecognitionTask = nil
        }
        let audioSession = AVAudioSession.sharedInstance()

            try audioSession.setCategory(.record, mode: .default)
            
            speechRecognitionRequest = SFSpeechAudioBufferRecognitionRequest()
            
            guard let reconitionRequest = speechRecognitionRequest else {
                fatalError("")
            }
            
            let inputNode = audioEngine.inputNode
            reconitionRequest.shouldReportPartialResults = true
            
            speechRecognitionTask = speechReconizer?.recognitionTask(with: reconitionRequest) { result , error in
            var finished = false
            if let result = result {
                self.myTextView.text = result.bestTranscription.formattedString
                finished = result.isFinal
            }
                // 에러가 발생하거나 작업이 완료된 경우
            if error != nil || finished {
                self.audioEngine.stop()
                inputNode.removeTap(onBus: 0)
                
                self.speechRecognitionRequest = nil
                self.speechRecognitionTask = nil
                
                self.transcribeButton.isEnabled = true
            }
        }
        
        let recordingFormat = inputNode.outputFormat(forBus: 0)
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer: AVAudioPCMBuffer, when: AVAudioTime) in
            self.speechRecognitionRequest?.append(buffer)
        }
        // 이곳에서 시작된 음성녹음의 결과를 클로저의 result 매개변수로 받는다?
        audioEngine.prepare()
        try audioEngine.start()
    }
    
    
    @IBAction func stopTranscribing(_ sender: Any) {
        if audioEngine.isRunning {
            audioEngine.stop()
            speechRecognitionRequest?.endAudio()
            
            transcribeButton.isEnabled = true
            stopButton.isEnabled = false
        }
    }
}

