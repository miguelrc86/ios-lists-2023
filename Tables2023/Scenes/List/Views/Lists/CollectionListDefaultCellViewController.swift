//
//  CollectionListDefaultCellViewController.swift
//  Tables2023
//
//  Created by Miguel Rojas Cortes on 1/21/23.
//

import UIKit

final class CollectionListDefaultCellViewController: UIViewController {

    // MARK: - Properties

    private lazy var collectionView: UICollectionView = {
        var collectionConfiguration = UICollectionLayoutListConfiguration(appearance: .plain)
        let collectionLayout = UICollectionViewCompositionalLayout.list(using: collectionConfiguration)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()

    private var viewModel: ViewModel {
        didSet {
            configureSnapShot()
        }
    }

    private var dataSource: UICollectionViewDiffableDataSource<SectionModel, CellModel>?

    // MARK: - Cell Registration

    private lazy var defaultCellRegistry: UICollectionView.CellRegistration<UICollectionViewListCell, CellModel> = {
        UICollectionView.CellRegistration<UICollectionViewListCell, CellModel> { cell, indexPath, model in
            var configuration = cell.defaultContentConfiguration()
            let image = UIImage(systemName: "pencil.circle")
            configuration.image = image
            configuration.imageProperties.tintColor = .black
            configuration.imageProperties.maximumSize = CGSize(width: 20, height: 20)
            configuration.text = model.description
            configuration.axesPreservingSuperviewLayoutMargins = .vertical
            configuration.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 12, leading: 12, bottom: 12, trailing: 12)
            configuration.imageToTextPadding = 8
            cell.contentConfiguration = configuration
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
        setupUI()
        setupLayout()
        configureDataSource()
        configureSnapShot()
    }

    // MARK: - UI Setup

    private func setupUI() {
        view.addSubview(collectionView)
    }

    private func setupLayout() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
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
        snapshot.appendSections([SectionModel.main])
        snapshot.appendItems(viewModel.allItems.map { .init(iconColor: .black, description: $0) })

        dataSource?.apply(snapshot)
    }

}