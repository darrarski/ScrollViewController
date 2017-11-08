@testable import ScrollViewController

class ScrollWrapperViewSpy: ScrollWrapperView {

    var didCallLayoutIfNeeded = false

    // MARK:

    override func layoutIfNeeded() {
        super.layoutIfNeeded()
        didCallLayoutIfNeeded = true
    }

}
