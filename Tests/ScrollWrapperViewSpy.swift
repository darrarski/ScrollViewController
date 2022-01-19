@testable import ScrollViewController

final class ScrollWrapperViewSpy: ScrollWrapperView {
    var didCallLayoutIfNeeded = false

    override func layoutIfNeeded() {
        super.layoutIfNeeded()
        didCallLayoutIfNeeded = true
    }
}
