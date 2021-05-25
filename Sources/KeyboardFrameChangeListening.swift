/// Listens for keyboard frame changes
public protocol KeyboardFrameChangeListening: AnyObject {
    /// Called when keyboard frame is about to change
    var keyboardFrameWillChange: ((KeyboardFrameChange) -> Void)? { get set }
}
