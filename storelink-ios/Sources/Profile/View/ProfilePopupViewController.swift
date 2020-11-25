//
//  ProfilePopupViewController.swift
//  storelink-ios
//
//  Created by Акан Акиш on 11/25/20.
//  Copyright © 2020 Акан Акиш. All rights reserved.
//

import UIKit

final class ProfilePopupViewController: UIViewController {
    
    private var hasSetPointOrigin = false
    private var pointOrigin: CGPoint?
    
    private let topHandleView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.layer.cornerRadius = 2
        return view
    }()
    
    private let button: UIButton = {
        let button = UIButton()
        button.setTitle("Вход", for: .normal)
        button.backgroundColor = .black
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        let swipeDownGesture = UIPanGestureRecognizer(target: self, action: #selector(swipeDownGestureAction))
        view.addGestureRecognizer(swipeDownGesture)
    }
    
    override func viewDidLayoutSubviews() {
        if !hasSetPointOrigin {
            hasSetPointOrigin = true
            pointOrigin = self.view.frame.origin
        }
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        [topHandleView, button].forEach {
            view.addSubview($0)
        }
        
        topHandleView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(15)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(45)
            $0.height.equalTo(4)
        }
    }
    
    @objc private func swipeDownGestureAction(sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: view)
        
        // Not allowing the user to drag the view upward
        guard translation.y >= 0 else { return }
        
        // setting x as 0 because we don't want users to move the frame side ways!! Only want straight up or down
        view.frame.origin = CGPoint(x: 0, y: self.pointOrigin!.y + translation.y)
        
        if sender.state == .ended {
            let dragVelocity = sender.velocity(in: view)
            if dragVelocity.y >= 700 {
                self.dismiss(animated: true, completion: nil)
            } else {
                // Set back to original position of the view controller
                UIView.animate(withDuration: 0.3) {
                    self.view.frame.origin = self.pointOrigin ?? CGPoint(x: 0, y: 400)
                }
            }
        }
    }
    
}
