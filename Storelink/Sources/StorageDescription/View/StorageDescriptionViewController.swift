//
//  StorageDescriptionViewController.swift
//  Storelink
//
//  Created by Акан Акиш on 23.02.2021.
//  Copyright © 2021 Акан Акиш. All rights reserved.
//

import UIKit
import ImageSlideshow
import SDWebImage

final class StorageDescriptionViewController: InitialViewController {
    
    private let viewModel: StorageDescriptionViewModel
    
    private lazy var imageSliderView: ImageSlideshow = {
        let imageSlider = ImageSlideshow()
        imageSlider.activityIndicator = DefaultActivityIndicator()
        imageSlider.contentScaleMode = UIViewContentMode.scaleAspectFill
        imageSlider.pageIndicatorPosition = .init(horizontal: .center, vertical: .bottom)
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTap))
        imageSlider.addGestureRecognizer(gestureRecognizer)
        return imageSlider
    }()
    
    init(viewModel: StorageDescriptionViewModel) {
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func setupUI() {
        view.addSubview(imageSliderView)
        
        imageSliderView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.left.right.equalToSuperview()
            $0.height.equalTo(250)
        }
        setImages()
    }
    
    func setImages() {
        let sdWebImageSource = [SDWebImageSource(urlString: "https://images.unsplash.com/photo-1432679963831-2dab49187847?w=1080")!, SDWebImageSource(urlString: "https://images.unsplash.com/photo-1447746249824-4be4e1b76d66?w=1080")!, SDWebImageSource(urlString: "https://picsum.photos/seed/picsum/300/300")!]
        
        imageSliderView.setImageInputs(sdWebImageSource)
    }
    
    @objc func didTap() {
        let fullScreenController = imageSliderView.presentFullScreenController(from: self)
        fullScreenController.slideshow.activityIndicator = DefaultActivityIndicator(style: UIActivityIndicatorView.Style.medium, color: nil)
    }

}
