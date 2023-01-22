//
//  CollectionListCell.swift
//  Tables2023
//
//  Created by Miguel Rojas Cortes on 1/21/23.
//

import UIKit

protocol ConfigurableCell {
    func configure(model: CellModel)
}

final class CollectionListCell: UICollectionViewCell, ConfigurableCell {

    // MARK: - Properties

    private lazy var cellContentView: CellContentView = {
        let contentView = CellContentView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        return contentView
    }()

    // MARK: - Initializer

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("View initialization not supported from Xib")
    }

    // MARK: - Life Cycle

    override func prepareForReuse() {
        super.prepareForReuse()
        cellContentView.reset()
    }

    // MARK: - UI Layout

    private func setupLayout() {
        contentView.addSubview(cellContentView)

        NSLayoutConstraint.activate([
            cellContentView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            cellContentView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            cellContentView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            cellContentView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }

    // MARK: - Configuration

    func configure(model: CellModel) {
        cellContentView.configure(with: model)
    }

}
