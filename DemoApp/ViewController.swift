import UIKit
import ScrollViewController

class ViewController: UIViewController {

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        return nil
    }

    // MARK: View

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

    // MARK: Private

    private let scrollViewController = ScrollViewController()

    private func embed(_ viewController: UIViewController) {
        addChildViewController(viewController)
        view.addSubview(viewController.view)
        viewController.view.translatesAutoresizingMaskIntoConstraints = false
        viewController.view.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        viewController.view.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        viewController.view.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        viewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        viewController.didMove(toParentViewController: self)
    }

}
