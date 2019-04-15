import UIKit

/// ScrollViewKeyboardAvoiding implementation
public class ScrollViewKeyboardAvoider: ScrollViewKeyboardAvoiding {

    /// Animates using provided duration and closure
    public typealias Animator = (TimeInterval, @escaping () -> Void) -> Void

    /// Create new avoider
    ///
    /// - Parameter animator: used to perform animations
    public init(animator: @escaping Animator) {
        self.animate = animator
    }

    // MARK: ScrollViewKeyboardAvoiding

    /// Handle keyboard frame change
    ///
    /// - Parameters:
    ///   - frame: new keyboard frame
    ///   - animationDuration: frame change animation duration
    ///   - scrollView: target UIScrollView
    public func handleKeyboardFrameChange(_ frame: CGRect,
                                          animationDuration: TimeInterval,
                                          for scrollView: UIScrollView) {
        guard let superview = scrollView.superview else { return }
        let keyboardFrame = superview.convert(frame, from: nil)
        var insets = scrollView.contentInset
        let bottomCoverage = scrollView.frame.maxY - keyboardFrame.minY
        let safeAreaInsets: UIEdgeInsets
        if #available(iOS 11.0, *) {
            safeAreaInsets = scrollView.safeAreaInsets
        } else {
            safeAreaInsets = .zero
        }
        insets.bottom = max(0, bottomCoverage - safeAreaInsets.bottom)
        animate(animationDuration) {
            scrollView.contentInset = insets
            scrollView.scrollIndicatorInsets = insets
        }
    }

    // MARK: Private

    private let animate: Animator

}
