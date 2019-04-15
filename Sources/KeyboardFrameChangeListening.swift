/// Listens for keyboard frame changes
public protocol KeyboardFrameChangeListening: class {
    /// Called when keyboard frame is about to change
    var keyboardFrameWillChange: ((KeyboardFrameChange) -> Void)? { get set }
}
