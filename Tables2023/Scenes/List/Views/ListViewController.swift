//
//  ListViewController.swift
//  Tables2023
//
//  Created by Miguel Rojas Cortes on 1/8/23.
//

import Combine
import SwiftUI
import UIKit

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
        let viewModel = ListViewModel(flavor: type)

        switch type {
        case .stackedList:
            let stackVC = StackedListViewController()
            stackVC.configure(with: viewModel.allItems)
            updateChildViewController(viewController: stackVC)
            navigationItem.prompt = "- Stacked List -"
        case .ancientTableView:
            let ancientTVC = AncientTableViewController(viewModel: viewModel)
            updateChildViewController(viewController: ancientTVC)
            navigationItem.prompt = "- Standard TableView | Default DataSource -"
        case .diffableDataSourceTableView:
            let diffableDataSourceVC = DiffableDataSourceTableViewController(viewModel: viewModel)
            updateChildViewController(viewController: diffableDataSourceVC)
            navigationItem.prompt = "- Standard TableView | Diffable DataSource -"
        case .collectionViewListDefaultCell:
            let collectionListDefaultCellVC = CollectionListDefaultCellViewController(viewModel: viewModel)
            updateChildViewController(viewController: collectionListDefaultCellVC)
            navigationItem.prompt = "- CollectionView List | Default Cell -"
        case .collectionViewListCustomCell:
            let collectionListCustomCellVC = CollectionListCustomCellViewController(viewModel: viewModel)
            updateChildViewController(viewController: collectionListCustomCellVC)
            navigationItem.prompt = "- CollectionView List | Custom Cell -"
        case .uiHostingConfiguration:
            let collectionListHostingConfigurationCellVC = CollectionListHostingConfigurationCellViewController(viewModel: viewModel)
            updateChildViewController(viewController: collectionListHostingConfigurationCellVC)
            navigationItem.prompt = "- CollectionView List | UIHostingConfiguration Cell -"
        case .swiftUIList:
            let listView = DeclarativeList(viewModel: viewModel)
            let hostingController = UIHostingController(rootView: listView)
            updateChildViewController(viewController: hostingController)
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
