//
//  DeclarativeList.swift
//  Tables2023
//
//  Created by Miguel Rojas Cortes on 1/28/23.
//

import SwiftUI

struct DeclarativeList: View {

    @State var viewModel: ViewModel

    var body: some View {
        List(viewModel.allItems, id: \.self) { item in
            Cell(model: item)                
        }
        .listStyle(.plain)
    }
}

struct List_Previews: PreviewProvider {
    static var previews: some View {
        DeclarativeList(viewModel: ListViewModel(flavor: .swiftUIList))
    }
}
