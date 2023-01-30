//
//  AncientTableViewController.swift
//  Tables2023
//
//  Created by Miguel Rojas Cortes on 1/9/23.
//

import UIKit

final class AncientTableViewController: UITableViewController {

    // MARK: - Properties

    private var viewModel: ViewModel {
        didSet {
            tableView.reloadData()
        }
    }

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
        tableView.reloadData()
    }

    // MARK: - UI Setup

    private func setupUI() {
        tableView.separatorStyle = .none
        tableView.register(TableListCell.self,
                           forCellReuseIdentifier: TableListCell.reuseIdentifier)
    }

}

// MARK: - UITableViewDataSource

extension AncientTableViewController {

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRows
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = viewModel.item(at: indexPath.row)

        guard let cell = tableView.dequeueReusableCell(withIdentifier: TableListCell.reuseIdentifier) as? TableListCell else {
            return .init()
        }

        item.map { cell.configure(model: $0) }
        return cell
    }

}
