//
//  StorageDescriptionViewController.swift
//  Storelink
//
//  Created by Акан Акиш on 23.02.2021.
//  Copyright © 2021 Акан Акиш. All rights reserved.
//

import UIKit
import ImageSlideshow
import GoogleMaps
import SDWebImage

final class StorageDescriptionViewController: ScrollViewController {
    
    enum Constants {
        static let phoneImageSFPath = "phone.fill"
        static let messageImageSFPath = "message.fill"
    }
    
    // MARK: - Properties
    
    private let viewModel: StorageDescriptionViewModel
    
    private lazy var imageSliderView: ImageSlideshow = {
        let imageSlider = ImageSlideshow()
        imageSlider.activityIndicator = DefaultActivityIndicator()
        imageSlider.contentScaleMode = UIViewContentMode.scaleAspectFill
        imageSlider.pageIndicatorPosition = .init(horizontal: .center, vertical: .bottom)
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapImage))
        imageSlider.addGestureRecognizer(gestureRecognizer)
        return imageSlider
    }()
    
    private let backButton: BackButton = .init()
    private let likeButton: LikeButton = .init()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Title"
        label.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    private let descriptionTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Description"
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textAlignment = .left
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .gray
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    private let parametersTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Parameters"
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textAlignment = .left
        return label
    }()
    
    private let parametersView = ParametersView()
    
    private let mapTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Location"
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textAlignment = .left
        return label
    }()
    
    private let locationWithImageView: LabelWithLeftImageView = {
        let label = LabelWithLeftImageView()
        label.image = Assets.location.image
        label.imageSize = 15
        label.titleFont = UIFont.systemFont(ofSize: 13, weight: .semibold)
        label.titleColor = UIColor.gray
        label.spacing = 5
        return label
    }()
    
    private let userImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Assets.person.image
        imageView.backgroundColor = Colors.lightGray.color
        imageView.contentMode = .center
        imageView.layer.borderWidth = 1.5
        imageView.layer.cornerRadius = 10
        return imageView
    }()
    
    private let usernameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        return label
    }()
    
    private let userStatusLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        label.textColor = .gray
        return label
    }()
    
    private let messageButton: BaseButton = {
        let button = BaseButton()
        button.buttonColor = Colors.teal.color.withAlphaComponent(0.3)
        button.setImage(UIImage(systemName: Constants.messageImageSFPath), for: .normal)
        button.imageView?.tintColor = Colors.teal.color
        button.layer.cornerRadius = 10
        button.tintColor = Colors.teal.color
        return button
    }()
    
    private let callButton: BaseButton = {
        let button = BaseButton()
        button.buttonColor = Colors.teal.color.withAlphaComponent(0.3)
        button.setImage(UIImage(systemName: Constants.phoneImageSFPath), for: .normal)
        button.imageView?.tintColor = Colors.teal.color
        button.layer.cornerRadius = 10
        return button
    }()
    
    private let bottomView: UIView = {
        let view = UIView()
        let blurEffect = UIBlurEffect(style: .prominent)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.frame
        blurEffectView.layer.masksToBounds = true
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(blurEffectView)
        return view
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.textAlignment = .left
        return label
    }()
    
    private let actionButton: MainButton = .init(title: "Add items")
    
    init(viewModel: StorageDescriptionViewModel) {
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View controller lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        _scrollView.delegate = self
        // disable hero delegate to enable default UIKit back gesture
        navigationController?.interactivePopGestureRecognizer?.delegate = nil
    }
    
    override func setNavigationLeftBarButton() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: likeButton)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
        
        hideNavigationBar()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
        
        showNavigationBar()
    }
    
    // MARK: - Methods
    
    override func setupUI() {
        super.setupUI()
        _scrollView.contentInsetAdjustmentBehavior = .never
        setData()
        
        setupImageView()
        setupTitle()
        setupParameters()
        setupMap()
        setupProfileView()
        setupBottomView()
        addSpaceView(withSpacing: 100)
    }
    
    override func bind() {
        backButton.rx.tap.bind { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }.disposed(by: disposeBag)
    }
    
    private func setData() {
        setImages()
        imageSliderView.heroID = String(viewModel.storageItem.id)
        descriptionLabel.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua"
        parametersView.addParameter(parameter: "Type", value: "storage")
        parametersView.addParameter(parameter: "Size", value: StringUtils.textWithSymbol(text: "300", symbol: GlobalConstants.m))
        parametersView.addParameter(parameter: "Available time", value: "9:00 - 16:00")
        locationWithImageView.text = "Almaty, Kazakhstan"
        usernameLabel.text = "Firstname Lastname"
        userStatusLabel.text = "Owner"
        priceLabel.text = StringUtils.textWithSymbol(text: "100", symbol: GlobalConstants.tgm)
    }
    
    private func hideNavigationBar() {
        // change status bar style
        UIApplication.shared.statusBarStyle = .lightContent
        
        // Make the navigation bar background clear
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        
        backButton.showShadows()
        likeButton.showShadows()
    }
    
    private func showNavigationBar() {
        // change status bar style
        UIApplication.shared.statusBarStyle = .darkContent
        
        // Restore the navigation bar to default
        navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
        navigationController?.navigationBar.shadowImage = nil
        
        backButton.hideShadows()
        likeButton.hideShadows()
    }
    
    private func setImages() {
        var sdWebImageSource: [SDWebImageSource] = []
        for imageStringUrl in viewModel.storageItem.images {
            sdWebImageSource.append(SDWebImageSource(urlString: imageStringUrl)!)
        }
        imageSliderView.setImageInputs(sdWebImageSource)
    }
    
    @objc func didTapImage() {
        let fullScreenController = imageSliderView.presentFullScreenController(from: self)
        fullScreenController.slideshow.activityIndicator = DefaultActivityIndicator(style: UIActivityIndicatorView.Style.medium, color: nil)
    }

}

