import ScrollViewController

final class KeyboardFrameChangeListenerMock: KeyboardFrameChangeListening {
    func simulateKeyboardFrameChange(_ change: KeyboardFrameChange) {
        keyboardFrameWillChange?(change)
    }

    // MARK: - KeyboardFrameChangeListening

    var keyboardFrameWillChange: ((KeyboardFrameChange) -> Void)?
}
