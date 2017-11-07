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

    private let visibleContentLayoutGuide = UILayoutGuide()

    private func setupLayout() {
        addLayoutGuide(visibleContentLayoutGuide)
        visibleContentLayoutGuide.topAnchor.constraint(equalTo: topAnchor).isActive = true
        visibleContentLayoutGuide.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        visibleContentLayoutGuide.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        visibleContentLayoutGuide.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true

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
