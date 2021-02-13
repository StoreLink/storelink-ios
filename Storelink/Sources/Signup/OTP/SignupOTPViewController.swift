//
//  SignupOTPViewController.swift
//  Storelink
//
//  Created by Акан Акиш on 09.02.2021.
//  Copyright © 2021 Акан Акиш. All rights reserved.
//

import UIKit

final class SignupOTPViewController: InitialViewController {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.textAlignment = .center
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private let viewModel: SignupOTPViewModel
    
    init(viewModel: SignupOTPViewModel) {
        self.viewModel = viewModel
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Регистрация"
    }
    
    override func setupUI() {
        setData()
        
        [titleLabel, descriptionLabel].forEach {
            view.addSubview($0)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(30)
            $0.centerX.equalToSuperview()
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(25)
            $0.centerX.equalToSuperview()
        }
    }
    
    override func bind() {
        
    }
    
    func setData() {
        titleLabel.text = "Требуется проверка"
        descriptionLabel.text = "Введите 4-значный код, отправленный на:"
    }
}
