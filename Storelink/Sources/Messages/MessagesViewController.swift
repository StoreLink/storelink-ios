//
//  MessagesViewController.swift
//  Storelink
//
//  Created by Акан Акиш on 15.02.2021.
//  Copyright © 2021 Акан Акиш. All rights reserved.
//

import UIKit

class MessagesViewController: InitialViewController {
    
    var coordinator: MessagesFlow?

    override func viewDidLoad() {
        super.viewDidLoad()

        title = Strings.messages
    }

}
