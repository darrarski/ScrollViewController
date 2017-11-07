import Quick
import Nimble
@testable import ScrollViewController
@testable import KeyboardFrameChangeListener
@testable import ScrollViewKeyboardAvoider

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

            context("init") {
                var listenerMock: KeyboardFrameChangeListenerMock!
                var avoiderSpy: ScrollViewKeyboardAvoiderSpy!

                beforeEach {
                    listenerMock = KeyboardFrameChangeListenerMock()
                    avoiderSpy = ScrollViewKeyboardAvoiderSpy()
                    sut = ScrollViewController(keyboardFrameChangeListener: listenerMock,
                                               scrollViewKeyboardAvoider: avoiderSpy)
                }

                it("should ") {
                    // TODO:
                }
            }

            context("convenience init") {
                beforeEach {
                    sut = ScrollViewController()
                }

                it("should ") {
                    // TODO:
                }
            }
        }
    }

}
