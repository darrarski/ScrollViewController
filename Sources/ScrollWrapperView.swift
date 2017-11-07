import UIKit

class ScrollWrapperView: UIView {

    init() {
        super.init(frame: .zero)
    }

    required init?(coder aDecoder: NSCoder) {
        return nil
    }

    // MARK: Subviews

    let scrollView = Factory.scrollView

}

private extension ScrollWrapperView {
    struct Factory {
        static var scrollView: UIScrollView {
            let view = UIScrollView(frame: .zero)
            view.keyboardDismissMode = .interactive
            return view
        }
    }
}
