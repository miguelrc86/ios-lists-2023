//
//  ListViewController.swift
//  Tables2023
//
//  Created by Miguel Rojas Cortes on 1/8/23.
//

import UIKit
import Combine

final class ListViewController: UIViewController {

    // MARK: - Properties

    private lazy var segmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(
            items: ListFlavor.rawValues
        )
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.selectedSegmentIndex = 0
        return segmentedControl
    }()

    private lazy var containerView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private var cancellable: AnyCancellable?

    var viewModel = ListViewModel()

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupPublishers()
    }

    // MARK: - UI Setup

    private func setupUI() {
        title = "Lists Flavors"
        view.addSubview(segmentedControl)
        view.addSubview(containerView)
        layoutConstraints()
    }

    private func layoutConstraints() {
        NSLayoutConstraint.activate([
            segmentedControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            segmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            segmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            containerView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor),
            containerView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            containerView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }

    // MARK: - Publishers

    private func setupPublishers() {
        cancellable = segmentedControl.publisher(for: \.selectedSegmentIndex)
            .sink { [weak self] index in
                if let type = ListFlavor.type(at: index) {
                    self?.swapToListType(type)
                }
            }
    }

    // MARK: - Actions

    private func swapToListType(_ type: ListFlavor) {
        switch type {
        case .stackedList:
            let stackVC = StackedListViewController()
            stackVC.configure(with: viewModel.model)
            updateChildViewController(viewController: stackVC)
            navigationItem.prompt = "- Stacked List -"
        case .ancientTableView:
            let ancientTVC = AncientTableViewController(viewModel: viewModel)
            updateChildViewController(viewController: ancientTVC)
            navigationItem.prompt = "- Standard TableView + Default DataSource -"
        case .diffableDataSourceTableView:
            navigationItem.prompt = "- Standard TableView + Diffable DataSource -"
        case .uiHostingConfiguration:
            navigationItem.prompt = "- Standard TableView + UIHostingConfiguration -"
        case .collectionViewList:
            navigationItem.prompt = "- CollectionView List -"
        case .swiftUIList:
            navigationItem.prompt = "- SwiftUI List -"
        }
    }

    // MARK: - Child Controller Setup

    private func updateChildViewController(viewController: UIViewController) {
        removeChildViewController()
        addChild(viewController)
        viewController.didMove(toParent: self)
        containerView.addArrangedSubview(viewController.view)
    }

    private func removeChildViewController() {
        if let child = children.first {
            child.willMove(toParent: nil)
            child.view.removeFromSuperview()
            child.removeFromParent()
        }
    }
}