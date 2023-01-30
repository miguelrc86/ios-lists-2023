//
//  CollectionBaseViewController.swift
//  Tables2023
//
//  Created by Miguel Rojas Cortes on 1/30/23.
//

import UIKit

class CollectionBaseViewController: UIViewController {

    // MARK: - Properties

    var showSeparators: Bool { false }

    lazy var collectionView: UICollectionView = {
        var collectionConfiguration = UICollectionLayoutListConfiguration(appearance: .plain)

        if showSeparators {
            var separatorConfiguration = UIListSeparatorConfiguration(listAppearance: .plain)
            separatorConfiguration.color = .systemGray4
            separatorConfiguration.bottomSeparatorInsets = .init(top: 0, leading: 40, bottom: 0, trailing: 12)
            collectionConfiguration.separatorConfiguration = separatorConfiguration
        } else {
            collectionConfiguration.showsSeparators = false
        }

        let collectionLayout = UICollectionViewCompositionalLayout.list(using: collectionConfiguration)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupLayout()
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

}
