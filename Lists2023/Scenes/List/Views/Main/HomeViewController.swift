//
//  HomeViewController.swift
//  Lists2023
//
//  Created by Miguel Rojas Cortes on 1/8/23.
//

import Combine
import SwiftUI
import UIKit

final class HomeViewController: UIViewController {

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

    private lazy var navigateToDetailView: (String) -> Void = { [unowned self] text in
        let hostingDetailViewController = UIHostingController(rootView: ListDetail(text: text))
        self.navigationController?.pushViewController(hostingDetailViewController, animated: true)
    }

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupPublishers()
    }

    // MARK: - UI Setup

    private func setupUI() {
        title = "Home"
        view.addSubview(segmentedControl)
        view.addSubview(containerView)
        layoutConstraints()
    }

    private func layoutConstraints() {
        NSLayoutConstraint.activate([
            segmentedControl.heightAnchor.constraint(equalToConstant: 44),
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
            let stackVC = StackedListViewController(viewModel: viewModel)
            updateChildViewController(viewController: stackVC)
            navigationItem.prompt = "- Stacked List -"
        case .ancientTableView:
            let ancientTVC = AncientTableViewController(
                viewModel: viewModel,
                action: navigateToDetailView
            )
            updateChildViewController(viewController: ancientTVC)
            navigationItem.prompt = "- Standard TableView | Default DataSource -"
        case .diffableDataSourceTableView:
            let diffableDataSourceVC = DiffableDataSourceTableViewController(
                viewModel: viewModel,
                action: navigateToDetailView
            )
            updateChildViewController(viewController: diffableDataSourceVC)
            navigationItem.prompt = "- Standard TableView | Diffable DataSource -"
        case .collectionViewListDefaultCell:
            let collectionListDefaultCellVC = CollectionListDefaultCellViewController(
                viewModel: viewModel,
                action: navigateToDetailView
            )
            updateChildViewController(viewController: collectionListDefaultCellVC)
            navigationItem.prompt = "- CollectionView List | Default Cell -"
        case .collectionViewListCustomCell:
            let collectionListCustomCellVC = CollectionListCustomCellViewController(
                viewModel: viewModel,
                action: navigateToDetailView
            )
            updateChildViewController(viewController: collectionListCustomCellVC)
            navigationItem.prompt = "- CollectionView List | Custom Cell -"
        case .uiHostingConfiguration:
            let collectionListHostingConfigurationCellVC = CollectionListHostingConfigurationCellViewController(
                viewModel: viewModel,
                action: navigateToDetailView
            )
            updateChildViewController(viewController: collectionListHostingConfigurationCellVC)
            navigationItem.prompt = "- CollectionView List | UIHostingConfiguration Cell -"
        case .swiftUIList:
            let listView = DefaultList(viewModel: viewModel)
            let hostingController = UIHostingController(rootView: listView)
            updateChildViewController(viewController: hostingController)
            navigationItem.prompt = "- SwiftUI List -"
        case .swiftUIForEachList:
            let forEacListView = ForEachList(viewModel: viewModel)
            let hostingController = UIHostingController(rootView: forEacListView)
            updateChildViewController(viewController: hostingController)
            navigationItem.prompt = "- SwiftUI List | ForEach -"
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
