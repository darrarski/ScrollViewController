import Quick
import Nimble

@testable import ScrollViewController

class ScrollWrapperViewSpec: QuickSpec {

    override func spec() {
        describe("ScrollWrapperView") {
            var sut: ScrollWrapperView!

            context("init with coder") {
                beforeEach {
                    sut = ScrollWrapperView(coder: NSCoder())
                }

                it("should be nil") {
                    expect(sut).to(beNil())
                }
            }

            context("init") {
                beforeEach {
                    sut = ScrollWrapperView()
                }

                context("set content view") {
                    var view: UIView!

                    beforeEach {
                        view = UIView(frame: .zero)
                        sut.contentView = view
                    }

                    it("should add content view to scroll view") {
                        expect(view.superview).to(be(sut.scrollView))
                    }

                    context("set content view to nil") {
                        beforeEach {
                            sut.contentView = nil
                        }

                        it("should remove previous content view from scroll view") {
                            expect(view.superview).to(beNil())
                        }
                    }
                }
            }
        }
    }

}

