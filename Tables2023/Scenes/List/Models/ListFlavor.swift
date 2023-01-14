//
//  ListFlavor.swift
//  Tables2023
//
//  Created by Miguel Rojas Cortes on 1/8/23.
//

import Foundation

enum ListFlavor: Int, CaseIterable {

    case stackedList                    = 1
    case ancientTableView
    case diffableDataSourceTableView
    case uiHostingConfiguration
    case collectionViewList
    case swiftUIList
    
    static var rawValues: [String] {
        allCases.map { $0.rawValue.description }
    }

    static func type(at index: Int) -> Self? {
        guard 0...allCases.count ~= index else { return nil }
        return allCases[index]
    }

}