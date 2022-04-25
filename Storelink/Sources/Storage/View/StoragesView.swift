//
//  StoragesView.swift
//  Storelink
//
//  Created by Акан Акиш on 11.05.2021.
//  Copyright © 2021 Акан Акиш. All rights reserved.
//

import RxCocoa
import RxSwift
import UIKit

final class StoragesView: UIView {
    private enum Constants {
        static let cellIdentifier = "cellId"
    }

    private let disposeBag: DisposeBag = .init()
    let dataSource: BehaviorRelay<[StorageItem]> = .init(value: [])

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.showsVerticalScrollIndicator = false
        tableView.register(MainTableViewCell.self, forCellReuseIdentifier: Constants.cellIdentifier)
        tableView.isHidden = true
        return tableView
    }()

    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Assets.coloredStorage.image
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    private let textLabel: UILabel = {
        let label = UILabel()
        label.text = "You don't have added storage"
        label.numberOfLines = 0
        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        return label
    }()

    private lazy var contentStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [imageView, textLabel])
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 10
        return stackView
    }()

    init() {
        super.init(frame: .zero)
        setupView()
        bind()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupView() {
        addSubview(contentStackView)
        contentStackView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.left.equalToSuperview().offset(40)
            $0.right.equalToSuperview().offset(-40)
        }

        addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.left.equalToSuperview().offset(25)
            $0.right.equalToSuperview().offset(-25)
        }
    }

    func bind() {
        dataSource
            .bind(to: tableView.rx.items(cellIdentifier: Constants.cellIdentifier, cellType: MainTableViewCell.self)) { _, model, cell in
                cell.storageItem = model
            }
            .disposed(by: disposeBag)
    }

    func showStorages() {
        tableView.isHidden = false
        contentStackView.isHidden = true
    }

    func hideStorages() {
        tableView.isHidden = true
        contentStackView.isHidden = false
    }
}
