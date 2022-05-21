import UIKit

extension UIFont {
	func withTraits(traits: UIFontDescriptor.SymbolicTraits) -> UIFont {
		let descriptor = fontDescriptor.withSymbolicTraits(traits)
		guard let descriptor = descriptor else { return UIFont() }
		return UIFont(descriptor: descriptor, size: 0)
	}

	func bold() -> UIFont {
		return withTraits(traits: .traitBold)
	}
}
