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
    var coordinator: ProfileFlow?
    
    private let logoutBarButton: UIBarButtonItem = {
        let button = UIBarButtonItem()
        button.title = "Logout"
        button.tintColor = .systemRed
        return button
    }()
    
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
    
    private let usernameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 22, weight: .medium)
        label.isHidden = true
        return label
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
        notificationObserver()
    }
    
    override func setupUI() {
        super.setupUI()
        
        addSpaceView(withSpacing: 30)
        
        let profileView = UIView()
        addView(view: profileView)
        [avatarImageView, authorizeButton, usernameLabel].forEach {
            profileView.addSubview($0)
        }

        profileView.snp.makeConstraints {
            $0.height.equalTo(60)
            $0.left.right.equalToSuperview()
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
        
        usernameLabel.snp.makeConstraints {
            $0.left.equalTo(avatarImageView.snp.right).offset(15)
            $0.centerY.equalTo(avatarImageView)
        }

        addSpaceView(withSpacing: 30)
        addView(view: tableView)
        tableView.snp.makeConstraints {
            $0.height.equalTo(180)
            $0.left.equalToSuperview()
            $0.right.equalToSuperview()
        }
    }
    
    override func bind() {
        tableView.rx
            .setDelegate(self)
            .disposed(by: disposeBag)

        tableView.rx.modelSelected(ProfileCellModel.self).subscribe(onNext: { item in
            print(item)
        })
        .disposed(by: disposeBag)
        
        authorizeButton.rx.tap.bind { [weak self] in
            self?.coordinator?.showPopupView()
        }
        .disposed(by: disposeBag)
        
        logoutBarButton.rx.tap.bind { [weak self] in
            self?.logout()
        }
        .disposed(by: disposeBag)
        
        let input = ProfileViewModel.Input()
        let output = viewModel.transform(input: input)
        
        output.profileItems
            .bind(to: tableView.rx.items(cellIdentifier: Constants.cellIdentifier, cellType: ProfileTableViewCell.self)) { _, item, cell in
                cell.profile = item
            }
            .disposed(by: disposeBag)
    }
    
    func notificationObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(loginSuccess), name: .loginSuccess, object: nil)
    }
    
    @objc private func loginSuccess() {
        authorizeButton.isHidden = true
        usernameLabel.isHidden = false
        usernameLabel.text = UserService.shared.user?.username
        navigationItem.rightBarButtonItem = logoutBarButton
    }
    
    private func logout() {
        UserService.shared.user = nil
        authorizeButton.isHidden = false
        usernameLabel.isHidden = true
        usernameLabel.text = nil
        navigationItem.rightBarButtonItem = nil
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
