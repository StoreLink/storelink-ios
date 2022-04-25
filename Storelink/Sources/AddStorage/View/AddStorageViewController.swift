//
//  AddStorageViewController.swift
//  Storelink
//
//  Created by Акан Акиш on 18.04.2021.
//  Copyright © 2021 Акан Акиш. All rights reserved.
//

import BSImagePicker
import Photos
import RxCocoa
import RxSwift
import UIKit

typealias Coordinate = (longitude: Double, latitude: Double)

final class AddStorageViewController: ScrollViewController {
    private let viewModel: AddStorageViewModel
    private let nameValue: BehaviorRelay<String?> = .init(value: nil)
    private let descriptionValue: BehaviorRelay<String?> = .init(value: nil)
    private let availableTimeValue: BehaviorRelay<String?> = .init(value: nil)
    private let priceValue: BehaviorRelay<String?> = .init(value: nil)
    private let sizeValue: BehaviorRelay<String?> = .init(value: nil)
    private let coordinateValue: BehaviorRelay<Coordinate?> = .init(value: nil)
    private let storageTypeValue: BehaviorRelay<String?> = .init(value: nil)
    private let imageTypeValue: BehaviorRelay<String?> = .init(value: nil)
    private var photoAssets = [PHAsset]()
    private var photoArray = [UIImage]()

    private let closeBarButtonItem: UIBarButtonItem = {
        let barButton = UIBarButtonItem()
        barButton.image = Assets.close.image
        barButton.tintColor = .black
        return barButton
    }()

    private let nameTextField: BaseTextField = {
        let textField = BaseTextField()
        textField.placeholder = "Name"
        textField.autocorrectionType = .no
        return textField
    }()

