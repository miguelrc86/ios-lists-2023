//
//  AncientTableViewController.swift
//  Tables2023
//
//  Created by Miguel Rojas Cortes on 1/9/23.
//

import UIKit

final class AncientTableViewController: UIViewController {

    // MARK: - Properties

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.dataSource = self
        tableView.register(TableListCell.self,
                           forCellReuseIdentifier: TableListCell.reuseIdentifier)
        return tableView
    }()

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
        setupLayout()
        tableView.reloadData()
    }

    // MARK: - UI Setup

    private func setupUI() {
        view.addSubview(tableView)
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
