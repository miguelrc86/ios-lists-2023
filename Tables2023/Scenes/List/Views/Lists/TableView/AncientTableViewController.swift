//
//  AncientTableViewController.swift
//  Tables2023
//
//  Created by Miguel Rojas Cortes on 1/9/23.
//

import UIKit

final class AncientTableViewController: TableBaseViewController {

    // MARK: - Overrides

    override func reloadData() {
        tableView.reloadData()
    }

    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.reloadData()
    }

}

// MARK: - UITableViewDataSource

extension AncientTableViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRows
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = viewModel.item(at: indexPath.row)

        guard let cell = tableView.dequeueReusableCell(withIdentifier: TableListCell.reuseIdentifier) as? TableListCell else {
            return .init()
        }

        item.map { cell.configure(model: $0) }
        return cell
    }

}
