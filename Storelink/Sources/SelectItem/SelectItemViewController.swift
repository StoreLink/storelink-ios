//
//  SelectItemViewController.swift
//  Storelink
//
//  Created by Акан Акиш on 28.05.2021.
//  Copyright © 2021 Акан Акиш. All rights reserved.
//

import RxCocoa
import RxSwift
import UIKit

class SelectItemViewController: InitialViewController {
    private enum Constants {
        static let cellIdentifier = "cellId"
    }

    let dataSource: BehaviorRelay<[Item]> = .init(value: [])

    private let closeBarButtonItem: UIBarButtonItem = {
        let barButton = UIBarButtonItem()
        barButton.image = Assets.close.image
        barButton.tintColor = .black
        return barButton
    }()

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.showsVerticalScrollIndicator = false
        tableView.allowsMultipleSelection = true
        tableView.allowsMultipleSelectionDuringEditing = true
        tableView.register(ItemTableViewCell.self, forCellReuseIdentifier: Constants.cellIdentifier)
        return tableView
    }()

    private let actionButton = MainButton(title: "Add items")

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Select items"

        NetworkManager.shared.getItems()
            .subscribe(onSuccess: { [weak self] items in
                self?.dataSource.accept(items)
            })
            .disposed(by: disposeBag)
    }

    override func setNavigationLeftBarButton() {
        super.setNavigationLeftBarButton()
        navigationItem.rightBarButtonItem = closeBarButtonItem
    }

    override func setupUI() {
        view.addSubview(actionButton)
        actionButton.snp.makeConstraints {
            $0.left.equalToSuperview().offset(20)
            $0.right.equalToSuperview().offset(-20)
            $0.height.equalTo(45)
            $0.bottom.equalToSuperview().offset(-20)
        }

        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.left.right.equalToSuperview()
            $0.bottom.equalTo(actionButton.snp.top).offset(-10)
        }
    }

    override func bind() {
        closeBarButtonItem.rx.tap.bind { [weak self] in
            self?.dismiss(animated: true, completion: nil)
        }
        .disposed(by: disposeBag)

        actionButton.rx.tap.bind { [weak self] in
            self?.showAlert()
        }
        .disposed(by: disposeBag)

        dataSource
            .bind(to: tableView.rx.items(cellIdentifier: Constants.cellIdentifier, cellType: ItemTableViewCell.self)) { _, model, cell in
                cell.item = model
            }
            .disposed(by: disposeBag)
    }

    func showAlert() {
        let alertController = UIAlertController(title: nil, message: "Your application has been submitted. Please wait for a response", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
            self.dismiss(animated: true, completion: nil)
        }))
        alertController.pruneNegativeWidthConstraints()
        present(alertController, animated: true, completion: nil)
    }
}
