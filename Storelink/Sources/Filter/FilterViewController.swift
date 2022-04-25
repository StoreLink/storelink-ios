//
//  FilterViewController.swift
//  Storelink
//
//  Created by Акан Акиш on 27.05.2021.
//  Copyright © 2021 Акан Акиш. All rights reserved.
//

import UIKit

class FilterViewController: InitialViewController {
    var coordinator: MainFlow?

    private let doneBarButtonItem: UIBarButtonItem = {
        let button = UIBarButtonItem()
        button.title = "Done"
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Filters"
    }

    override func setNavigationLeftBarButton() {
        super.setNavigationLeftBarButton()
        navigationItem.rightBarButtonItem = doneBarButtonItem
    }

    override func setupUI() {}

    override func bind() {
        doneBarButtonItem.rx.tap.bind { [weak self] in
            self?.dismiss(animated: true, completion: nil)
        }
        .disposed(by: disposeBag)
    }
}