// MARK: - UI functions
private extension StorageDescriptionViewController {
    
    // MARK: - ImageView setup
    func setupImageView() {
        addView(view: imageSliderView)
        imageSliderView.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.height.equalTo(350)
        }
    }
    
    // MARK: - Title and description setup
    func setupTitle() {
        addSpaceView(withSpacing: 15)
        addView(view: titleLabel)
        titleLabel.snp.makeConstraints {
            $0.left.equalToSuperview().offset(20)
            $0.right.equalToSuperview().offset(-20)
        }

        addSpaceView(withSpacing: 15)
        addView(view: descriptionTitleLabel)
        descriptionTitleLabel.snp.makeConstraints {
            $0.left.equalToSuperview().offset(20)
            $0.right.equalToSuperview().offset(-20)
        }
        
        addSpaceView(withSpacing: 10)
        addView(view: descriptionLabel)
        descriptionLabel.snp.makeConstraints {
            $0.left.equalToSuperview().offset(20)
            $0.right.equalToSuperview().offset(-20)
        }
        addDivider()
    }
    
    // MARK: - ParametersView setup
    func setupParameters() {
        addView(view: parametersTitleLabel)
        parametersTitleLabel.snp.makeConstraints {
            $0.left.equalToSuperview().offset(20)
            $0.right.equalToSuperview().offset(-20)
        }
        
        addSpaceView(withSpacing: 10)
        addView(view: parametersView)
        parametersView.snp.makeConstraints {
            $0.left.equalToSuperview().offset(20)
            $0.right.equalToSuperview().offset(-20)
        }
        addDivider()
    }
    
    // MARK: - map setup
    func setupMap() {
        addView(view: mapTitleLabel)
        mapTitleLabel.snp.makeConstraints {
            $0.left.equalToSuperview().offset(20)
            $0.right.equalToSuperview().offset(-20)
        }
        addSpaceView(withSpacing: 10)
        let camera = GMSCameraPosition.camera(withLatitude: 43.235126, longitude: 76.909736, zoom: 14.0)
        let mapView = GMSMapView.map(withFrame: self.view.frame, camera: camera)
        mapView.layer.cornerRadius = 10
        mapView.settings.scrollGestures = false
        mapView.settings.zoomGestures = false
        mapView.settings.tiltGestures = false
        mapView.settings.rotateGestures = false
        
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: 43.235126, longitude: 76.909736)
        marker.map = mapView
        
        addView(view: mapView)
        mapView.snp.makeConstraints {
            $0.height.equalTo(200)
            $0.left.equalToSuperview().offset(20)
            $0.right.equalToSuperview().offset(-20)
        }
        
        addSpaceView(withSpacing: 10)
        addView(view: locationWithImageView)
        locationWithImageView.snp.makeConstraints {
            $0.left.equalToSuperview().offset(20)
            $0.right.equalToSuperview().offset(-20)
        }
        addDivider()
    }
    
    // MARK: - profile setup
    func setupProfileView() {
        let contentView = UIView()
        addView(view: contentView)
        contentView.snp.makeConstraints {
            $0.height.equalTo(50)
            $0.left.equalToSuperview().offset(20)
            $0.right.equalToSuperview().offset(-20)
        }
        
        contentView.addSubview(userImageView)
        userImageView.snp.makeConstraints {
            $0.size.equalTo(50)
            $0.top.left.bottom.equalToSuperview()
        }
        
        let stackView = UIStackView(arrangedSubviews: [usernameLabel, userStatusLabel])
        stackView.axis = .vertical
        stackView.spacing = 3
        contentView.addSubview(stackView)
        stackView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.left.equalTo(userImageView.snp.right).offset(10)
        }
        
        contentView.addSubview(callButton)
        callButton.snp.makeConstraints {
            $0.right.equalToSuperview()
            $0.centerY.equalToSuperview()
            $0.size.equalTo(40)
        }
        
        contentView.addSubview(messageButton)
        messageButton.snp.makeConstraints {
            $0.right.equalTo(callButton.snp.left).offset(-10)
            $0.centerY.equalToSuperview()
            $0.size.equalTo(40)
        }
    }
    
    // MARK: bottomView setup
    func setupBottomView() {
        view.addSubview(bottomView)
        bottomView.snp.makeConstraints {
            $0.height.equalTo(60 + (UIApplication.shared.windows.first?.safeAreaInsets.bottom ?? 0))
            $0.left.right.bottom.equalToSuperview()
        }
        
        let divider = DividerView()
        view.addSubview(divider)
        divider.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.bottom.equalTo(bottomView.snp.top)
        }
        
        bottomView.addSubview(actionButton)
        actionButton.snp.makeConstraints {
            $0.width.equalTo(200)
            $0.top.equalToSuperview().offset(10)
            $0.right.equalToSuperview().offset(-20)
            $0.bottom.equalToSuperview().offset(-(UIApplication.shared.windows.first?.safeAreaInsets.bottom ?? 0) - 10)
        }

        bottomView.addSubview(priceLabel)
        priceLabel.snp.makeConstraints {
            $0.centerY.equalTo(actionButton.snp.centerY)
            $0.left.equalToSuperview().offset(20)
            $0.width.greaterThanOrEqualTo(0)
            $0.right.equalTo(actionButton.snp.left).offset(-25)
        }
    }
    
    // MARK: - add divider function
    func addDivider() {
        let view = DividerView()
        addSpaceView(withSpacing: 15)
        addView(view: view)
        addSpaceView(withSpacing: 15)
        
        view.snp.makeConstraints {
            $0.left.equalToSuperview().offset(20)
            $0.right.equalToSuperview().offset(-20)
        }
    }
}

// MARK: - ScrollView delegate
extension StorageDescriptionViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let navBarHeight = (view.window?.windowScene?.statusBarManager?.statusBarFrame.size.height ?? 0) + (navigationController?.navigationBar.frame.height ?? 0.0)
        if scrollView.contentOffset.y + navBarHeight > 350 {
            showNavigationBar()
        } else {
            hideNavigationBar()
        }
    }
}
