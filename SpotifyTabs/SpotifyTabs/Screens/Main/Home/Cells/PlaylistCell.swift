import UIKit

final class PlaylistCell: UICollectionViewCell {
	private struct Constants {
		static let trackCellHeight: CGFloat = 72
	}
}

extension PlaylistCell: UICollectionViewDataSource {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return 7
	}

	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		return UICollectionViewCell()
	}
}

extension PlaylistCell: UICollectionViewDelegateFlowLayout {}
