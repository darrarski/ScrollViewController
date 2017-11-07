import UIKit
import KeyboardFrameChangeListener
import ScrollViewKeyboardAvoider

class ScrollViewController: UIViewController {

    convenience init() {
        let listener = KeyboardFrameChangeListener(notificationCenter: NotificationCenter.default)
        let avoider = ScrollViewKeyboardAvoider(animator: { UIView.animate(withDuration: $0, animations: $1) })
        self.init(keyboardFrameChangeListener: listener, scrollViewKeyboardAvoider: avoider)
    }

    init(keyboardFrameChangeListener: KeyboardFrameChangeListening,
         scrollViewKeyboardAvoider: ScrollViewKeyboardAvoiding) {
        self.keyboardFrameChangeListener = keyboardFrameChangeListener
        self.scrollViewKeyboardAvoider = scrollViewKeyboardAvoider
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        return nil
    }

    // MARK: View

    override func viewDidLoad() {
        super.viewDidLoad()
        keyboardFrameChangeListener.keyboardFrameWillChange = { [unowned self] change in
            self.scrollViewKeyboardAvoider.handleKeyboardFrameChange(change.frame,
                                                                     animationDuration: change.animationDuration,
                                                                     for: UIScrollView()) // TODO:
        }
    }

    // MARK: Private

    private let keyboardFrameChangeListener: KeyboardFrameChangeListening
    private let scrollViewKeyboardAvoider: ScrollViewKeyboardAvoiding

}
