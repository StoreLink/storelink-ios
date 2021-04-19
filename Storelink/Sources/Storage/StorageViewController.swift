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
        let items = ["Storages", "Stuff"]
        let sg = UISegmentedControl(items: items)
        sg.frame = CGRect(x: 0, y: 0, width: 250, height: 30)
        sg.selectedSegmentIndex = 0
        sg.selectedSegmentTintColor = Colors.teal.color
        sg.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: UIControl.State.selected)
        return sg
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = Strings.storage
    }
    
    override func setupUI() {
        self.navigationItem.titleView = segmentControl
    }
    
    override func bind() {
        segmentControl.rx.selectedSegmentIndex.subscribe(onNext: { [weak self] index in
            switch index {
            case 0:
                print(0)
            case 1:
                print(1)
            default:
                break
            }
        }).disposed(by: disposeBag)
    }

}
