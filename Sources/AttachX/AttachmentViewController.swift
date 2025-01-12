import UIKit
import PhotosUI
import MobileCoreServices


// MARK: - Protocol
public protocol AttachmentViewControllerDelegate: AnyObject {
    func didSelectAttachmentOption(_ option: AttachmentOption, fileType: String?, fileData: Data?, fileURL: URL?)
}

// MARK: - Enum
public enum AttachmentOption {
    case takePicture
    case chooseFromPhotos
    case chooseFromFiles
}

// MARK: - AttachmentViewController
public class AttachmentViewController: UIViewController {
    
    public weak var delegate: AttachmentViewControllerDelegate?
    
    public let options: [AttachmentOption] = [
        .takePicture,
        .chooseFromPhotos,
        .chooseFromFiles
    ]
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 20
        layout.minimumInteritemSpacing = 20
        layout.sectionInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .white
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(AttachmentOptionCell.self, forCellWithReuseIdentifier: AttachmentOptionCell.identifier)
        return collectionView
    }()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = NSLocalizedString("Add Attachment", comment: "Title for attachment view controller")
        
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func openFilePicker() {
        let documentPicker = UIDocumentPickerViewController(forOpeningContentTypes: [.item], asCopy: true)
        documentPicker.delegate = self
        documentPicker.allowsMultipleSelection = false
        present(documentPicker, animated: true)
    }
    
    func openCamera() {
        guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
            showAlert(title: NSLocalizedString("Error", comment: "Error title"), message: NSLocalizedString("Camera is not available.", comment: "Camera not available message"))
            return
        }
        
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .camera
        imagePicker.delegate = self
        present(imagePicker, animated: true)
    }
    
    func openPhotoPicker() {
        var configuration = PHPickerConfiguration()
        configuration.selectionLimit = 1
        configuration.filter = .images
        
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = self
        present(picker, animated: true)
    }
    
    public func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "OK action"), style: .default))
        present(alert, animated: true)
    }
}

#Preview {
    AttachmentViewController(nibName: nil, bundle: nil)
}
