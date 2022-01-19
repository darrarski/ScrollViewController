import UIKit
import ScrollViewController

final class ViewController: UIViewController {
    init() {
        super.init(nibName: nil, bundle: nil)
        navigationItem.prompt = "ScrollViewController"
        navigationItem.title = "Demo"
    }

    required init?(coder aDecoder: NSCoder) { nil }

    // MARK: - View

    override func loadView() {
        view = UIView(frame: .zero)
        view.backgroundColor = UIColor(red:0.94, green:0.94, blue:0.96, alpha:1.00)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        embed(scrollViewController)
        scrollViewController.scrollView.alwaysBounceVertical = true
        scrollViewController.contentView = View()
    }

    // MARK: - Internals

    private let scrollViewController = ScrollViewController()

    private func embed(_ viewController: UIViewController) {
        addChild(viewController)
        view.addSubview(viewController.view)
        viewController.view.translatesAutoresizingMaskIntoConstraints = false
        viewController.view.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        viewController.view.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        viewController.view.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        viewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        viewController.didMove(toParent: self)
    }
}
