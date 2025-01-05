//
//  AttachmentVC+UIImagePickerController.swift
//  AttachX
//
//  Created by Arkaprava Ghosh on 06/01/25.
//
import UIKit

// MARK: - UIImagePickerControllerDelegate & UINavigationControllerDelegate
extension AttachmentViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        if let image = info[.originalImage] as? UIImage, let imageData = image.jpegData(compressionQuality: 1.0) {
            // Return the option, file type, and image data
            delegate?.didSelectAttachmentOption(.takePicture, fileType: "image/jpeg", fileData: imageData, fileURL: nil)
        } else {
            // Return the file URL if it's available
            if let imageURL = info[.imageURL] as? URL {
                do {
                    let fileData = try Data(contentsOf: imageURL)
                    delegate?.didSelectAttachmentOption(.takePicture, fileType: nil, fileData: fileData, fileURL: imageURL)
                } catch {
                    delegate?.didSelectAttachmentOption(.takePicture, fileType: nil, fileData: nil, fileURL: imageURL)
                }
            } else {
                delegate?.didSelectAttachmentOption(.takePicture, fileType: nil, fileData: nil, fileURL: nil)
            }
        }
        picker.dismiss(animated: true)
    }

    public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        delegate?.didSelectAttachmentOption(.takePicture, fileType: nil, fileData: nil, fileURL: nil)
        picker.dismiss(animated: true)
    }
}
