import UIKit

final class TrackCell: UICollectionViewCell {
	private enum Constants {
		static let trackCellHeight: CGFloat = 72
		static let trackCellId = "trackId"
	}

	private var imageView = UIImageView()
	private var titleLabel = UILabel()
	private var subtitleLabel = UILabel()

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

		let stackView = makeStackView(axis: .vertical)
		stackView.spacing = 6
		stackView.addArrangedSubview(titleLabel)
		stackView.addArrangedSubview(subtitleLabel)

		addSubview(imageView)
		addSubview(stackView)

		NSLayoutConstraint.activate([
			imageView.topAnchor.constraint(equalTo: topAnchor),
			imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
			imageView.heightAnchor.constraint(equalToConstant: Constants.trackCellHeight),
			imageView.widthAnchor.constraint(equalToConstant: Constants.trackCellHeight),

			stackView.centerYAnchor.constraint(equalTo: centerYAnchor),
			stackView.leadingAnchor.constraint(equalToSystemSpacingAfter: imageView.trailingAnchor, multiplier: 2),
			trailingAnchor.constraint(equalToSystemSpacingAfter: stackView.trailingAnchor, multiplier: 3)
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
