import UIKit

/// KeyboardFrameChangeListining implementation
public class KeyboardFrameChangeListener: KeyboardFrameChangeListening {

    /// Create new listener
    ///
    /// - Parameter notificationCenter: source of keyboard frame change notifications
    public init(notificationCenter: NotificationCenter) {
        self.notificationCenter = notificationCenter
        observe()
    }

    // MARK: KeyboardFrameChangeListening

    /// Called when keyboard frame is about to change
    public var keyboardFrameWillChange: ((KeyboardFrameChange) -> Void)?

    // MARK: Private

    private let notificationCenter: NotificationCenter
    private var token: NSObjectProtocol?

    private func observe() {
        token = notificationCenter.addObserver(
            forName: UIResponder.keyboardWillChangeFrameNotification,
            object: nil,
            queue: nil,
            using: { [weak self] in self?.handle($0) }
        )
    }

    private func handle(_ notification: Notification) {
        guard let endFrame = notification.keyboardFrameEnd,
              let animationDuration = notification.keyboardAnimationDuration else { return }
        let change = KeyboardFrameChange(frame: endFrame, animationDuration: animationDuration)
        keyboardFrameWillChange?(change)
    }

}

private extension Notification {

    var keyboardFrameEnd: CGRect? {
        return userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect
    }

    var keyboardAnimationDuration: Double? {
        return userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double
    }

}
