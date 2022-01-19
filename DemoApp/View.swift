import UIKit

final class View: UIView {
    init() {
        super.init(frame: .zero)
        addSubviews()
        configureSubviews()
        setupLayout()
    }

    required init?(coder aDecoder: NSCoder) { nil }

    // MARK: - Subviews

    let textView = UITextView(frame: .zero)

    private func addSubviews() {
        addSubview(textView)
    }

    private func configureSubviews() {
        textView.isScrollEnabled = false
        textView.font = UIFont.preferredFont(forTextStyle: .body)
        textView.layer.borderColor = UIColor.darkGray.cgColor
        textView.layer.borderWidth = 0.5
        textView.text = """
        Lorem ipsum dolor sit amet mauris magna, gravida sem. Quisque augue. Maecenas nisl risus, euismod mi. Aliquam erat eu lobortis dapibus, accumsan lorem. Sed congue, lacus sagittis odio adipiscing dolor vel molestie venenatis nulla.

        Put your text here...
        """
    }

    // MARK: - Layout

    private func setupLayout() {
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.topAnchor.constraint(equalTo: topAnchor, constant: 16).isActive = true
        textView.leftAnchor.constraint(equalTo: leftAnchor, constant: 16).isActive = true
        textView.rightAnchor.constraint(equalTo: rightAnchor, constant: -16).isActive = true
        textView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16).isActive = true
    }
}
