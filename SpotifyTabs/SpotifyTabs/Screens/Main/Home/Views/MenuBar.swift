import UIKit

protocol MenuBarDelegate: AnyObject {
	func didSelectItemAt(index: Int)
}

final class MenuBar: UIView {
	weak var delegate: MenuBarDelegate?

	private enum Constants {
		static let leadPadding: CGFloat = 16
		static let buttonSpace: CGFloat = 36
	}

	private var playlistsButton: UIButton?
	private var artistsButton: UIButton?
	private var albumsButton: UIButton?
	private var buttons = [UIButton?]()

	private let indicator = UIView()
	private var indicatorLeading: NSLayoutConstraint?
	private var indicatorTrailing: NSLayoutConstraint?

	override init(frame: CGRect) {
		super.init(frame: .zero)
		playlistsButton = makeButton(withText: "Playlists")
		artistsButton = makeButton(withText: "Artists")
		albumsButton = makeButton(withText: "Albums")

		guard let playlistsButton = playlistsButton,
		   let artistsButton = artistsButton,
		   let albumsButton = albumsButton
		else {
			return
		}

		playlistsButton.addTarget(self, action: #selector(playlistsButtonTapped), for: .primaryActionTriggered)
		artistsButton.addTarget(self, action: #selector(artistsButtonTapped), for: .primaryActionTriggered)
		albumsButton.addTarget(self, action: #selector(albumsButtonTapped), for: .primaryActionTriggered)

		styleIndicator()
		setAlpha(for: playlistsButton)
		layout()

		buttons = [playlistsButton, artistsButton, albumsButton]
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	private func layout() {
		guard let playlistsButton = playlistsButton,
		   let artistsButton = artistsButton,
		   let albumsButton = albumsButton
		else {
			return
		}

		addSubview(playlistsButton)
		addSubview(artistsButton)
		addSubview(albumsButton)
		addSubview(indicator)

		NSLayoutConstraint.activate([
			// Buttons
			playlistsButton.topAnchor.constraint(equalTo: topAnchor),
			playlistsButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.leadPadding),
			artistsButton.topAnchor.constraint(equalTo: topAnchor),
			artistsButton.leadingAnchor.constraint(equalTo: playlistsButton.trailingAnchor, constant: Constants.buttonSpace),
			albumsButton.topAnchor.constraint(equalTo: topAnchor),
			albumsButton.leadingAnchor.constraint(equalTo: artistsButton.trailingAnchor, constant: Constants.buttonSpace),

			// bar
			indicator.bottomAnchor.constraint(equalTo: bottomAnchor),
			indicator.heightAnchor.constraint(equalToConstant: 3)
		])

		indicatorLeading = indicator.leadingAnchor.constraint(equalTo: playlistsButton.leadingAnchor)
		indicatorTrailing = indicator.trailingAnchor.constraint(equalTo: playlistsButton.trailingAnchor)

		indicatorLeading?.isActive = true
		indicatorTrailing?.isActive = true
	}

	private func styleIndicator(){
		indicator.translatesAutoresizingMaskIntoConstraints = false
		indicator.backgroundColor = .spotifyGreen
	}

	private func setAlpha(for button: UIButton) {
		playlistsButton?.alpha = 0.5
		artistsButton?.alpha = 0.5
		albumsButton?.alpha = 0.5

		button.alpha = 1.0
	}

	private func makeButton(withText text: String) -> UIButton {
		let button = UIButton()
		button.translatesAutoresizingMaskIntoConstraints = false
		button.setTitle(text, for: .normal)
		button.titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
		button.titleLabel?.adjustsFontSizeToFitWidth = true

		return button
	}
}

// MARK: Actions
extension MenuBar {
	@objc func playlistsButtonTapped() {
		delegate?.didSelectItemAt(index: 0)
	}

	@objc func artistsButtonTapped() {
		delegate?.didSelectItemAt(index: 1)
	}

	@objc func albumsButtonTapped() {
		delegate?.didSelectItemAt(index: 2)
	}

	func selectItem(at index: Int) {
		 animateIndicator(to: index)
	}

	private func animateIndicator(to index: Int) {
		guard let playlistsButton = playlistsButton,
		   let artistsButton = artistsButton,
		   let albumsButton = albumsButton
		else {
			return
		}

		var button: UIButton
		switch index {
		case 0:
			button = playlistsButton
		case 1:
			button = artistsButton
		case 2:
			button = albumsButton
		default:
			button = playlistsButton
		}

		setAlpha(for: button)

		UIView.animate(withDuration: 0.3) {
			self.layoutIfNeeded()
		}
	}

	func scrollIndicator(to contentOffset: CGPoint) {
		let index = Int(contentOffset.x / frame.width)
		let atScrollStart = Int(contentOffset.x) % Int(frame.width) == 0

		if atScrollStart {
			return
		}

		// determine percent scrolled relative to index
		let percentScrolled: CGFloat
		switch index {
		case 0:
			 percentScrolled = contentOffset.x / frame.width - 0
		case 1:
			percentScrolled = contentOffset.x / frame.width - 1
		case 2:
			percentScrolled = contentOffset.x / frame.width - 2
		default:
			percentScrolled = contentOffset.x / frame.width
		}

		// determine buttons
		var fromButton: UIButton
		var toButton: UIButton

		switch index {
		case 2:
			fromButton = buttons[index] ?? UIButton()
			toButton = buttons[index - 1] ?? UIButton()
		default:
			fromButton = buttons[index] ?? UIButton()
			toButton = buttons[index + 1] ?? UIButton()
		}

		// animate alpha of buttons
		switch index {
		case 2:
			break
		default:
			fromButton.alpha = fmax(0.5, (1 - percentScrolled))
			toButton.alpha = fmax(0.5, percentScrolled)
		}

		let fromWidth = fromButton.frame.width
		let toWidth = toButton.frame.width

		// determine width
		let sectionWidth: CGFloat
		switch index {
		case 0:
			sectionWidth = Constants.leadPadding + fromWidth + Constants.buttonSpace
		default:
			sectionWidth = fromWidth + Constants.buttonSpace
		}

		// normalize x scroll
		let sectionFraction = sectionWidth / frame.width
		let x = contentOffset.x * sectionFraction

		let buttonWidthDiff = fromWidth - toWidth
		let widthOffset = buttonWidthDiff * percentScrolled

		// determine leading y
		let y:CGFloat
		switch index {
		case 0:
			if x < Constants.leadPadding {
				y = x
			} else {
				y = x - Constants.leadPadding * percentScrolled
			}
		case 1:
			y = x + 13
		case 2:
			y = x
		default:
			y = x
		}

		// Note: 13 is button width difference between Playlists and Artists button
		// from previous index. Hard coded for now.

		indicatorLeading?.constant = y

		// determine trailing y
		let yTrailing: CGFloat
		switch index {
		case 0:
			yTrailing = y - widthOffset
		case 1:
			yTrailing = y - widthOffset - Constants.leadPadding
		case 2:
			yTrailing = y - widthOffset - Constants.leadPadding / 2
		default:
			yTrailing = y - widthOffset - Constants.leadPadding
		}

		indicatorTrailing?.constant = yTrailing

		print("\(index) percentScrolled=\(percentScrolled)")
	}
}
