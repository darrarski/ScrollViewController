import UIKit

/// Adjusts insets of `UIScrollView` so the keyboard does not cover content.
public protocol ScrollViewKeyboardAvoiding {
    /// Handle keyboard frame change.
    ///
    /// - Parameters:
    ///   - frame: New frame of the keyboard.
    ///   - animationDuration: Frame change animation duration.
    ///   - scrollView: Target `UIScrollView`.
    func handleKeyboardFrameChange(_ frame: CGRect, animationDuration: TimeInterval, for scrollView: UIScrollView)
}
