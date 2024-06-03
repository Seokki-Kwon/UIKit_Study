//
//  ViewController.swift
//  ActivityKitDemo
//
//  Created by 석기권 on 6/3/24.
//

import UIKit
import ActivityKit

class ViewController: UIViewController {
    private var activity: Activity<TestWidgetAttributes>!
    private var timer: Timer?
    private let moods = [
        MyMood(status: "happy", emoji: "😊"),
        MyMood(status: "sad", emoji: "😞"),
        MyMood(status: "holic", emoji: "🥰"),
        MyMood(status: "wack", emoji: "🤮"),
        MyMood(status: "angry", emoji: "😡"),
    ]
    
    private lazy var startActivity: UIButton = {
        let bt = UIButton()
        bt.translatesAutoresizingMaskIntoConstraints = false
        bt.setTitle("request", for: .normal)
        bt.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
        bt.backgroundColor = .red
        return bt
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(startActivity)
        NSLayoutConstraint.activate([
            startActivity.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            startActivity.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if #available(iOS 13.0, *) {
                   NotificationCenter.default.addObserver(self, selector: #selector(enterBackground), name: UIScene.willDeactivateNotification, object: nil)
               } else {
                   NotificationCenter.default.addObserver(self, selector: #selector(enterBackground), name: UIApplication.willResignActiveNotification, object: nil)
               }
               
               // 포어그라운드 진입
               if #available(iOS 13.0, *) {
                   NotificationCenter.default.addObserver(self, selector: #selector(enterForeground), name: UIScene.willEnterForegroundNotification, object: nil)
               } else {
                   NotificationCenter.default.addObserver(self, selector: #selector(enterForeground), name: UIApplication.willEnterForegroundNotification, object: nil)
               }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func enterBackground() {
        guard let activity = self.activity else {
            return
        }
        timer = Timer.scheduledTimer(withTimeInterval: 2.0, repeats: true, block: { _ in
           
            if activity.activityState == .active {
                self.updateActivity()
            }
            
        })
    }
    
    @objc func enterForeground() {
        timer?.invalidate()
        Task {
            guard let activity = self.activity else {
                return
            }
            if activity.activityState == .active {
                await activity.end(nil, dismissalPolicy: .immediate)
            }
            
        }
    }
    
    func updateActivity() {
        let newContentState = TestWidgetAttributes.ContentState(mood: moods.randomElement()!)
        
        Task {
            await activity.update(.init(state: newContentState, staleDate: .now + 1.0))
        }
    }

    @objc func startButtonTapped() {
        if ActivityAuthorizationInfo().areActivitiesEnabled {
            let attributes = TestWidgetAttributes(name: "test")
            let initialState = TestWidgetAttributes.ContentState(mood: moods.randomElement()!)
            
            do {
                activity = try Activity<TestWidgetAttributes>.request(
                    attributes: attributes,
                    content: .init(state: initialState, staleDate: nil)
                )
                                
            } catch {
                
            }
        }
    }
}

