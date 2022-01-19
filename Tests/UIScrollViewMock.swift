import UIKit

final class UIScrollViewMock: UIScrollView {
    var mockedAdjustedContentInset = UIEdgeInsets.zero

    // MARK: - UIScrollView

    override var adjustedContentInset: UIEdgeInsets { mockedAdjustedContentInset }
}
