//
//  MainViewController.swift
//  Storelink
//
//  Created by Акан Акиш on 15.02.2021.
//  Copyright © 2021 Акан Акиш. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class MainViewController: InitialViewController {
    
    private enum Constants {
        static let cellIdentifier = "cellId"
    }
    
    private let viewModel: MainViewModel
    var coordinator: MainFlow?
    
    private let mapBarButtonItem: UIBarButtonItem = {
        let button = UIBarButtonItem()
        button.image = Assets.map.image
        button.tintColor = Colors.teal.color
        return button
    }()
    
    private let filterBarButtonItem: UIBarButtonItem = {
        let button = UIBarButtonItem()
        button.image = Assets.filter.image
        button.tintColor = Colors.teal.color
        return button
    }()
    
    private let refreshControl: UIRefreshControl = .init()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.refreshControl = refreshControl
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.showsVerticalScrollIndicator = false
        tableView.register(MainTableViewCell.self, forCellReuseIdentifier: Constants.cellIdentifier)
        return tableView
    }()
    
    private let dataSource: BehaviorRelay<[StorageItem]> = .init(value: [])
    
    init(viewModel: MainViewModel) {
        self.viewModel = viewModel
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = Strings.main
    }
    
    override func bind() {
        viewModel.loading
            .asObservable()
            .bind { [weak self] loading in
                loading ? self?.startLoader() : self?.stopLoader()
            }
            .disposed(by: disposeBag)
        
        dataSource
            .bind(to: tableView.rx.items(cellIdentifier: Constants.cellIdentifier, cellType: MainTableViewCell.self)) { _, model, cell in
                cell.storageItem = model
            }
            .disposed(by: disposeBag)

        tableView.rx.modelSelected(StorageItem.self).subscribe(onNext: { [weak self] item in
            self?.coordinator?.showStorageDescriptionView(storageItem: item)
        })
        .disposed(by: disposeBag)
        
        mapBarButtonItem.rx.tap.bind { [weak self] in
            let storages = self?.dataSource.value
            self?.coordinator?.showMapView(storages: storages ?? [])
        }
        .disposed(by: disposeBag)
        
        filterBarButtonItem.rx.tap.bind { [weak self] in
            self?.coordinator?.showFilterView()
        }
        .disposed(by: disposeBag)
        
        let loadDataTrigger = Observable.merge(refreshControl.rx.controlEvent(.valueChanged).asObservable(), Observable.just(Void()))
        
        let input = MainViewModel.Input(loadDataTrigger: loadDataTrigger)
        let output = viewModel.transform(input: input)
        
        output.storageItems
            .bind(to: dataSource)
            .disposed(by: disposeBag)
        
        output.dataLoaded
            .subscribe(onNext: { [weak self] in
                self?.refreshControl.endRefreshing()
            })
            .disposed(by: disposeBag)
    }
    
    override func setupUI() {
        setNavigationRightBarButtonItem()
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.left.equalToSuperview().offset(25)
            $0.right.equalToSuperview().offset(-25)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
    
    override func setNavigationLeftBarButton() {
        navigationItem.leftBarButtonItem = mapBarButtonItem
    }
    
    func setNavigationRightBarButtonItem() {
        navigationItem.rightBarButtonItem = filterBarButtonItem
    }

}
