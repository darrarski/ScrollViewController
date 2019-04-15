import CoreGraphics
import Foundation

/// Represents keyboard frame change
public struct KeyboardFrameChange {
    /// Create new frame-change object
    ///
    /// - Parameters:
    ///   - frame: new keyboard frame
    ///   - animationDuration: change frame animation duration
    public init(frame: CGRect, animationDuration: TimeInterval) {
        self.frame = frame
        self.animationDuration = animationDuration
    }

    /// New keyboard frame
    public let frame: CGRect

    /// Change frame animation duration
    public let animationDuration: TimeInterval
}
