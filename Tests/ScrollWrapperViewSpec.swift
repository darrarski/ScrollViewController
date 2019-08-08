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

                it("should have content view stretching enabled") {
                    expect(sut.contentViewStretching) == true
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

                context("set visible content insets") {
                    var insets: UIEdgeInsets!

                    beforeEach {
                        insets = UIEdgeInsets(top: 4, left: 3, bottom: 2, right: 1)
                        sut.visibleContentInsets = insets
                    }

                    it("should have correct visible content insets") {
                        expect(sut.visibleContentInsets) == insets
                    }
                }

                context("set content view smaller than wrapper") {
                    var view: UIView!

                    beforeEach {
                        sut.frame = CGRect(x: 0, y: 0, width: 100, height: 200)
                        view = UIView(frame: .zero)
                        view.heightAnchor.constraint(greaterThanOrEqualToConstant: 100).isActive = true
                        sut.contentView = view
                    }

                    context("with content view stretching enabled") {
                        beforeEach {
                            sut.contentViewStretching = true
                            sut.layoutIfNeeded()
                        }

                        it("should content view fill wrapper") {
                            expect(view.frame) == CGRect(x: 0, y: 0, width: 100, height: 200)
                        }
                    }

                    context("without content view stretching disabled") {
                        beforeEach {
                            sut.contentViewStretching = false
                            sut.layoutIfNeeded()
                        }

                        it("should content view have correct frame") {
                            expect(view.frame) == CGRect(x: 0, y: 0, width: 100, height: 100)
                        }
                    }
                }

                context("set content view bigger than wrapper") {
                    var view: UIView!

                    beforeEach {
                        sut.frame = CGRect(x: 0, y: 0, width: 100, height: 200)
                        view = UIView(frame: .zero)
                        view.heightAnchor.constraint(greaterThanOrEqualToConstant: 300).isActive = true
                        sut.contentView = view
                    }

                    context("with content view stretching enabled") {
                        beforeEach {
                            sut.contentViewStretching = true
                            sut.layoutIfNeeded()
                        }

                        it("should content view have correct frame") {
                            expect(view.frame) == CGRect(x: 0, y: 0, width: 100, height: 300)
                        }
                    }

                    context("without content view stretching disabled") {
                        beforeEach {
                            sut.contentViewStretching = false
                            sut.layoutIfNeeded()
                        }

                        it("should content view have correct frame") {
                            expect(view.frame) == CGRect(x: 0, y: 0, width: 100, height: 300)
                        }
                    }
                }
            }
        }
    }

}
