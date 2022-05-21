import UIKit

final class TitleBarController: UIViewController {
	let viewControllers: [UIViewController] = []
	let container: UIViewController
	var musicBarButtonItem: UIBarButtonItem?
	var podCastBarButtonItem: UIBarButtonItem?

	override init(nibName: String?, bundle: Bundle? ) {
		self.container = UIViewController()
		super.init(nibName: nil, bundle: nil)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .black
		setupNavBar()
		setupViews()
	}
}

// MARK: - Setup UI

extension TitleBarController {
	private func setupNavBar() {
		musicBarButtonItem = makeBarButtonItem(
			text: "Music",
			selector: #selector(musicTapped)
		)

		podCastBarButtonItem = makeBarButtonItem(
			text: "Podcasts",
			selector: #selector(podcastTapped)
		)

		guard
			let musicBarButtonItem = musicBarButtonItem,
			let podCastBarButtonItem = podCastBarButtonItem
		else {
			return
		}

		navigationItem.setLeftBarButtonItems([musicBarButtonItem, podCastBarButtonItem], animated: false)
	}

	private func setupViews() {
		guard let containerView = container.view else { return }
		containerView.translatesAutoresizingMaskIntoConstraints = false
		containerView.backgroundColor = .systemPink

		view.addSubview(containerView)

		NSLayoutConstraint.activate([
			containerView.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 1),
			containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			containerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),

		])

		musicTapped()
	}

	private func makeBarButtonItem(text: String, selector: Selector) -> UIBarButtonItem  {
		let button = UIButton()
		button.translatesAutoresizingMaskIntoConstraints = false
		button.addTarget(self, action: selector, for: .primaryActionTriggered)

		let attributes = [
			NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .largeTitle).withTraits(traits: [.traitBold]),
			NSAttributedString.Key.foregroundColor: UIColor.white]

		let attributedText = NSMutableAttributedString(string: text, attributes: attributes)

		button.setAttributedTitle(attributedText, for: .normal)
		button.contentEdgeInsets = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 16)

		let barButtonItem = UIBarButtonItem(customView: button)

		return barButtonItem
	}
}

// MARK: Actions

extension TitleBarController {
	@objc private func musicTapped() {
		if container.children.first == viewControllers[0] { return }

		container.add(child: viewControllers[0])

		animateTransition(fromVC: viewControllers[1], toVC: viewControllers[0]) {success in
			self.viewControllers[1].remove()
		}

		UIView.animate(withDuration: 0.5) {
			self.musicBarButtonItem?.customView?.alpha = 1.0
			self.podCastBarButtonItem?.customView?.alpha = 0.5
		}
	}

	@objc private func podcastTapped() {
		if container.children.first == viewControllers[1] { return }

		container.add(child: viewControllers[1])

		animateTransition(fromVC: viewControllers[0], toVC: viewControllers[1]) {success in
			self.viewControllers[0].remove()
		}

		UIView.animate(withDuration: 0.5) {
			self.musicBarButtonItem?.customView?.alpha = 0.5
			self.podCastBarButtonItem?.customView?.alpha = 1.0
		}
	}

	func animateTransition(fromVC: UIViewController, toVC: UIViewController, completion: @escaping ((Bool) -> Void)) {
		guard
			let fromView = fromVC.view,
			let fromIndex = getIndex(forViewController: fromVC),
			let toView = toVC.view,
			let toIndex = getIndex(forViewController: toVC)
		else {
			return
		}

		let frame = fromVC.view.frame
		var fromFrameEnd = frame
		var toFrameStart = frame
		fromFrameEnd.origin.x = toIndex > fromIndex ? frame.origin.x - frame.width : frame.origin.x + frame.width
		toFrameStart.origin.x = toIndex > fromIndex ? frame.origin.x + frame.width : frame.origin.x - frame.width
		toView.frame = toFrameStart

		UIView.animate(withDuration: 0.5, animations: {
			fromView.frame = fromFrameEnd
			toView.frame = frame
		}, completion: {success in
			completion(success)
		})
	}

	func getIndex(forViewController vc: UIViewController) -> Int? {
		for (index, thisVC) in viewControllers.enumerated() {
			if thisVC == vc { return index }
		}
		return nil
	}
}
