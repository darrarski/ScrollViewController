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
                var wrapperViewSpy: ScrollWrapperViewSpy!

                beforeEach {
                    listenerMock = KeyboardFrameChangeListenerMock()
                    avoiderSpy = ScrollViewKeyboardAvoiderSpy()
                    wrapperViewSpy = ScrollWrapperViewSpy()
                    sut = ScrollViewController(keyboardFrameChangeListener: listenerMock,
                                               scrollViewKeyboardAvoider: avoiderSpy,
                                               wrapperViewFactory: { wrapperViewSpy })
                }

                context("load view") {
                    beforeEach {
                        _ = sut.view
                    }

                    it("should have correct view") {
                        expect(sut.view).to(be(wrapperViewSpy))
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
                            expect(avoiderSpy.handledKeyboardChanges.first?.2).to(be(wrapperViewSpy.scrollView))
                        }
                    }

                    context("set content view") {
                        var view: UIView!

                        beforeEach {
                            view = UIView(frame: .zero)
                            sut.contentView = view
                        }

                        it("should have correct content view") {
                            expect(sut.contentView).to(be(view))
                        }

                        it("should add content view to wrapper") {
                            expect(wrapperViewSpy.contentView).to(be(view))
                        }

                        context("set content view to nil") {
                            beforeEach {
                                sut.contentView = nil
                            }

                            it("should have correct content view") {
                                expect(sut.contentView).to(beNil())
                            }

                            it("should remove previous content view from wrapper") {
                                expect(wrapperViewSpy.contentView).to(beNil())
                            }
                        }
                    }

                    context("scroll view changes adjusted content insets") {
                        var scrollViewMock: UIScrollViewMock!

                        beforeEach {
                            scrollViewMock = UIScrollViewMock()
                            scrollViewMock.mockedAdjustedContentInset = UIEdgeInsets(top: 1, left: 2, bottom: 3, right: 4)
                            sut.scrollViewDidChangeAdjustedContentInset(scrollViewMock)
                        }

                        it("should update visible content insets") {
                            expect(wrapperViewSpy.visibleContentInsets).to(equal(scrollViewMock.adjustedContentInset))
                        }
                    }
                }
            }
        }
    }

}
