//
//  DiffableDataSourceTableViewController.swift
//  Tables2023
//
//  Created by Miguel Rojas Cortes on 1/15/23.
//

import UIKit

final class DiffableDataSourceTableViewController: UITableViewController {

    // MARK: - Properties

    private var viewModel: ViewModel {
        didSet {
            configureSnapShot()
        }
    }

    private var dataSource: UITableViewDiffableDataSource<SectionModel, CellModel>?

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
        configureDataSource()
        configureSnapShot()
    }

    // MARK: - UI Setup

    private func setupUI() {
        tableView.separatorStyle = .none
        tableView.register(TableListCell.self,
                           forCellReuseIdentifier: TableListCell.reuseIdentifier)
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
