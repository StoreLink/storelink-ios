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
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        label.textAlignment = .center
        return label
    }()
    
    private var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        label.numberOfLines = 0
        return label
    }()
    
    private let viewModel: SignupOTPViewModel
    
    var coordinator: SignupFlow?
    
    init(viewModel: SignupOTPViewModel) {
        self.viewModel = viewModel
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = Strings.signup
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
        titleLabel.text = Strings.verificationRequired
        
        let text: NSMutableAttributedString = .init(string: Strings.fourDigitCode + "\n" + viewModel.phoneNumber, attributes: [ .foregroundColor: UIColor.lightGray])
        let range: NSRange = text.mutableString.range(of: viewModel.phoneNumber)
        text.addAttributes([.foregroundColor: UIColor.black], range: range)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 4
        text.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: text.length))
        descriptionLabel.attributedText = text
        descriptionLabel.textAlignment = .center
    }
}
