//
//  StorageViewController.swift
//  Storelink
//
//  Created by Акан Акиш on 15.02.2021.
//  Copyright © 2021 Акан Акиш. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

final class StorageViewController: InitialViewController {

    var coordinator: StorageFlow?
    
    private let segmentControl: UISegmentedControl = {
        let items = ["Storages", "Items"]
        let sg = UISegmentedControl(items: items)
        sg.frame = CGRect(x: 0, y: 0, width: 250, height: 30)
        sg.selectedSegmentIndex = 0
        sg.selectedSegmentTintColor = Colors.teal.color
        sg.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: UIControl.State.selected)
        return sg
    }()
    
    private let storagesView: StoragesView = .init()
    private let itemsView: ItemsView = .init()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = Strings.storage
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NetworkManager.shared.getStorages()
            .subscribe(onSuccess: { [weak self] storages in
                StorageService.shared.storages = storages
                
                if let storages = StorageService.shared.storages, storages.count > 0 {
                    self?.storagesView.showStorages()
                    self?.storagesView.dataSource.accept(storages)
                } else {
                    self?.storagesView.hideStorages()
                }
            })
            .disposed(by: disposeBag)
        
        NetworkManager.shared.getItems()
            .subscribe(onSuccess: { [weak self] items in
                ItemService.shared.items = items
                
                if let items = ItemService.shared.items, items.count > 0 {
                    self?.itemsView.showStorages()
                    self?.itemsView.dataSource.accept(items)
                } else {
                    self?.itemsView.hideStorages()
                }
            })
            .disposed(by: disposeBag)
    }
    
    override func setupUI() {
        self.navigationItem.titleView = segmentControl
        
        view.addSubview(storagesView)
        storagesView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.left.right.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
        
        view.addSubview(itemsView)
        itemsView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.left.right.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
    
    override func bind() {
        segmentControl.rx.selectedSegmentIndex.subscribe(onNext: { [weak self] index in
            switch index {
            case 0:
                self?.storagesView.isHidden = false
                self?.itemsView.isHidden = true
            case 1:
                self?.storagesView.isHidden = true
                self?.itemsView.isHidden = false
            default:
                break
            }
        })
        .disposed(by: disposeBag)
    }
}
