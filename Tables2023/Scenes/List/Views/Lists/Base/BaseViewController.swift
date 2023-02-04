//
//  BaseViewController.swift
//  Tables2023
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
    
    // MARK: - Initializers
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
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
