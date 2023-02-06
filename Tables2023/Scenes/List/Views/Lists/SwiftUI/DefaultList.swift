//
//  DefaultList.swift
//  Tables2023
//
//  Created by Miguel Rojas Cortes on 1/28/23.
//

import SwiftUI

struct DefaultList: View {

    @State var viewModel: ViewModel

    var body: some View {
        List(viewModel.allItems, id: \.self) { item in
            NavigationLink(destination: ListDetail(text: item.description)) {
                Cell(model: item)
            }
        }
        .listStyle(.plain)
    }
}

struct List_Previews: PreviewProvider {
    static var previews: some View {
        DefaultList(viewModel: ListViewModel(flavor: .swiftUIList))
    }
}
