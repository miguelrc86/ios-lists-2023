//
//  StackedListViewController.swift
//  Tables2023
//
//  Created by Miguel Rojas Cortes on 1/8/23.
//

import UIKit

final class StackedListViewController: UIViewController {

    // MARK: - Properties

    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.contentInset = UIEdgeInsets(top: 12, left: 0, bottom: 12, right: 0)
        return scrollView
    }()

    private lazy var containerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .top
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private lazy var itemsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 12
        return stackView
    }()

    // MARK: - Initializers

    init() { super.init(nibName: nil, bundle: nil) }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
    }

    // MARK: - UI Setup

    private func setupUI() {
        view.addSubview(scrollView)
        containerStackView.addArrangedSubview(itemsStackView)
        scrollView.addSubview(containerStackView)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            scrollView.frameLayoutGuide.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.frameLayoutGuide.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.frameLayoutGuide.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.frameLayoutGuide.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.contentLayoutGuide.topAnchor.constraint(equalTo: containerStackView.topAnchor),
            scrollView.contentLayoutGuide.leadingAnchor.constraint(equalTo: containerStackView.leadingAnchor),
            scrollView.contentLayoutGuide.bottomAnchor.constraint(equalTo: containerStackView.bottomAnchor),
            scrollView.contentLayoutGuide.trailingAnchor.constraint(equalTo: containerStackView.trailingAnchor),
            scrollView.contentLayoutGuide.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor)
        ])
    }

    // MARK: - Configuration

    func configure(with model: [CellModel]) {
        model.forEach { item in
            let cellContent = CellContentView()
            cellContent.configure(with: item)
            itemsStackView.addArrangedSubview(cellContent)
        }
    }

}
