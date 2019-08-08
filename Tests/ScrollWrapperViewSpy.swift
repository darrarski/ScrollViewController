@testable import ScrollViewController

class ScrollWrapperViewSpy: ScrollWrapperView {

    var didCallLayoutIfNeeded = false

    override func layoutIfNeeded() {
        super.layoutIfNeeded()
        didCallLayoutIfNeeded = true
    }

}
