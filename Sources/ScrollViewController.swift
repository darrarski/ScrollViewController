import UIKit
import KeyboardFrameChangeListener
import ScrollViewKeyboardAvoider

/// Scroll View Controller
public class ScrollViewController: UIViewController {

    /// Create new instance
    ///
    /// - Parameters:
    ///   - keyboardFrameChangeListener: used to observe keybaord frame changes
    ///   - scrollViewKeyboardAvoider: used to apply keyboard-avoiding insets to UIScrollView
    ///   - wrapperViewFactory: used to create ScrollWrapperView
    public init(keyboardFrameChangeListener: KeyboardFrameChangeListening
                    = KeyboardFrameChangeListener(notificationCenter: NotificationCenter.default),
                scrollViewKeyboardAvoider: ScrollViewKeyboardAvoiding
                    = ScrollViewKeyboardAvoider(animator: { UIView.animate(withDuration: $0, animations: $1) }),
                wrapperViewFactory: @escaping () -> ScrollWrapperView
                    = { ScrollWrapperView() }) {
        self.keyboardFrameChangeListener = keyboardFrameChangeListener
        self.scrollViewKeyboardAvoider = scrollViewKeyboardAvoider
        self.createWrapperView = wrapperViewFactory
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
        keyboardFrameChangeListener.keyboardFrameWillChange = { [unowned self] change in
            self.scrollViewKeyboardAvoider.handleKeyboardFrameChange(change.frame,
                                                                     animationDuration: change.animationDuration,
                                                                     for: self.wrapperView.scrollView)
        }
    }

    /// Scrollable content view
    public var contentView: UIView? {
        get { return wrapperView.contentView }
        set { wrapperView.contentView = newValue }
    }

    private var wrapperView: ScrollWrapperView! {
        return view as? ScrollWrapperView
    }

    // MARK: Private

    private let keyboardFrameChangeListener: KeyboardFrameChangeListening
    private let scrollViewKeyboardAvoider: ScrollViewKeyboardAvoiding
    private let createWrapperView: () -> ScrollWrapperView

}
