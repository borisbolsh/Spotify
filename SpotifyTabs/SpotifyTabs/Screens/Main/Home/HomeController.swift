import UIKit

final class HomeController: UIViewController {

	private struct Constants {
		static let cellId = "ItemId"
	}

	private let menuBar: UIView
	private let colors: [UIColor] = [.systemRed, .systemBlue, .systemTeal]
	private let music: [[Track]] = [playlists, artists, albums]
	private lazy var collectionView: UICollectionView = setupCollectionVC()

	override init(nibName: String?, bundle: Bundle? ) {
		self.menuBar = MenuBar()
		super.init(nibName: nil, bundle: nil)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func viewDidLoad() {
		super.viewDidLoad()
//		view.backgroundColor = .spotifyBlack
//		menuBar.delegate = self
//
		layout()
	}

	private func layout() {
		menuBar.translatesAutoresizingMaskIntoConstraints = false
		view.addSubview(menuBar)
		view.addSubview(collectionView)

		NSLayoutConstraint.activate([
			// menubar
			menuBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
			menuBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			menuBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			menuBar.heightAnchor.constraint(equalToConstant: 42),

			// collection view
			collectionView.topAnchor.constraint(equalToSystemSpacingBelow: menuBar.bottomAnchor, multiplier: 2),
			collectionView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 0),
			view.trailingAnchor.constraint(equalToSystemSpacingAfter: collectionView.trailingAnchor, multiplier: 0),
			view.safeAreaLayoutGuide.bottomAnchor.constraint(equalToSystemSpacingBelow: collectionView.bottomAnchor, multiplier: 0)
		])
	}

	private func setupCollectionVC() -> UICollectionView {
		let layout = UICollectionViewFlowLayout()
		layout.scrollDirection = .horizontal
		layout.minimumLineSpacing = 0

		let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
		collectionView.translatesAutoresizingMaskIntoConstraints = false
//		collectionView.register(PlaylistCell.self, forCellWithReuseIdentifier: playlistCellId)
//		collectionView.backgroundColor = .spotifyBlack
		collectionView.isPagingEnabled = true
		collectionView.dataSource = self
		collectionView.delegate = self

		return collectionView
	}
}

extension HomeController: UICollectionViewDataSource {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return music.count
	}

	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: PlaylistCell.self), for: indexPath) as? PlaylistCell
		cell?.backgroundColor = colors[indexPath.item]
		cell?.tracks = music[indexPath.item]
		return cell ?? UICollectionViewCell()
	}
}

extension HomeController: UICollectionViewDelegateFlowLayout {}
