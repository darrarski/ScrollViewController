import UIKit
import KeyboardFrameChangeListener
import ScrollViewKeyboardAvoider

/// Scroll View Controller
public class ScrollViewController: UIViewController, UIScrollViewDelegate {

    /// Animates using provided duration and closure
    public typealias Animator = (TimeInterval, @escaping () -> Void) -> Void

    /// Create new instance
    ///
    /// - Parameters:
    ///   - keyboardFrameChangeListener: used to observe keybaord frame changes
    ///   - scrollViewKeyboardAvoider: used to apply keyboard-avoiding insets to UIScrollView
    ///   - wrapperViewFactory: used to create ScrollWrapperView
    ///   - animator: closure used to animate views
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

    /// Does nothing, class is designed to be used programatically
    required public init?(coder aDecoder: NSCoder) {
        return nil
    }

    // MARK: View

    /// Loads view
    override public func loadView() {
        view = createWrapperView()
    }

    /// Called when view is loaded
    override public func viewDidLoad() {
        super.viewDidLoad()
        wrapperView.scrollView.delegate = self
        keyboardFrameChangeListener.keyboardFrameWillChange = { [unowned self] change in
            self.scrollViewKeyboardAvoider.handleKeyboardFrameChange(change.frame,
                                                                     animationDuration: change.animationDuration,
                                                                     for: self.wrapperView.scrollView)
            self.updateVisibleContentInset(scrollView: self.wrapperView.scrollView)
            self.animate(change.animationDuration) { self.wrapperView.layoutIfNeeded() }
        }
    }

    /// Called when view layouts subviews
    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        updateVisibleContentInset(scrollView: wrapperView.scrollView)
    }

    /// Contained UIScrollView
    public var scrollView: UIScrollView {
        return wrapperView.scrollView
    }

    /// Scrollable content view
    public var contentView: UIView? {
        get { return wrapperView.contentView }
        set { wrapperView.contentView = newValue }
    }

    private var wrapperView: ScrollWrapperView! {
        return view as? ScrollWrapperView
    }

    // MARK: UIScrollViewDelegate

    /// Called when UIScrollView changes adjusted content inset
    ///
    /// - Parameter scrollView: UIScrollView that changed adjusted content inset
    @available(iOS 11.0, *)
    public func scrollViewDidChangeAdjustedContentInset(_ scrollView: UIScrollView) {
        updateVisibleContentInset(scrollView: scrollView)
    }

    // MARK: Private

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
