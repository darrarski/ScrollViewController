import ScrollViewController

final class ScrollViewKeyboardAvoiderSpy: ScrollViewKeyboardAvoiding {
    var handledKeyboardChanges = [(CGRect, TimeInterval, UIScrollView)]()

    // MARK: - ScrollViewKeyboardAvoiding

    func handleKeyboardFrameChange(_ frame: CGRect, animationDuration: TimeInterval, for scrollView: UIScrollView) {
        handledKeyboardChanges.append((frame, animationDuration, scrollView))
    }
}
