// The Swift Programming Language
// https://docs.swift.org/swift-book
// MARK: - AttachmentOptionCell
import UIKit
public class AttachmentOptionCell: UICollectionViewCell {

    static let identifier = "AttachmentOptionCell"
    
    private let titleIcon : UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.accessibilityIdentifier = "optionTitleLabel"
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .systemGray6
        contentView.layer.cornerRadius = 8
        contentView.layer.masksToBounds = true
        contentView.layer.borderWidth = 0.5
        contentView.layer.borderColor = UIColor.lightGray.cgColor
        contentView.addSubview(titleLabel)
        contentView.addSubview(titleIcon)

        NSLayoutConstraint.activate([
            titleIcon.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            titleIcon.topAnchor.constraint(greaterThanOrEqualTo: contentView.topAnchor,constant: 16),
            titleIcon.widthAnchor.constraint(equalToConstant: 24),
            titleIcon.bottomAnchor.constraint(equalTo: contentView.centerYAnchor,constant: -8),
            
            titleLabel.leadingAnchor.constraint(greaterThanOrEqualTo: contentView.leadingAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -8),
            titleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: contentView.centerYAnchor,constant: 8),
            titleLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor,constant: -8),
            
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with option: AttachmentOption) {
        switch option {
        case .takePicture:
            titleIcon.image = UIImage(systemName: "camera.shutter.button.fill")
            titleLabel.text = NSLocalizedString("Take a Picture", comment: "Option to take a picture")
        case .chooseFromPhotos:
            titleIcon.image = UIImage(systemName: "photo.badge.plus")
            titleLabel.text = NSLocalizedString("Choose from Photos", comment: "Option to choose from photos")
        case .chooseFromFiles:
            titleIcon.image = UIImage(systemName: "document.badge.plus.fill")
            titleLabel.text = NSLocalizedString("Choose from Files", comment: "Option to choose from files")
        }
    }
}
