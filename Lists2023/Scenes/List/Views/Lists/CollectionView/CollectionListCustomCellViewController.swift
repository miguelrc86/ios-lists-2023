//
//  CollectionListCustomCellViewController.swift
//  Lists2023
//
//  Created by Miguel Rojas Cortes on 1/22/23.
//

import UIKit

final class CollectionListCustomCellViewController: CollectionBaseViewController {

    // MARK: - Overrides

    override func reloadData() {
        configureSnapShot()
    }

    // MARK: - Properties

    private var dataSource: UICollectionViewDiffableDataSource<SectionModel, CellModel>?

    // MARK: - Cell Registration

    private lazy var customCellRegistry: UICollectionView.CellRegistration<CollectionListCell, CellModel> = {
        UICollectionView.CellRegistration<CollectionListCell, CellModel> { cell, indexPath, model in
            cell.configure(model: model)
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
        let registeredCell = customCellRegistry

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
