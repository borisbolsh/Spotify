import UIKit

final class TrackCell: UICollectionViewCell {
	private enum Constants {
		static let trackCellHeight: CGFloat = 72
	}

	private var imageView = UIImageView()
	private var titleLabel = UILabel()
	private var subtitleLabel = UILabel()
	private var stackViewCell = UIStackView()

	var track: Track? {
		didSet {
			guard let track = track else { return }
			let image = UIImage(named: track.imageName) ?? UIImage(named: "placeholder")!

			imageView.image = image
			titleLabel.text = track.title
			subtitleLabel.text = track.artist
		}
	}

	override init(frame: CGRect) {
		super.init(frame: .zero)
		layout()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	func layout() {
		titleLabel.font = UIFont.preferredFont(forTextStyle: .body).withTraits(traits: .traitBold)
		subtitleLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)
		subtitleLabel.alpha = 0.7

		imageView.translatesAutoresizingMaskIntoConstraints = false
		titleLabel.translatesAutoresizingMaskIntoConstraints = false
		subtitleLabel.translatesAutoresizingMaskIntoConstraints = false

		stackViewCell = makeStackView(axis: .vertical)
		stackViewCell.spacing = 6
		stackViewCell.addArrangedSubview(titleLabel)
		stackViewCell.addArrangedSubview(subtitleLabel)

		addSubview(imageView)
		addSubview(stackViewCell)

		NSLayoutConstraint.activate([
			imageView.topAnchor.constraint(equalTo: topAnchor),
			imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
			imageView.heightAnchor.constraint(equalToConstant: Constants.trackCellHeight),
			imageView.widthAnchor.constraint(equalToConstant: Constants.trackCellHeight),

			stackViewCell.centerYAnchor.constraint(equalTo: centerYAnchor),
			stackViewCell.leadingAnchor.constraint(equalToSystemSpacingAfter: imageView.trailingAnchor, multiplier: 2),
			trailingAnchor.constraint(equalToSystemSpacingAfter: stackViewCell.trailingAnchor, multiplier: 3)
		])
	}

	func makeStackView(axis: NSLayoutConstraint.Axis) -> UIStackView {
		let stack = UIStackView()
		stack.translatesAutoresizingMaskIntoConstraints = false
		stack.axis = axis
		stack.spacing = 8.0

		return stack
	}
}
