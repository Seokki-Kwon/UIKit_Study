//
//  ViewController.swift
//  HandlingGesture
//
//  Created by 석기권 on 6/8/24.
//

import UIKit

class ViewController: UIViewController {
  
    
    private lazy var addViewBtn: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("add View", for: .normal)
        btn.backgroundColor = .blue
        btn.addTarget(self, action: #selector(addViewBtnTapped), for: .touchUpInside)
        return btn
        
    }()
    
    private let gestureLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "no gesture"
        label.textColor = .black
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(addViewBtn)
        view.addSubview(gestureLabel)
        
        NSLayoutConstraint.activate([
            addViewBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            addViewBtn.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            
            gestureLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            gestureLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10)
        ])
    }
    
    @objc func addViewBtnTapped() {
        let myView = UIStackView()
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panGestureHandler))
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(pinchHandler))
        let rotationGesture = UIRotationGestureRecognizer(target: self, action: #selector(rotationHandler))
        panGesture.delegate = self
        myView.frame.size.width = 200
        myView.frame.size.height = 200
        myView.layer.position = CGPoint(x: view.center.x, y: view.center.y)
        myView.isUserInteractionEnabled = true // 기본속성은 false
        myView.addGestureRecognizer(panGesture)
        myView.addGestureRecognizer(rotationGesture)
//        myView.addGestureRecognizer(pinchGesture)
        myView.backgroundColor = .yellow
        myView.axis = .vertical
        myView.distribution = .fillEqually
        view.addSubview(myView)
    }
    
    @objc func panGestureHandler(sender: UIPanGestureRecognizer) {
        gestureLabel.text = "PanGesture is \(sender.state.toString)"
        guard let view = sender.view as? UIStackView else { return }
        
        let translation = sender.translation(in: view) // view의 팬 동작을 감지
        let radians = atan2(view.transform.b, view.transform.a)
        
        let degrees = radians * 180 / .pi
        view.subviews.forEach { $0.removeFromSuperview() }
        let label1 = UILabel()
        let label2 = UILabel()
        let label3 = UILabel()
        let label4 = UILabel()
        let label5 = UILabel()
        label1.text = "centerX: \(view.center.x)"
        label2.text = "centerY: \(view.center.y)"
        label3.text = "transitionX: \(translation.x)"
        label4.text = "transitionY: \(translation.y)"
        label5.text = "degrees: \(degrees)"
        [label1, label2, label3, label4, label5].forEach { view.addArrangedSubview($0)}
//        let moveX = view.center.x + translation.x // view.centerX에 현재
//        let moveY = view.center.y + translation.y
//        view.center = .init(x: moveX, y: moveY)
        view.transform = view.transform.translatedBy(x: translation.x, y: translation.y)
        sender.setTranslation(CGPoint.zero, in: view) // 변환된값을 지정
    }
    
    @objc func pinchHandler(sender: UIPinchGestureRecognizer) {
        gestureLabel.text = "PinchGesture is \(sender.state.toString)"
        guard let view = sender.view else {
            return
        }
        view.transform = view.transform.scaledBy(x: sender.scale, y: sender.scale)
        sender.scale = 1.0
    }
    
    @objc func rotationHandler(sender: UIRotationGestureRecognizer) {
        gestureLabel.text = "RotaionGesture is \(sender.state.toString)"
        guard let view = sender.view else {
            return
        }
        view.transform = view.transform.rotated(by: sender.rotation)
        sender.rotation = 0 // 값이 누적되기 떄문에 0으로 초기화
    }

}

extension ViewController: UIGestureRecognizerDelegate {
//     shouldRecognizeSimultaneouslyWith 2개의 제스처를 동시에 허용할지 여부
    
}

extension UIGestureRecognizer.State {
    var toString: String {
        switch self {
        case .began:
            return "began"
        case .ended:
            return "ended"
        case .cancelled:
            return "cancelld"
        case .possible:
            return "possible"
        case .changed:
            return "changed"
        case .failed:
            return "failed"
        @unknown default:
            return "Error"
        }
    }
}
