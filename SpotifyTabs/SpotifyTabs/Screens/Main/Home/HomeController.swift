import UIKit

final class HomeController: UIViewController {
	private let menuBar: MenuBar
	private let colors: [UIColor] = [.systemRed, .systemBlue, .systemTeal]
	private let music: [[Track]] = [Track.playlists, Track.artists, Track.albums]
	private var collectionView: UICollectionView?

	override init(nibName: String?, bundle: Bundle?) {
		self.menuBar = MenuBar()
		super.init(nibName: nil, bundle: nil)
		self.collectionView = setupCollectionView()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .spotifyBlack
		menuBar.delegate = self
		layout()
	}

	private func layout() {
		guard
			let collectionView = collectionView
		else {
			return
		}
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

	private func setupCollectionView() -> UICollectionView {
		let layout = UICollectionViewFlowLayout()
		layout.scrollDirection = .horizontal
		layout.minimumLineSpacing = 0

		let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
		collectionView.translatesAutoresizingMaskIntoConstraints = false
		collectionView.register(PlaylistCell.self, forCellWithReuseIdentifier: String(describing: PlaylistCell.self))
		collectionView.backgroundColor = .spotifyBlack
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
		cell?.configure(
			items: music[indexPath.item],
			backgroundColor: colors[indexPath.item]
		)
		return cell ?? UICollectionViewCell()
	}
}

extension HomeController: UICollectionViewDelegateFlowLayout {
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		return CGSize(width: view.frame.width, height: collectionView.frame.height)
	}

	func scrollViewDidScroll(_ scrollView: UIScrollView) {
		menuBar.scrollIndicator(to: scrollView.contentOffset)
	}
}

extension HomeController: MenuBarDelegate {
	func didSelectItemAt(index: Int) {
		guard
			let collectionView = collectionView
		else {
			return
		}
		let indexPath = IndexPath(item: index, section: 0)
		collectionView.scrollToItem(at: indexPath, at: [], animated: true)
	}
}
