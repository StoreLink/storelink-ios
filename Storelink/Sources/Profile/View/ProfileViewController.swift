//
//  ProfileViewController.swift
//  storelink-ios
//
//  Created by Акан Акиш on 11/23/20.
//  Copyright © 2020 Акан Акиш. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class ProfileViewController: ScrollViewController {
    
    private enum Constants {
        static let cellIdentifier = "cellId"
    }
    
    private let viewModel: ProfileViewModel
    
    private let avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Assets.person.image
        imageView.backgroundColor = Colors.lightGray.color
        imageView.contentMode = .center
        imageView.layer.borderWidth = 2
        imageView.layer.cornerRadius = 10
        return imageView
    }()
    
    private let authorizeButton: UIButton = {
        let button = UIButton()
        button.setTitle(Strings.loginToAccount, for: .normal)
        button.setTitleColor(Colors.teal.color, for: .normal)
        button.setTitleColor(Colors.darkTeal.color, for: [.normal, .highlighted])
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.setTitleColor(.black, for: .selected)
        return button
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.rowHeight = 45
        tableView.isScrollEnabled = false
        tableView.showsVerticalScrollIndicator = false
        tableView.register(ProfileTableViewCell.self, forCellReuseIdentifier: Constants.cellIdentifier)
        return tableView
    }()
    
    init(viewModel: ProfileViewModel) {
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = Strings.profile
    }
    
    override func setupUI() {
        super.setupUI()
        
        addSpaceView(withSpacing: 30)
        
        let profileView = UIView()
        addView(view: profileView)
        [avatarImageView, authorizeButton].forEach {
            profileView.addSubview($0)
        }
        
        profileView.snp.makeConstraints {
            $0.height.equalTo(60)
        }
        
        avatarImageView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.left.equalToSuperview().offset(20)
            $0.height.width.equalTo(60)
        }

        authorizeButton.snp.makeConstraints {
            $0.left.equalTo(avatarImageView.snp.right).offset(15)
            $0.centerY.equalTo(avatarImageView)
        }
        
        addSpaceView(withSpacing: 30)
        addView(view: tableView)
        tableView.snp.makeConstraints {
            $0.height.equalTo(180)
        }
    }
    
    override func bind() {
        
        tableView.rx
            .setDelegate(self)
            .disposed(by: disposeBag)
        
        viewModel.profileItems.asObservable()
            .bind(to: tableView.rx.items(cellIdentifier: Constants.cellIdentifier, cellType: ProfileTableViewCell.self)) {row, item, cell in
                cell.profile = item
            }
            .disposed(by: disposeBag)
        
        tableView.rx.modelSelected(ProfileCellModel.self).subscribe(onNext: { (item) in
            
        }).disposed(by: disposeBag)
        
        authorizeButton.rx.tap.bind { [weak self] in
            let authorizationPopupView = ProfilePopupViewController()
            authorizationPopupView.modalPresentationStyle = .custom
            authorizationPopupView.transitioningDelegate = self
            self?.present(authorizationPopupView, animated: true, completion: nil)
            
            authorizationPopupView.loginAction = { [weak self] in
                self?.navigationController?.present(UINavigationController(rootViewController: LoginViewController()), animated: true, completion: nil)
            }
            
            authorizationPopupView.signupAction = { [weak self] in
                self?.navigationController?.present(UINavigationController(rootViewController: SignupPhoneViewController()), animated: true, completion: nil)
            }
        }.disposed(by: disposeBag)
    }
}

extension ProfileViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        
        let label: UILabel = {
            let label = UILabel()
            label.text = Strings.accountSettings
            label.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.medium)
            label.textColor = .gray
            return label
        }()
        
        headerView.addSubview(label)
        
        label.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10)
            $0.left.equalToSuperview().offset(20)
            $0.bottom.equalToSuperview().offset(-5)
        }
        
        return headerView
    }
}

extension ProfileViewController: UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        PresentationController(presentedViewController: presented, presenting: presenting)
    }
}
