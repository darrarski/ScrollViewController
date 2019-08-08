import Quick
import Nimble
@testable import ScrollViewController

class ScrollViewKeyboardAvoiderSpec: QuickSpec {

    override func spec() {
        describe("ScrollViewKeyboardAvoider") {
            var sut: ScrollViewKeyboardAvoider!
            var didAnimateWithDuration: TimeInterval?

            beforeEach {
                sut = ScrollViewKeyboardAvoider(animator: { (duration, animations) in
                    didAnimateWithDuration = duration
                    animations()
                })
            }

            describe("scroll view without superview") {
                var scrollView: UIScrollView!

                beforeEach {
                    scrollView = UIScrollView()
                }

                context("keyboard frame changes") {
                    beforeEach {
                        sut.handleKeyboardFrameChange(.zero, animationDuration: 0, for: scrollView)
                    }

                    it("should not animate") {
                        expect(didAnimateWithDuration).to(beNil())
                    }
                }
            }

            describe("portrait screen") {
                var screenSize: CGSize!

                beforeEach {
                    screenSize = CGSize(width: 320, height: 480)
                }

                describe("full screen scroll view") {
                    var scrollView: UIScrollView!
                    var superview: UIView!

                    beforeEach {
                        scrollView = fullScreenScrollView(screenSize: screenSize)
                        superview = UIView(frame: CGRect(origin: .zero, size: screenSize))
                        superview.addSubview(scrollView)
                    }

                    context("standard keyboard becomes fully visible") {
                        var frame: CGRect!
                        var animationDuration: TimeInterval!

                        beforeEach {
                            frame = standardKeyboardFullyVisible(screenSize: screenSize)
                            animationDuration = 0.5
                            sut.handleKeyboardFrameChange(frame,
                                                          animationDuration: animationDuration,
                                                          for: scrollView)
                        }

                        it("should animate with correct duration") {
                            expect(didAnimateWithDuration) == animationDuration
                        }

                        it("should set correct bottom content inset") {
                            expect(scrollView.contentInset.bottom) == frame.size.height
                        }

                        it("should set correct bottom indicator inset") {
                            expect(scrollView.scrollIndicatorInsets.bottom) == frame.size.height
                        }
                    }

                    context("standard keyboard becomes not visible") {
                        var frame: CGRect!
                        var animationDuration: TimeInterval!

                        beforeEach {
                            frame = standardKeyboardNotVisible(screenSize: screenSize)
                            animationDuration = 0.3
                            sut.handleKeyboardFrameChange(frame,
                                                          animationDuration: animationDuration,
                                                          for: scrollView)
                        }

                        it("should animate with correct duration") {
                            expect(didAnimateWithDuration) == animationDuration
                        }

                        it("should set correct bottom content inset") {
                            expect(scrollView.contentInset.bottom) == 0
                        }

                        it("should set correct bottom indicator inset") {
                            expect(scrollView.scrollIndicatorInsets.bottom) == 0
                        }
                    }

                    context("standard keyboard becomes partially visible") {
                        var frame: CGRect!
                        var animationDuration: TimeInterval!

                        beforeEach {
                            frame = standardKeyboardPartiallyVisible(screenSize: screenSize)
                            animationDuration = 0.7
                            sut.handleKeyboardFrameChange(frame,
                                                          animationDuration: animationDuration,
                                                          for: scrollView)
                        }

                        it("should animate with correct duration") {
                            expect(didAnimateWithDuration) == animationDuration
                        }

                        it("should set correct bottom content inset") {
                            expect(scrollView.contentInset.bottom) == frame.size.height / 2
                        }

                        it("should set correct bottom indicator inset") {
                            expect(scrollView.scrollIndicatorInsets.bottom) == frame.size.height / 2
                        }
                    }
                }

                describe("full screen scroll view with margins") {
                    var scrollView: UIScrollView!
                    var margin: CGFloat!
                    var superview: UIView!

                    beforeEach {
                        margin = 20
                        scrollView = fullScreenScrollView(screenSize: screenSize, margin: margin)
                        superview = UIView(frame: CGRect(origin: .zero, size: screenSize))
                        superview.addSubview(scrollView)
                    }

                    context("standard keyboard becomes fully visible") {
                        var frame: CGRect!
                        var animationDuration: TimeInterval!

                        beforeEach {
                            frame = standardKeyboardFullyVisible(screenSize: screenSize)
                            animationDuration = 0.1
                            sut.handleKeyboardFrameChange(frame,
                                                          animationDuration: animationDuration,
                                                          for: scrollView)
                        }

                        it("should animate with correct duration") {
                            expect(didAnimateWithDuration) == animationDuration
                        }

                        it("should set correct bottom content inset") {
                            expect(scrollView.contentInset.bottom) == frame.size.height - margin
                        }

                        it("should set correct bottom indicator inset") {
                            expect(scrollView.scrollIndicatorInsets.bottom) == frame.size.height - margin
                        }
                    }

                    context("standard keyboard becomes not visible") {
                        var frame: CGRect!
                        var animationDuration: TimeInterval!

                        beforeEach {
                            frame = standardKeyboardNotVisible(screenSize: screenSize)
                            animationDuration = 0.333
                            sut.handleKeyboardFrameChange(frame,
                                                          animationDuration: animationDuration,
                                                          for: scrollView)
                        }

                        it("should animate with correct duration") {
                            expect(didAnimateWithDuration) == animationDuration
                        }

                        it("should set correct bottom content inset") {
                            expect(scrollView.contentInset.bottom) == 0
                        }

                        it("should set correct bottom indicator inset") {
                            expect(scrollView.scrollIndicatorInsets.bottom) == 0
                        }
                    }

                    context("standard keyboard becomes partially visible") {
                        var frame: CGRect!
                        var animationDuration: TimeInterval!

                        beforeEach {
                            frame = standardKeyboardPartiallyVisible(screenSize: screenSize)
                            animationDuration = 0.25
                            sut.handleKeyboardFrameChange(frame,
                                                          animationDuration: animationDuration,
                                                          for: scrollView)
                        }

                        it("should animate with correct duration") {
                            expect(didAnimateWithDuration) == animationDuration
                        }

                        it("should set correct bottom content inset") {
                            expect(scrollView.contentInset.bottom) == frame.size.height / 2 - margin
                        }

                        it("should set correct bottom indicator inset") {
                            expect(scrollView.scrollIndicatorInsets.bottom) == frame.size.height / 2 - margin
                        }
                    }
                }
            }
        }

        func fullScreenScrollView(screenSize: CGSize, margin: CGFloat = 0) -> UIScrollView {
            return UIScrollView(frame: CGRect(origin: .zero, size: screenSize).insetBy(dx: margin, dy: margin))
        }

        func standardKeyboardFullyVisible(screenSize: CGSize) -> CGRect {
            let size = CGSize(width: screenSize.width, height: 100)
            let frame = CGRect(
                origin: CGPoint(
                    x: 0,
                    y: screenSize.height - size.height
                ),
                size: size
            )
            return frame
        }

        func standardKeyboardPartiallyVisible(screenSize: CGSize) -> CGRect {
            let size = CGSize(width: screenSize.width, height: 100)
            let frame = CGRect(
                origin: CGPoint(
                    x: 0,
                    y: screenSize.height - (size.height / 2)
                ),
                size: size
            )
            return frame
        }

        func standardKeyboardNotVisible(screenSize: CGSize) -> CGRect {
            let size = CGSize(width: screenSize.width, height: 100)
            let frame = CGRect(
                origin: CGPoint(
                    x: 0,
                    y: screenSize.height
                ),
                size: size
            )
            return frame
        }
    }

}
