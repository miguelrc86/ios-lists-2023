//
//  CellModel.swift
//  Lists2023
//
//  Created by Miguel Rojas Cortes on 1/14/23.
//

import UIKit

struct CellModel: Hashable, Identifiable {
    let id = UUID()
    let iconColor: UIColor
    let description: String
}
