//
//  AttachmentVC+ImagePickerView.swift
//  AttachX
//
//  Created by Arkaprava Ghosh on 06/01/25.
//

import UIKit

// MARK: - UIDocumentPickerDelegate
extension AttachmentViewController: UIDocumentPickerDelegate {
    public func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        guard let selectedFile = urls.first else {
            return
        }

        // Read file data
        do {
            let fileData = try Data(contentsOf: selectedFile)
            // Return the option, file type, file data, and URL
            delegate?.didSelectAttachmentOption(.chooseFromFiles, fileType: selectedFile.pathExtension, fileData: fileData, fileURL: selectedFile)
        } catch {
            showAlert(title: NSLocalizedString("Error", comment: "Error title"), message: NSLocalizedString("Failed to load file data.", comment: "File load error message"))
            delegate?.didSelectAttachmentOption(.chooseFromFiles, fileType: nil, fileData: nil, fileURL: nil)
        }
    }

    public func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        delegate?.didSelectAttachmentOption(.chooseFromFiles, fileType: nil, fileData: nil, fileURL: nil)
    }
}
