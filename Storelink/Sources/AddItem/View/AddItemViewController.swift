//
//  AddItemViewController.swift
//  Storelink
//
//  Created by Акан Акиш on 28.05.2021.
//  Copyright © 2021 Акан Акиш. All rights reserved.
//

import BSImagePicker
import Photos
import RxCocoa
import RxSwift
import UIKit

class AddItemViewController: ScrollViewController {
    private let imageValue: BehaviorRelay<String?> = .init(value: nil)
    private let nameValue: BehaviorRelay<String?> = .init(value: nil)
    private let descriptionValue: BehaviorRelay<String?> = .init(value: nil)
    private let countValue: BehaviorRelay<Int?> = .init(value: nil)
    private let sizeValue: BehaviorRelay<Int?> = .init(value: nil)
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

    private let countTextField: BaseTextField = {
        let textField = BaseTextField()
        textField.placeholder = "Count"
        textField.autocorrectionType = .no
        return textField
    }()

    private let sizeTextField: BaseTextField = {
        let textField = BaseTextField()
        textField.placeholder = "Size" + " " + GlobalConstants.m
        textField.autocorrectionType = .no
        return textField
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

    private let actionButton = MainButton(title: Strings.add)

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Add item"
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
        addView(view: countTextField)
        countTextField.snp.makeConstraints {
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
        closeBarButtonItem.rx.tap.bind { [weak self] in
            self?.dismiss(animated: true, completion: nil)
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

        countTextField.rx.text
            .asObservable()
            .filterNil()
            .map { Int($0) }
            .bind(to: countValue)
            .disposed(by: disposeBag)

        sizeTextField.rx.text
            .asObservable()
            .filterNil()
            .map { Int($0) }
            .bind(to: sizeValue)
            .disposed(by: disposeBag)

        actionButton.rx.tap.bind { [weak self] in
            self?.postRequest()
        }
        .disposed(by: disposeBag)
    }

    private func postRequest() {
        guard let name = nameValue.value,
              let description = descriptionValue.value,
              let count = countValue.value,
              let image = imageValue.value,
              let size = sizeValue.value else { return }

        let request = ItemRequest(name: name, description: description, count: count, image: image, size: size)

        NetworkManager.shared.postItem(request: request)
            .subscribe { [weak self] in
                self?.dismiss(animated: true, completion: nil)
            } onError: { error in
                print(error)
            }
            .disposed(by: disposeBag)
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
                    self.imageValue.accept(uuid)
                }
            }
        }
        photoAssets.removeAll()
    }
}

// Photo delegate
extension AddItemViewController: PhotoDelegate {
    func deletePhoto(at index: Int) {
        photoArray.remove(at: index)
    }
}
