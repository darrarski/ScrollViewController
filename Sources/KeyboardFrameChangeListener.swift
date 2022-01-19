import UIKit

/// `KeyboardFrameChangeListining` implementation.
public final class KeyboardFrameChangeListener: KeyboardFrameChangeListening {
    /// Create new listener.
    ///
    /// - Parameter notificationCenter: Source of keyboard frame change notifications.
    public init(notificationCenter: NotificationCenter) {
        self.notificationCenter = notificationCenter
        observe()
    }

    // MARK: - KeyboardFrameChangeListening

    public var keyboardFrameWillChange: ((KeyboardFrameChange) -> Void)?

    // MARK: - Internals

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
