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

                it("should ") {
                    // TODO:
                }
            }
        }
    }

}

