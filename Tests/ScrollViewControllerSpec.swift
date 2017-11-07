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

                context("load view") {
                    beforeEach {
                        _ = sut.view
                    }

                    context("keyboard frame changes") {
                        var change: KeyboardFrameChange!

                        beforeEach {
                            change = KeyboardFrameChange(
                                frame: CGRect(x: 4, y: 12, width: 36, height: 108),
                                animationDuration: 0.1
                            )
                            listenerMock.simulateKeyboardFrameChange(change)
                        }

                        it("should handle single change") {
                            expect(avoiderSpy.handledKeyboardChanges).to(haveCount(1))
                        }

                        it("should handle correct frame") {
                            expect(avoiderSpy.handledKeyboardChanges.first?.0).to(equal(change.frame))
                        }

                        it("should handle correct animation duration") {
                            expect(avoiderSpy.handledKeyboardChanges.first?.1).to(equal(change.animationDuration))
                        }

                        it("should handle for correct scroll view") {
                            expect(avoiderSpy.handledKeyboardChanges.first?.2).notTo(beNil()) // TODO:
                        }
                    }
                }
            }
        }
    }

}
