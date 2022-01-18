import UIKit

/// UIScrollView wrapper
public class ScrollWrapperView: UIView {

    /// Create wrapper
    public init() {
        super.init(frame: .zero)
        addSubview(scrollView)
        scrollView.addSubview(contentWrapperView)
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
            contentViewTopEqualSuper = nil
            contentViewTopGreaterThanSuper = nil
            guard let newValue = contentView else { return }
            contentWrapperView.addSubview(newValue)
            setupLayout(contentView: newValue)
        }
    }

    let contentWrapperView = UIView()

    // MARK: Layout

    /// Visible content insets
    public var visibleContentInsets: UIEdgeInsets {
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

    // Visible content layout guide
    public let visibleContentLayoutGuide = UILayoutGuide()

    // If true (default), contentView will be stretched to fill visible space
    public var contentViewStretching = true {
        didSet { contentWrapperHeight.isActive = contentViewStretching }
    }

    // If true (defualt is false) the content view will be aligned to the bottom of scrollable area
    public var alignContentToBottom = false {
        didSet {
            contentViewTopGreaterThanSuper?.isActive = alignContentToBottom == true
            contentViewTopEqualSuper?.isActive = alignContentToBottom == false
        }
    }

    // If true (default) touches outside the content view will be handled and allow scrolling
    public var handlesTouchesOutsideContent = true

    public override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        if handlesTouchesOutsideContent {
            return super.hitTest(point, with: event)
        }
        if let contentView = contentView, contentView.bounds.contains(convert(point, to: contentView)) {
            return super.hitTest(point, with: event)
        }
        return nil
    }

    private var visibleContentLayoutGuideTop: NSLayoutConstraint!
    private var visibleContentLayoutGuideLeft: NSLayoutConstraint!
    private var visibleContentLayoutGuideRight: NSLayoutConstraint!
    private var visibleContentLayoutGuideBottom: NSLayoutConstraint!
    private var contentWrapperHeight: NSLayoutConstraint!
    private var contentViewTopEqualSuper: NSLayoutConstraint?
    private var contentViewTopGreaterThanSuper: NSLayoutConstraint?

    private func setupLayout() {
        addLayoutGuide(visibleContentLayoutGuide)
        visibleContentLayoutGuideTop = visibleContentLayoutGuide.topAnchor.constraint(equalTo: topAnchor)
        visibleContentLayoutGuideLeft = visibleContentLayoutGuide.leftAnchor.constraint(equalTo: leftAnchor)
        visibleContentLayoutGuideRight = visibleContentLayoutGuide.rightAnchor.constraint(equalTo: rightAnchor)
        visibleContentLayoutGuideBottom = visibleContentLayoutGuide.bottomAnchor.constraint(equalTo: bottomAnchor)
        visibleContentLayoutGuideTop.isActive = true
        visibleContentLayoutGuideLeft.isActive = true
        visibleContentLayoutGuideRight.priority = .defaultHigh
        visibleContentLayoutGuideRight.isActive = true
        visibleContentLayoutGuideBottom.priority = .defaultHigh
        visibleContentLayoutGuideBottom.isActive = true

        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        scrollView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        scrollView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true

        contentWrapperView.translatesAutoresizingMaskIntoConstraints = false
        contentWrapperView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        contentWrapperView.leftAnchor.constraint(equalTo: scrollView.leftAnchor).isActive = true
        contentWrapperView.rightAnchor.constraint(equalTo: scrollView.rightAnchor).isActive = true
        contentWrapperView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        contentWrapperView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true

        contentWrapperHeight = contentWrapperView.heightAnchor.constraint(
            greaterThanOrEqualTo: visibleContentLayoutGuide.heightAnchor
        )
        contentWrapperHeight.isActive = contentViewStretching
    }

    private func setupLayout(contentView view: UIView) {
        view.translatesAutoresizingMaskIntoConstraints = false

        contentViewTopEqualSuper = view.topAnchor.constraint(equalTo: contentWrapperView.topAnchor)
        contentViewTopEqualSuper?.isActive = alignContentToBottom == false

        contentViewTopGreaterThanSuper = view.topAnchor.constraint(greaterThanOrEqualTo: contentWrapperView.topAnchor)
        contentViewTopGreaterThanSuper?.isActive = alignContentToBottom == true

        view.leftAnchor.constraint(equalTo: contentWrapperView.leftAnchor).isActive = true
        view.rightAnchor.constraint(equalTo: contentWrapperView.rightAnchor).isActive = true
        view.bottomAnchor.constraint(equalTo: contentWrapperView.bottomAnchor).isActive = true
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
