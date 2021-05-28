//
//  AddPopupViewController.swift
//  Storelink
//
//  Created by Акан Акиш on 15.02.2021.
//  Copyright © 2021 Акан Акиш. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class AddPopupViewController: InitialViewController {
    
    private enum Constants {
        static let cellIdentifier = "cellId"
    }
    
    var coordinator: TabBarFlow?
    private var hasSetPointOrigin = false
    private var pointOrigin: CGPoint?
    
    private let topHandleView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.layer.cornerRadius = 2
        return view
    }()
    
    private let closeButton: BaseButton = {
        let button = BaseButton()
        button.setImage(Assets.close.image.withRenderingMode(UIImage.RenderingMode.alwaysTemplate), for: .normal)
        button.tintColor = .systemGray
        button.buttonColor = UIColor.lightGray.withAlphaComponent(0.3)
        button.layer.cornerRadius = 15
        return button
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = Strings.add
        label.font = UIFont.systemFont(ofSize: 24, weight: .medium)
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.showsVerticalScrollIndicator = false
        tableView.register(AddTableViewCell.self, forCellReuseIdentifier: Constants.cellIdentifier)
        tableView.isScrollEnabled = false
        return tableView
    }()
    
    private let dataSource: BehaviorRelay<[AddItem]> = .init(value: [AddItem(title: "Storage", image: Assets.storage.image), AddItem(title: "Item", image: Assets.item.image)])

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let swipeDownGesture = UIPanGestureRecognizer(target: self, action: #selector(swipeDownGestureAction))
        view.addGestureRecognizer(swipeDownGesture)
    }
    
    override func viewDidLayoutSubviews() {
        if !hasSetPointOrigin {
            hasSetPointOrigin = true
            pointOrigin = self.view.frame.origin
        }
    }
    
    override func setupUI() {
        view.backgroundColor = .white
        view.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: 220)
        
        [topHandleView, closeButton, titleLabel, tableView].forEach {
            view.addSubview($0)
        }
        
        topHandleView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(15)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(40)
            $0.height.equalTo(4)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(topHandleView.snp.bottom).offset(15)
            $0.left.equalToSuperview().offset(30)
            $0.right.equalToSuperview().offset(-30)
        }
        
        closeButton.snp.makeConstraints {
            $0.size.equalTo(30)
            $0.centerY.equalTo(titleLabel.snp.centerY)
            $0.right.equalToSuperview().offset(-30)
        }
        
        closeButton.imageView?.snp.makeConstraints {
            $0.size.equalTo(16)
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(10)
            $0.left.right.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
    
    override func bind() {
        closeButton.rx.tap.bind { [weak self] in
            self?.dismiss(animated: true, completion: nil)
        }
        .disposed(by: disposeBag)
        
        dataSource
        .bind(to: tableView.rx.items(cellIdentifier: Constants.cellIdentifier, cellType: AddTableViewCell.self)) { _, model, cell in
            cell.addItem = model
        }
        .disposed(by: disposeBag)
        
        tableView.rx.modelSelected(AddItem.self).subscribe(onNext: { [weak self] item in
            switch item.title {
            case "Storage":
                if UserService.shared.user != nil {
                    self?.coordinator?.showAddStorageView()
                } else {
                    self?.showAlert(message: "Please login to manage storages")
                }
            case "Item":
                if UserService.shared.user != nil {
                    self?.coordinator?.showAddItemView()
                } else {
                    self?.showAlert(message: "Please login to manage items")
                }
            default:
                break
            }
        })
        .disposed(by: disposeBag)
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
    
    func showAlert(message: String) {
        let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: {_ in
            self.dismiss(animated: true, completion: nil)
        }))
        alertController.pruneNegativeWidthConstraints()
        self.present(alertController, animated: true, completion: nil)
    }
}
