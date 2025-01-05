// The Swift Programming Language
// https://docs.swift.org/swift-book
// MARK: - AttachmentOptionCell
import UIKit
public class AttachmentOptionCell: UICollectionViewCell {

    static let identifier = "AttachmentOptionCell"

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textAlignment = .center
        label.accessibilityIdentifier = "optionTitleLabel"
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .systemGray6
        contentView.layer.cornerRadius = 8
        contentView.layer.masksToBounds = true
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.lightGray.cgColor
        contentView.addSubview(titleLabel)

        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with option: AttachmentOption) {
        switch option {
        case .takePicture:
            titleLabel.text = NSLocalizedString("Take a Picture", comment: "Option to take a picture")
        case .chooseFromPhotos:
            titleLabel.text = NSLocalizedString("Choose from Photos", comment: "Option to choose from photos")
        case .chooseFromFiles:
            titleLabel.text = NSLocalizedString("Choose from Files", comment: "Option to choose from files")
        }
    }
}
