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

final class StorageDescriptionViewController: ScrollViewController {
    
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
    
    private let backButton: BackButton = .init()
    private let likeButton: LikeButton = .init()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Title"
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Description of the storage"
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        UIApplication.shared.statusBarStyle = .lightContent
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
        UIApplication.shared.statusBarStyle = .default
    }
    
    override func setupUI() {
        super.setupUI()
        setData()
        
        _scrollView.contentInsetAdjustmentBehavior = .never
        
        addView(view: imageSliderView)
        imageSliderView.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.height.equalTo(350)
        }

        imageSliderView.addSubview(backButton)
        backButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(60)
            $0.left.equalToSuperview().offset(30)
        }
        
        imageSliderView.addSubview(likeButton)
        likeButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(60)
            $0.right.equalToSuperview().offset(-30)
        }
        
        addSpaceView(withSpacing: 15)
        addView(view: titleLabel)
        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
        }

        addSpaceView(withSpacing: 10)
        addView(view: descriptionLabel)
        descriptionLabel.snp.makeConstraints {
            $0.left.equalToSuperview().offset(20)
            $0.right.equalToSuperview().offset(-20)
        }

        addSpaceView(withSpacing: 500)
    }
    
    override func bind() {
        backButton.rx.tap.bind { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }.disposed(by: disposeBag)
    }
    
    private func setData() {
        setImages()
        imageSliderView.heroID = String(viewModel.storageItem.id)
    }
    
    private func setImages() {
        var sdWebImageSource: [SDWebImageSource] = []
        for imageStringUrl in viewModel.storageItem.images {
            sdWebImageSource.append(SDWebImageSource(urlString: imageStringUrl)!)
        }
        imageSliderView.setImageInputs(sdWebImageSource)
    }
    
    @objc func didTap() {
        let fullScreenController = imageSliderView.presentFullScreenController(from: self)
        fullScreenController.slideshow.activityIndicator = DefaultActivityIndicator(style: UIActivityIndicatorView.Style.medium, color: nil)
    }

}
