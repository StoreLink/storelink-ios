//
//  InitialViewController.swift
//  storelink-ios
//
//  Created by Акан Акиш on 9/17/20.
//  Copyright © 2020 Акан Акиш. All rights reserved.
//

import UIKit
import RxSwift

class InitialViewController: UIViewController {
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
        view.addSubview(indicator)
        indicator.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        return indicator
    }()
    
    let disposeBag = DisposeBag()
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        self.init()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        setupUI()
        bind()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setNavigationLeftBarButton()
    }
    
    func startLoader() {
        view.bringSubviewToFront(activityIndicator)
        activityIndicator.startAnimating()
    }
    
    func stopLoader() {
        activityIndicator.stopAnimating()
    }
    
    func setNavigationLeftBarButton() {
        if let count = self.navigationController?.viewControllers.count, count <= 1 {
            self.navigationItem.leftBarButtonItem = nil
        } else {
            let leftBarButtonItem: UIBarButtonItem = {
                let barButtonItem = UIBarButtonItem()
                barButtonItem.image = Assets.back.image
                barButtonItem.title = ""
                barButtonItem.tintColor = .black
                barButtonItem.target = self
                barButtonItem.action = #selector(backAction)
                return barButtonItem
            }()
            navigationItem.leftBarButtonItem = leftBarButtonItem
        }
    }
    
    @objc private func backAction() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func setupUI() {}
    
    func bind() {}

}
