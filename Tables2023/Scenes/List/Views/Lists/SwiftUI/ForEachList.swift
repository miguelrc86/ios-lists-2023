//
//  ForEachList.swift
//  Tables2023
//
//  Created by Miguel Rojas Cortes on 2/6/23.
//

import SwiftUI

struct ForEachList: View {

    @State var viewModel: ViewModel

    var body: some View {
        List {
            ForEach(viewModel.allItems) { item in
                NavigationLink(destination: ListDetail(text: item.description)) {
                    Cell(model: item)
                }
            }
        }
        .listStyle(.plain)
    }
}

struct ForEachList_Previews: PreviewProvider {
    static var previews: some View {
        ForEachList(viewModel: ListViewModel(flavor: .swiftUIList))
    }
}
