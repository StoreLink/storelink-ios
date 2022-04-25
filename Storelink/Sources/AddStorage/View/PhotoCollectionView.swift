//
//  PhotoCollectionView.swift
//  Storelink
//
//  Created by Акан Акиш on 28.05.2021.
//  Copyright © 2021 Акан Акиш. All rights reserved.
//

import UIKit

protocol PhotoDelegate {
    func deletePhoto(at index: Int)
}

final class PhotoCollectionView: UICollectionView {
    enum Constants {
        static let cellIdentifier = "photoCollectioncell"
    }

    var photoDelegate: PhotoDelegate?

    var images: [UIImage] = [] {
        didSet {
            reloadData()
        }
    }

    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: Constants.cellIdentifier)
        delegate = self
        dataSource = self
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setImages(images: [UIImage]) {
        self.images = images
    }

    @objc func deleteButtonTapped(_ sender: UIButton) {
        images.remove(at: sender.tag)
        photoDelegate?.deletePhoto(at: sender.tag)
    }
}

// Colection view delegate
extension PhotoCollectionView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_: UICollectionView, numberOfItemsInSection _: Int) -> Int {
        return images.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.cellIdentifier, for: indexPath) as? PhotoCollectionViewCell

        cell?.configure(with: images[indexPath.row])
        cell?.deleteButton.tag = indexPath.row
        cell?.deleteButton.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
        return cell!
    }

    func collectionView(_: UICollectionView, layout _: UICollectionViewLayout, sizeForItemAt _: IndexPath) -> CGSize {
        return CGSize(width: 70, height: 70)
    }
}
