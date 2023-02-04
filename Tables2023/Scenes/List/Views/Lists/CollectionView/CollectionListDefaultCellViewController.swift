//
//  CollectionListDefaultCellViewController.swift
//  Tables2023
//
//  Created by Miguel Rojas Cortes on 1/21/23.
//

import UIKit

final class CollectionListDefaultCellViewController: CollectionBaseViewController {

    // MARK: - Properties

    private var dataSource: UICollectionViewDiffableDataSource<SectionModel, CellModel>?

    // MARK: - Overrides

    override var showSeparators: Bool { true }

    override func reloadData() {
        configureSnapShot()
    }

    // MARK: - Cell Registration

    private lazy var defaultCellRegistry: UICollectionView.CellRegistration<UICollectionViewListCell, CellModel> = {
        UICollectionView.CellRegistration<UICollectionViewListCell, CellModel> { cell, indexPath, model in
            var configuration = cell.defaultContentConfiguration()
            let image = UIImage(systemName: "pencil.circle")
            configuration.image = image
            configuration.imageProperties.tintColor = model.iconColor
            configuration.imageProperties.maximumSize = CGSize(width: 20, height: 20)
            configuration.text = model.description
            configuration.axesPreservingSuperviewLayoutMargins = .vertical
            configuration.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 12, leading: 12, bottom: 12, trailing: 12)
            configuration.imageToTextPadding = 8
            cell.contentConfiguration = configuration
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
