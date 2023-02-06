//
//  CollectionListHostingConfiguration.swift
//  Lists2023
//
//  Created by Miguel Rojas Cortes on 1/22/23.
//

import UIKit
import SwiftUI

final class CollectionListHostingConfigurationCellViewController: CollectionBaseViewController {

    // MARK: - Overrides

    override var showSeparators: Bool { true }

    override func reloadData() {
        configureSnapShot()
    }

    // MARK: - Properties

    private var dataSource: UICollectionViewDiffableDataSource<SectionModel, CellModel>?

    // MARK: - Cell Registration

    private lazy var defaultCellRegistry: UICollectionView.CellRegistration<UICollectionViewListCell, CellModel> = {
        UICollectionView.CellRegistration<UICollectionViewListCell, CellModel> { cell, indexPath, model in
            let hostingConfiguration = UIHostingConfiguration { Cell(model: model) }
            cell.contentConfiguration = hostingConfiguration.margins(.all, 12)
        }
    }()

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
