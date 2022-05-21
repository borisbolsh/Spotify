import UIKit

final class PlaylistCell: UICollectionViewCell {
	private enum Constants {
		static let trackCellHeight: CGFloat = 72
		static let trackCellId = "trackId"
	}

	private var tracks: [Track]?
	lazy var collectionView: UICollectionView = setupCollectionVC()

	override init(frame: CGRect) {
		super.init(frame: .zero)
		layout()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	private func setupCollectionVC() -> UICollectionView {
		let layout = UICollectionViewFlowLayout()
		layout.minimumLineSpacing = 16

		let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
		collectionView.translatesAutoresizingMaskIntoConstraints = false
		collectionView.register(TrackCell.self, forCellWithReuseIdentifier: Constants.trackCellId)
		collectionView.backgroundColor = .spotifyBlack
		collectionView.dataSource = self
		collectionView.delegate = self

		return collectionView
	}

	private func layout() {
		addSubview(collectionView)

		NSLayoutConstraint.activate([
			collectionView.topAnchor.constraint(equalTo: topAnchor),
			collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
			collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
			collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
		])
	}
}

//MARK: Configure Cell

extension PlaylistCell {
	func configure(items: [Track], backgroundColor: UIColor?) {
		self.tracks = items
		self.backgroundColor = backgroundColor
	}
}

//MARK: DataSource

extension PlaylistCell: UICollectionViewDataSource {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		guard let tracks = tracks else { return 0 }
		return tracks.count
	}

	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.trackCellId, for: indexPath) as? TrackCell
		cell?.track = tracks?[indexPath.item]
		return cell ?? UICollectionViewCell()
	}
}

//MARK: Delegate

extension PlaylistCell: UICollectionViewDelegateFlowLayout {
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		return CGSize(width: frame.width, height: Constants.trackCellHeight)
	}
}
