import UIKit

/// Adjusts insets of UIScrollView so the keyboard does not cover content
public protocol ScrollViewKeyboardAvoiding {

    /// Handle keyboard frame change
    ///
    /// - Parameters:
    ///   - frame: new keyboard frame
    ///   - animationDuration: frame change animation duration
    ///   - scrollView: target UIScrollView
    func handleKeyboardFrameChange(_ frame: CGRect, animationDuration: TimeInterval, for scrollView: UIScrollView)

}
