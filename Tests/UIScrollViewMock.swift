import UIKit

class UIScrollViewMock: UIScrollView {

    var mockedAdjustedContentInset = UIEdgeInsets.zero

    // MARK: UIScrollView

    override var adjustedContentInset: UIEdgeInsets {
        return mockedAdjustedContentInset
    }

}
