import UIKit

/// UIScrollView wrapper
public class ScrollWrapperView: UIView {

    /// Create wrapper
    public init() {
        super.init(frame: .zero)
        addSubview(scrollView)
        setupLayout()
    }

    /// Does nothing, class is designed to be used programatically
    required public init?(coder aDecoder: NSCoder) {
        return nil
    }

    // MARK: Subviews

    /// Container UIScrollView
    public let scrollView = Factory.scrollView

    /// Scrollable content view
    public var contentView: UIView? {
        didSet {
            oldValue?.removeFromSuperview()
            guard let newValue = contentView else { return }
            scrollView.addSubview(newValue)
            setupLayout(contentView: newValue)
        }
    }

    // MARK: Layout

    /// Visible content insets
    var visibleContentInsets: UIEdgeInsets {
        get {
            return UIEdgeInsets(
                top: visibleContentLayoutGuideTop.constant,
                left: visibleContentLayoutGuideLeft.constant,
                bottom: -visibleContentLayoutGuideBottom.constant,
                right: -visibleContentLayoutGuideRight.constant
            )
        }
        set {
            visibleContentLayoutGuideTop.constant = newValue.top
            visibleContentLayoutGuideLeft.constant = newValue.left
            visibleContentLayoutGuideRight.constant = -newValue.right
            visibleContentLayoutGuideBottom.constant = -newValue.bottom
        }
    }

    private let visibleContentLayoutGuide = UILayoutGuide()
    private var visibleContentLayoutGuideTop: NSLayoutConstraint!
    private var visibleContentLayoutGuideLeft: NSLayoutConstraint!
    private var visibleContentLayoutGuideRight: NSLayoutConstraint!
    private var visibleContentLayoutGuideBottom: NSLayoutConstraint!

    private func setupLayout() {
        addLayoutGuide(visibleContentLayoutGuide)
        visibleContentLayoutGuideTop = visibleContentLayoutGuide.topAnchor.constraint(equalTo: topAnchor)
        visibleContentLayoutGuideLeft = visibleContentLayoutGuide.leftAnchor.constraint(equalTo: leftAnchor)
        visibleContentLayoutGuideRight = visibleContentLayoutGuide.rightAnchor.constraint(equalTo: rightAnchor)
        visibleContentLayoutGuideBottom = visibleContentLayoutGuide.bottomAnchor.constraint(equalTo: bottomAnchor)
        visibleContentLayoutGuideTop.isActive = true
        visibleContentLayoutGuideLeft.isActive = true
        visibleContentLayoutGuideRight.isActive = true
        visibleContentLayoutGuideBottom.isActive = true

        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        scrollView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        scrollView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }

    private func setupLayout(contentView view: UIView) {
        view.translatesAutoresizingMaskIntoConstraints = false
        view.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        view.leftAnchor.constraint(equalTo: scrollView.leftAnchor).isActive = true
        view.rightAnchor.constraint(equalTo: scrollView.rightAnchor).isActive = true
        view.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        view.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        view.heightAnchor.constraint(greaterThanOrEqualTo: visibleContentLayoutGuide.heightAnchor).isActive = true
    }

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
