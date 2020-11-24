//
//  InitialViewController.swift
//  storelink-ios
//
//  Created by Акан Акиш on 9/17/20.
//  Copyright © 2020 Акан Акиш. All rights reserved.
//

import UIKit

class InitialViewController: UIViewController {
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        self.init()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        setupUI()
        bind()
    }
    
    func setupUI() {
        
    }
    
    func bind() {
        
    }

}
