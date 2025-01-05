//
//  AttachmentVC+UICollectionViewDelegate.swift
//  AttachX
//
//  Created by Arkaprava Ghosh on 06/01/25.
//

import UIKit

// MARK: - UICollectionViewDelegate & UICollectionViewDataSource
extension AttachmentViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return options.count
    }

    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AttachmentOptionCell.identifier, for: indexPath) as? AttachmentOptionCell else {
            return UICollectionViewCell()
        }
        let option = options[indexPath.item]
        cell.configure(with: option)
        return cell
    }

    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedOption = options[indexPath.item]

        switch selectedOption {
        case .takePicture:
            openCamera()
        case .chooseFromPhotos:
            openPhotoPicker()
        case .chooseFromFiles:
            openFilePicker()
        }
    }

    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat = 40
        let availableWidth = collectionView.frame.width - padding
        let itemWidth = (availableWidth / 2) - 20
        return CGSize(width: itemWidth, height: itemWidth)
    }
}
