import Quick
import Nimble
@testable import ScrollViewController

class ScrollViewControllerSpec: QuickSpec {

    override func spec() {
        describe("ScrollViewController") {
            var sut: ScrollViewController!

            context("init with coder") {
                beforeEach {
                    sut = ScrollViewController(coder: NSCoder())
                }

                it("should be nil") {
                    expect(sut).to(beNil())
                }
            }
        }
    }

}