    private let descriptionTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Description"
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        return label
    }()

    private let descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.autocorrectionType = .no
        textView.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        textView.textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        textView.layer.borderWidth = 1
        textView.layer.cornerRadius = 4
        textView.layer.borderColor = UIColor.lightGray.cgColor
        return textView
    }()

    private let availableTimeTextField: BaseTextField = {
        let textField = BaseTextField()
        textField.placeholder = "Available time"
        return textField
    }()

    private let priceTextField: BaseTextField = {
        let textField = BaseTextField()
        textField.placeholder = "Price" + " " + GlobalConstants.tgm
        return textField
    }()

    private let sizeTextField: BaseTextField = {
        let textField = BaseTextField()
        textField.placeholder = "Size" + " " + GlobalConstants.m
        textField.autocorrectionType = .no
        return textField
    }()

    private lazy var storageTypeButton: BaseButton = {
        let button = BaseButton()
        button.title = "Storage type"
        button.titleColor = .black
        button.titleFont = UIFont.systemFont(ofSize: 15, weight: .medium)
        button.imageView?.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        let leftInset = view.frame.size.width - (button.imageView?.frame.size.width)! - 40 - 15
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: leftInset, bottom: 0, right: 15)
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: (button.imageView?.frame.width)!)
        button.setImage(Assets.downArrow.image, for: .normal)
        button.buttonColor = .white
        button.borderColor = .lightGray
        button.borderWidth = 1
        button.cornerRadius = 4
        return button
    }()

    let photoTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Photo"
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        label.setContentHuggingPriority(.defaultLow, for: .horizontal)
        return label
    }()

    let addPhotoButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = Colors.teal.color
        let plusButton = UIImage(systemName: "plus")?.withRenderingMode(.alwaysTemplate)
        button.tintColor = .white
        button.setImage(plusButton, for: .normal)
        return button
    }()

    lazy var photoCollectionView: PhotoCollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 1
        layout.minimumLineSpacing = 1
        let collectionView = PhotoCollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .systemGray5
        collectionView.photoDelegate = self
        return collectionView
    }()

    private let mapTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Select location"
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        return label
    }()

    private lazy var mapView: MapView = {
        let mapView = MapView()
        mapView.mapDelegate = self
        mapView.setCameraPosition(withLatitude: 43.240887, longitude: 76.929203)
        mapView.cornerRadius = 4
        mapView.disableGestures()
        return mapView
    }()

    private let actionButton = MainButton(title: Strings.add)

    init(viewModel: AddStorageViewModel) {
        self.viewModel = viewModel
    }

    @available(*, unavailable)
    required convenience init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Add storage"
    }

    override func setNavigationLeftBarButton() {
        navigationItem.rightBarButtonItem = closeBarButtonItem
    }

    override func setupUI() {
        super.setupUI()

        addSpaceView(withSpacing: 20)
        addView(view: nameTextField)

        nameTextField.snp.makeConstraints {
            $0.left.equalToSuperview().offset(20)
            $0.right.equalToSuperview().offset(-20)
        }

        addSpaceView(withSpacing: 15)
        addView(view: descriptionTitleLabel)
        descriptionTitleLabel.snp.makeConstraints {
            $0.left.equalToSuperview().offset(20)
            $0.right.equalToSuperview().offset(-20)
        }

        addSpaceView(withSpacing: 5)
        addView(view: descriptionTextView)
        descriptionTextView.snp.makeConstraints {
            $0.left.equalToSuperview().offset(20)
            $0.right.equalToSuperview().offset(-20)
            $0.height.equalTo(100)
        }

        addSpaceView(withSpacing: 15)
        addView(view: availableTimeTextField)
        availableTimeTextField.snp.makeConstraints {
            $0.left.equalToSuperview().offset(20)
            $0.right.equalToSuperview().offset(-20)
        }

        addSpaceView(withSpacing: 15)
        addView(view: priceTextField)
        priceTextField.snp.makeConstraints {
            $0.left.equalToSuperview().offset(20)
            $0.right.equalToSuperview().offset(-20)
        }

        addSpaceView(withSpacing: 15)
        addView(view: sizeTextField)
        sizeTextField.snp.makeConstraints {
            $0.left.equalToSuperview().offset(20)
            $0.right.equalToSuperview().offset(-20)
        }

        addSpaceView(withSpacing: 15)
        addView(view: storageTypeButton)
        storageTypeButton.snp.makeConstraints {
            $0.left.equalToSuperview().offset(20)
            $0.right.equalToSuperview().offset(-20)
            $0.height.equalTo(50)
        }

        addSpaceView(withSpacing: 15)
        let containerView = UIStackView(arrangedSubviews: [photoTitleLabel, addPhotoButton])
        containerView.spacing = 5
        containerView.axis = .horizontal
        containerView.alignment = .center
        containerView.distribution = .fillProportionally
        addView(view: containerView)
        containerView.snp.makeConstraints {
            $0.left.equalToSuperview().offset(20)
            $0.right.equalToSuperview().offset(-20)
        }

        addPhotoButton.snp.makeConstraints {
            $0.size.equalTo(24)
        }
        addPhotoButton.layer.cornerRadius = 12

        addSpaceView(withSpacing: 10)
        addView(view: photoCollectionView)
        photoCollectionView.snp.makeConstraints {
            $0.left.equalToSuperview().offset(20)
            $0.right.equalToSuperview().offset(-20)
            $0.height.equalTo(70)
        }

        addSpaceView(withSpacing: 15)
        addView(view: mapTitleLabel)
        mapTitleLabel.snp.makeConstraints {
            $0.left.equalToSuperview().offset(20)
            $0.right.equalToSuperview().offset(-20)
        }

        addSpaceView(withSpacing: 10)
        addView(view: mapView)
        mapView.snp.makeConstraints {
            $0.left.equalTo(20)
            $0.right.equalTo(-20)
            $0.height.equalTo(200)
        }

        view.addSubview(actionButton)
        actionButton.snp.makeConstraints {
            $0.left.equalToSuperview().offset(20)
            $0.right.equalToSuperview().offset(-20)
            $0.bottom.equalToSuperview().offset(-30)
            $0.height.equalTo(50)
        }

        _scrollView.snp.remakeConstraints {
            $0.top.left.right.equalToSuperview()
            $0.bottom.equalTo(actionButton.snp.top).offset(-15)
        }
    }

    override func bind() {
        viewModel.loading
            .asObservable()
            .bind { [weak self] loading in
                loading ? self?.startLoader() : self?.stopLoader()
            }
            .disposed(by: disposeBag)

        closeBarButtonItem.rx.tap.bind { [weak self] in
            self?.dismiss(animated: true, completion: nil)
        }
        .disposed(by: disposeBag)

        storageTypeButton.rx.tap.bind { [weak self] in
            self?.showActionSheet()
        }
        .disposed(by: disposeBag)

        addPhotoButton.rx.tap.bind { [weak self] in
            self?.presentImagePicker()
        }
        .disposed(by: disposeBag)

        nameTextField.rx.text
            .asObservable()
            .bind(to: nameValue)
            .disposed(by: disposeBag)

        descriptionTextView.rx.text
            .asObservable()
            .bind(to: descriptionValue)
            .disposed(by: disposeBag)

        availableTimeTextField.rx.text
            .asObservable()
            .bind(to: availableTimeValue)
            .disposed(by: disposeBag)

        priceTextField.rx.text
            .asObservable()
            .bind(to: priceValue)
            .disposed(by: disposeBag)

        sizeTextField.rx.text
            .asObservable()
            .bind(to: sizeValue)
            .disposed(by: disposeBag)

        storageTypeValue
            .asObservable()
            .filter { $0 != nil }
            .subscribe(onNext: { [weak self] type in
                self?.storageTypeButton.title = type
            })
            .disposed(by: disposeBag)

        let actionButtonTrigger: Observable<Void> = actionButton.rx.tap
            .asObservable()
            .filter { self.dataValidation() }

        let input = AddStorageViewModel.Input(nameValue: nameValue.asObservable().filterNil(),
                                              descriptionValue: descriptionValue.asObservable().filterNil(),
                                              availableTimeValue: availableTimeValue.asObservable().filterNil(),
                                              priceValue: priceValue.asObservable().filterNil(),
                                              sizeValue: sizeValue.asObservable().filterNil(),
                                              storageTypeValue: storageTypeValue.asObservable().filterNil(),
                                              imageValue: imageTypeValue.asObservable().filterNil(),
                                              coordinateValue: coordinateValue.asObservable().filterNil(),
                                              actionButtonTrigger: actionButtonTrigger)
        let output = viewModel.transform(input: input)

        output.storageAdded
            .subscribe(onNext: { [weak self] in
                self?.dismiss(animated: true, completion: nil)
            })
            .disposed(by: disposeBag)
    }

    private func dataValidation() -> Bool {
        var isDataCorrect = true

        if let name = nameValue.value, name.isEmpty {
            nameTextField.showError()
            isDataCorrect = false
        } else {
            nameTextField.hideError()
        }

        if let description = descriptionValue.value, description.isEmpty {
            descriptionTextView.layer.borderColor = UIColor.red.cgColor
            isDataCorrect = false
        } else {
            descriptionTextView.layer.borderColor = UIColor.lightGray.cgColor
        }

        if let availableTime = availableTimeValue.value, availableTime.isEmpty {
            availableTimeTextField.showError()
            isDataCorrect = false
        } else {
            availableTimeTextField.hideError()
        }

        if let price = priceValue.value, price.isEmpty {
            priceTextField.showError()
            isDataCorrect = false
        } else {
            priceTextField.hideError()
        }

        if let size = priceValue.value, size.isEmpty {
            sizeTextField.showError()
            isDataCorrect = false
        } else {
            sizeTextField.hideError()
        }

        if storageTypeValue.value == nil {
            storageTypeButton.layer.borderColor = UIColor.red.cgColor
            isDataCorrect = false
        } else {
            storageTypeButton.layer.borderColor = UIColor.lightGray.cgColor
        }

        return isDataCorrect
    }

    private func showActionSheet() {
        let alertController = UIAlertController(title: nil, message: "Select type", preferredStyle: .actionSheet)

        alertController.addAction(UIAlertAction(title: "Hangar", style: .default, handler: { action in
            self.storageTypeValue.accept(action.title)
        }))
        alertController.addAction(UIAlertAction(title: "Container", style: .default, handler: { action in
            self.storageTypeValue.accept(action.title)
        }))
        alertController.addAction(UIAlertAction(title: "Garage", style: .default, handler: { action in
            self.storageTypeValue.accept(action.title)
        }))
        alertController.addAction(UIAlertAction(title: "House", style: .default, handler: { action in
            self.storageTypeValue.accept(action.title)
        }))
        alertController.addAction(UIAlertAction(title: "Flat", style: .default, handler: { action in
            self.storageTypeValue.accept(action.title)
        }))

        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alertController.pruneNegativeWidthConstraints()
        present(alertController, animated: true, completion: nil)
    }

    private func presentImagePicker() {
        let imagePicker = ImagePickerController()

        presentImagePicker(imagePicker, select: { _ in
            // User selected an asset. Do something with it. Perhaps begin processing/upload?
        }, deselect: { _ in
            // User deselected an asset. Cancel whatever you did when asset was selected.
        }, cancel: { _ in
            // User canceled selection.
        }, finish: { assets in
            for i in 0 ..< assets.count {
                self.photoAssets.append(assets[i])
            }
            self.convertAssetsToImages()
            self.photoCollectionView.setImages(images: self.photoArray)
        })
    }

    private func convertAssetsToImages() {
        if photoAssets.count == 0 {
            return
        }

        for i in 0 ..< photoAssets.count {
            let options = PHImageRequestOptions()
            options.isSynchronous = true
            PHImageManager.default().requestImage(for: photoAssets[i], targetSize: PHImageManagerMaximumSize, contentMode: .aspectFit, options: options) { image, _ in

                if let data = image?.jpegData(compressionQuality: 0.8), let pressedImage = UIImage(data: data) {
                    self.photoArray.append(pressedImage)
                    let uuid = UUID().uuidString
                    ImageSaver.saveImage(imageName: uuid, image: pressedImage)
                    self.imageTypeValue.accept(uuid)
                }
            }
        }
        photoAssets.removeAll()
    }
}

extension AddStorageViewController: MapViewDelegate {
    func didTapMapView() {
        let viewController = SelectLocationMapViewController()
        navigationController?.pushViewController(viewController, animated: true)
        viewController.updateLocation = { [weak self] latitude, longitude in
            self?.mapView.setCameraPosition(withLatitude: latitude, longitude: longitude)
            self?.mapView.setSingleMarker(withLatitude: latitude, longitude: longitude)
            self?.coordinateValue.accept(Coordinate(longitude: longitude, latitude: latitude))
        }
    }
}

// Photo delegate
extension AddStorageViewController: PhotoDelegate {
    func deletePhoto(at index: Int) {
        photoArray.remove(at: index)
    }
}
