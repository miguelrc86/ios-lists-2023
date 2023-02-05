//
//  TableBaseViewController.swift
//  Tables2023
//
//  Created by Miguel Rojas Cortes on 2/5/23.
//

import UIKit

class TableBaseViewController: BaseViewController {

    // MARK: - Properties

    lazy var tableView: UITableView = {
        let table = UITableView()
        table.separatorStyle = .none
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupLayout()
    }

    // MARK: - UI Setup

    private func setupUI() {
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.register(TableListCell.self,
                           forCellReuseIdentifier: TableListCell.reuseIdentifier)
    }

    private func setupLayout() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }

}

extension TableBaseViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, performPrimaryActionForRowAt indexPath: IndexPath) {
        action?()
    }
}
