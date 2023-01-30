//
//  CollectionListHostingConfiguration.swift
//  Tables2023
//
//  Created by Miguel Rojas Cortes on 1/22/23.
//

import UIKit
import SwiftUI

final class CollectionListHostingConfigurationCellViewController: CollectionBaseViewController {

    // MARK: - Properties

    override var showSeparators: Bool { true }

    private var viewModel: ViewModel {
        didSet {
            configureSnapShot()
        }
    }

    private var dataSource: UICollectionViewDiffableDataSource<SectionModel, CellModel>?

    // MARK: - Cell Registration

    private lazy var defaultCellRegistry: UICollectionView.CellRegistration<UICollectionViewListCell, CellModel> = {
        UICollectionView.CellRegistration<UICollectionViewListCell, CellModel> { cell, indexPath, model in
            let hostingConfiguration = UIHostingConfiguration { Cell(model: model) }
            cell.contentConfiguration = hostingConfiguration.margins(.all, 12)
        }
    }()

    // MARK: - Initializer

    init(viewModel: ViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("View initialization not supported from Xib")
    }

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureDataSource()
        configureSnapShot()
    }

    // MARK: - Diffable DataSource

    private func configureDataSource() {
        let registeredCell = defaultCellRegistry

        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, model in
            collectionView.dequeueConfiguredReusableCell(using: registeredCell, for: indexPath, item: model)
        })
    }

    private func configureSnapShot() {
        guard var snapshot = dataSource?.snapshot() else { return }
        snapshot.appendSections([.main])
        snapshot.appendItems(viewModel.allItems)

        dataSource?.apply(snapshot)
    }

}
