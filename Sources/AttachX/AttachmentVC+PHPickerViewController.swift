//
//  AttachmentVC+PHPickerViewController.swift
//  AttachX
//
//  Created by Arkaprava Ghosh on 06/01/25.
//
import PhotosUI

// MARK: - PHPickerViewControllerDelegate
extension AttachmentViewController: PHPickerViewControllerDelegate {
    public func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)
        guard let result = results.first else {
            delegate?.didSelectAttachmentOption(.chooseFromPhotos, fileType: nil, fileData: nil, fileURL: nil)
            return
        }

        if result.itemProvider.canLoadObject(ofClass: UIImage.self) {
            result.itemProvider.loadFileRepresentation(forTypeIdentifier: UTType.image.identifier) { url, error in
                DispatchQueue.main.async {
                    if let fileURL = url {
                        do {
                            let fileData = try Data(contentsOf: fileURL)
                            self.delegate?.didSelectAttachmentOption(.chooseFromPhotos, fileType: "image/jpeg", fileData: fileData, fileURL: fileURL)
                        } catch {
                            self.showAlert(title: NSLocalizedString("Error", comment: "Error title"), message: NSLocalizedString("Failed to load file data.", comment: "File load error message"))
                            self.delegate?.didSelectAttachmentOption(.chooseFromPhotos, fileType: nil, fileData: nil, fileURL: nil)
                        }
                    } else {
                        self.delegate?.didSelectAttachmentOption(.chooseFromPhotos, fileType: nil, fileData: nil, fileURL: nil)
                    }
                }
            }
        }
    }
}
