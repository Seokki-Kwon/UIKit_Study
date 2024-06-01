//
//  ViewController.swift
//  CABasicAnimation
//
//  Created by 석기권 on 6/1/24.
//

import UIKit

class ViewController: UIViewController {
    private lazy var phoneButton: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        let imageView = UIImageView(image: UIImage(systemName: "phone.fill"))
        view.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 40).isActive = true
        imageView.tintColor = .systemGreen
        

        view.backgroundColor = .white
        view.widthAnchor.constraint(equalToConstant: 80).isActive = true
        view.heightAnchor.constraint(equalToConstant: 80).isActive = true
        view.layer.cornerRadius = 40
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panGesture))
        view.addGestureRecognizer(panGesture)
        return view
    }()
    private lazy var slideView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(white: 0, alpha: 0.5)
        view.layer.cornerRadius = 50
        view.clipsToBounds = true
        let label = UILabel()
        label.text = "밀어서 통화하기"
        label.textColor = .systemGray2
        label.font = UIFont.boldSystemFont(ofSize: 20)
        view.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 10).isActive = true
        label.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        label.layer.zPosition = 1
        return view
    }()
    
    private var gradientLayer = CAGradientLayer()
    private let animation = CABasicAnimation(keyPath: "shadowPath")
    private lazy var defaultPath = CGPath(rect: CGRect(x: 0, y: 0, width: 0, height: slideView.frame.height), transform: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setConstraints()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        slideView.layer.addSublayer(gradientLayer) // 슬라이드뷰에 그림자 레이어추가
        animation.toValue = defaultPath
        animation.duration = 0.3
        
    }
    func setConstraints() {
        view.addSubview(slideView)
        view.addSubview(phoneButton)
        
        
        NSLayoutConstraint.activate([
            slideView.heightAnchor.constraint(equalToConstant: 90),
            slideView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            slideView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            slideView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            
            phoneButton.leadingAnchor.constraint(equalTo: slideView.leadingAnchor, constant: 10),
            phoneButton.topAnchor.constraint(equalTo: slideView.topAnchor, constant: 10),
            phoneButton.bottomAnchor.constraint(equalTo: slideView.bottomAnchor, constant: -10),
        ])
    }
    
    @objc func panGesture(sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: phoneButton)
        let newX = phoneButton.center.x + translation.x
        let spacing = (phoneButton.frame.width / 2)
        let minX = slideView.frame.minX + spacing + 10
        let maxX = slideView.frame.maxX - spacing - 10
        let moveX = max(minX, min(newX, maxX))
        
        if sender.state == .changed {
            phoneButton.center.x = moveX
            
            // 블러효과 시작
            let inset = UIEdgeInsets(top: -40, left: -40, bottom: -40, right: 30)
            gradientLayer.shadowRadius = 30 // 흐림반경
            gradientLayer.shadowPath = CGPath(rect: CGRect(x: 0, y: 0, width: moveX, height: slideView.frame.height).inset(by: inset), transform: nil)
            gradientLayer.shadowOpacity = 1
            gradientLayer.shadowOffset = CGSize.zero
            gradientLayer.shadowColor = UIColor.green.cgColor
            
            animation.fromValue = gradientLayer.shadowPath // from값을 기록
            
            sender.setTranslation(CGPoint.zero, in: phoneButton)
        }
        
        if sender.state == .ended {
            gradientLayer.add(animation, forKey: "animation")
            gradientLayer.shadowPath = defaultPath
            
            UIView.animate(withDuration: 0.2) {
                self.phoneButton.center.x = minX
            }
        }
    }
}

