//
//  BaseViewController.swift
//  Lists2023
//
//  Created by Miguel Rojas Cortes on 2/4/23.
//

import UIKit

class BaseViewController: UIViewController {
    
    // MARK: - Properties
    
    var viewModel: ViewModel {
        didSet {
            reloadData()
        }
    }

    var action: ((String) -> Void)?
    
    // MARK: - Initializers

    init(viewModel: ViewModel, action: ((String) -> Void)? = nil) {
        self.viewModel = viewModel
        self.action = action
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("View initialization not supported from Xib")
    }
    
    // MARK: - Data Handling

    func reloadData() {
        fatalError("Subclasses must override")
    }
    
}
