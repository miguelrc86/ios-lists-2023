//
//  DiffableDataSourceTableViewController.swift
//  Lists2023
//
//  Created by Miguel Rojas Cortes on 1/15/23.
//

import UIKit

final class DiffableDataSourceTableViewController: TableBaseViewController {

    // MARK: - Overrides

    override func reloadData() {
        configureSnapShot()
    }

    private var dataSource: UITableViewDiffableDataSource<SectionModel, CellModel>?

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureDataSource()
        configureSnapShot()
    }

    // MARK: - Diffable DataSource

    private func configureDataSource() {
        dataSource = UITableViewDiffableDataSource(tableView: tableView, cellProvider: { tableView, indexPath, model in
            let cell = tableView.dequeueReusableCell(withIdentifier: TableListCell.reuseIdentifier) as? TableListCell
            cell?.configure(model: model)

            return cell
        })
    }

    private func configureSnapShot() {
        guard var snapshot = dataSource?.snapshot() else { return }
        snapshot.appendSections([.main])
        snapshot.appendItems(viewModel.allItems)

        dataSource?.apply(snapshot)
    }
}
