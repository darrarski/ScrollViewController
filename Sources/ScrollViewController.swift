import UIKit

/// Scroll View Controller.
public final class ScrollViewController: UIViewController, UIScrollViewDelegate {
    /// Animates using provided duration and closure.
    public typealias Animator = (TimeInterval, @escaping () -> Void) -> Void

    /// Create new instance.
    ///
    /// - Parameters:
    ///   - keyboardFrameChangeListener: Used to observe keybaord frame changes.
    ///   - scrollViewKeyboardAvoider: Used to apply keyboard-avoiding insets to `UIScrollView`.
    ///   - wrapperViewFactory: Used to create `ScrollWrapperView`.
    ///   - animator: Closure used to animate layout changes.
    public init(keyboardFrameChangeListener: KeyboardFrameChangeListening
                    = KeyboardFrameChangeListener(notificationCenter: NotificationCenter.default),
                scrollViewKeyboardAvoider: ScrollViewKeyboardAvoiding
                    = ScrollViewKeyboardAvoider(animator: { UIView.animate(withDuration: $0, animations: $1) }),
                wrapperViewFactory: @escaping () -> ScrollWrapperView
                    = { ScrollWrapperView() },
                animator: @escaping Animator
                    = { UIView.animate(withDuration: $0, animations: $1) }) {
        self.keyboardFrameChangeListener = keyboardFrameChangeListener
        self.scrollViewKeyboardAvoider = scrollViewKeyboardAvoider
        self.createWrapperView = wrapperViewFactory
        self.animate = animator
        super.init(nibName: nil, bundle: nil)
    }

    /// Does nothing, this class is designed to be used programmatically.
    required public init?(coder aDecoder: NSCoder) { nil }

    // MARK: - View

    override public func loadView() {
        view = createWrapperView()
    }

    override public func viewDidLoad() {
        super.viewDidLoad()
        wrapperView.scrollView.delegate = self
        keyboardFrameChangeListener.keyboardFrameWillChange = { [unowned self] change in
            self.scrollViewKeyboardAvoider.handleKeyboardFrameChange(
                change.frame,
                animationDuration: change.animationDuration,
                for: self.wrapperView.scrollView
            )
            self.updateVisibleContentInset(scrollView: self.wrapperView.scrollView)
            self.animate(change.animationDuration) {
                self.wrapperView.layoutIfNeeded()
            }
        }
    }

    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        updateVisibleContentInset(scrollView: wrapperView.scrollView)
    }

    /// Contained `UIScrollView`.
    public var scrollView: UIScrollView {
        return wrapperView.scrollView
    }

    /// Scrollable content view.
    public var contentView: UIView? {
        get { return wrapperView.contentView }
        set { wrapperView.contentView = newValue }
    }

    /// Main view of this view controller (non-scrollable).
    public var wrapperView: ScrollWrapperView! {
        return view as? ScrollWrapperView
    }

    // MARK: - UIScrollViewDelegate

    @available(iOS 11.0, *)
    public func scrollViewDidChangeAdjustedContentInset(_ scrollView: UIScrollView) {
        updateVisibleContentInset(scrollView: scrollView)
    }

    // MARK: - Internals

    private let keyboardFrameChangeListener: KeyboardFrameChangeListening
    private let scrollViewKeyboardAvoider: ScrollViewKeyboardAvoiding
    private let createWrapperView: () -> ScrollWrapperView
    private let animate: Animator

    private func updateVisibleContentInset(scrollView: UIScrollView) {
        if #available(iOS 11.0, *) {
            wrapperView.visibleContentInsets = scrollView.adjustedContentInset
        } else {
            wrapperView.visibleContentInsets = scrollView.contentInset
        }
    }
}
