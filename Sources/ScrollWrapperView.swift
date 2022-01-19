import UIKit

/// `UIScrollView` wrapper that allows configuring how the scrollable content is laid out.
public class ScrollWrapperView: UIView {
    /// Create `UIScrollView` wrapper view.
    public init() {
        scrollView = UIScrollView(frame: .zero)
        super.init(frame: .zero)
        scrollView.keyboardDismissMode = .interactive
        addSubview(scrollView)
        scrollView.addSubview(contentWrapperView)
        setupLayout()
    }

    /// Does nothing, this class is designed to be used programmatically.
    required public init?(coder aDecoder: NSCoder) { nil }

    // MARK: - Subviews

    /// Wrapped `UIScrollView`.
    public let scrollView: UIScrollView

    /// Scrollable content view.
    public var contentView: UIView? {
        didSet {
            oldValue?.removeFromSuperview()
            contentViewTopEqualSuper = nil
            contentViewTopGreaterThanSuper = nil
            contentViewLeft = nil
            contentViewRight = nil
            contentViewBottom = nil
            if let newValue = contentView {
                contentWrapperView.addSubview(newValue)
                setupLayout(contentView: newValue)
            }
        }
    }

    let contentWrapperView = UIView()

    // MARK: - Layout configuration

    /// If `true`, `contentView` will be stretched to fill visible area.
    ///
    /// Default is `true`.
    public var contentViewStretching = true {
        didSet { contentWrapperHeight.isActive = contentViewStretching }
    }

    /// If `true` the content view will be aligned to the bottom of scrollable area.
    ///
    /// Default is `false`.
    ///
    /// If the `contentViewStretching` is set to `false` this property makes no changes to the alignemnt.
    public var alignContentToBottom = false {
        didSet {
            contentViewTopGreaterThanSuper?.isActive = alignContentToBottom == true
            contentViewTopEqualSuper?.isActive = alignContentToBottom == false
        }
    }

    // MARK: - Touch handling configuration

    /// If `true` touches outside the `contentView` will be handled and allow scrolling.
    ///
    /// Default is `true`.
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

    // MARK: - Internals

    var visibleContentInsets: UIEdgeInsets {
        get {
            UIEdgeInsets(
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
    private var contentWrapperHeight: NSLayoutConstraint!
    private var contentViewTopEqualSuper: NSLayoutConstraint?
    private var contentViewTopGreaterThanSuper: NSLayoutConstraint?
    private var contentViewLeft: NSLayoutConstraint?
    private var contentViewRight: NSLayoutConstraint?
    private var contentViewBottom: NSLayoutConstraint?

    private func setupLayout() {
        setupVisibleContentLayoutGuide()
        setupScrollViewLayout()
        setupContentWrapperViewLayout()
    }

    private func setupScrollViewLayout() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        scrollView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        scrollView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }

    private func setupContentWrapperViewLayout() {
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

    private func setupVisibleContentLayoutGuide() {
        addLayoutGuide(visibleContentLayoutGuide)

        visibleContentLayoutGuideTop = visibleContentLayoutGuide.topAnchor.constraint(equalTo: topAnchor)
        visibleContentLayoutGuideTop.isActive = true

        visibleContentLayoutGuideLeft = visibleContentLayoutGuide.leftAnchor.constraint(equalTo: leftAnchor)
        visibleContentLayoutGuideLeft.isActive = true

        visibleContentLayoutGuideRight = visibleContentLayoutGuide.rightAnchor.constraint(equalTo: rightAnchor)
        visibleContentLayoutGuideRight.priority = .defaultHigh
        visibleContentLayoutGuideRight.isActive = true

        visibleContentLayoutGuideBottom = visibleContentLayoutGuide.bottomAnchor.constraint(equalTo: bottomAnchor)
        visibleContentLayoutGuideBottom.priority = .defaultHigh
        visibleContentLayoutGuideBottom.isActive = true
    }

    private func setupLayout(contentView view: UIView) {
        view.translatesAutoresizingMaskIntoConstraints = false

        contentViewTopEqualSuper = view.topAnchor.constraint(equalTo: contentWrapperView.topAnchor)
        contentViewTopEqualSuper?.isActive = alignContentToBottom == false

        contentViewTopGreaterThanSuper = view.topAnchor.constraint(greaterThanOrEqualTo: contentWrapperView.topAnchor)
        contentViewTopGreaterThanSuper?.isActive = alignContentToBottom == true

        contentViewLeft = view.leftAnchor.constraint(equalTo: contentWrapperView.leftAnchor)
        contentViewLeft?.isActive = true

        contentViewRight = view.rightAnchor.constraint(equalTo: contentWrapperView.rightAnchor)
        contentViewRight?.isActive = true

        contentViewBottom = view.bottomAnchor.constraint(equalTo: contentWrapperView.bottomAnchor)
        contentViewBottom?.isActive = true
    }
}
