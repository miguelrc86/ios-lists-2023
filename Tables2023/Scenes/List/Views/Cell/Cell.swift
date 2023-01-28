//
//  Cell.swift
//  Tables2023
//
//  Created by Miguel Rojas Cortes on 1/22/23.
//

import SwiftUI

struct Cell: View {

    @State var model: CellModel

    var body: some View {
        horizontalContainer
        separator
    }

    private var horizontalContainer: some View {
        HStack(alignment: .top, spacing: 12) {
            Image(systemName: "pencil.circle")
                .foregroundColor(Color(uiColor: model.iconColor))
            Text(model.description)
            Spacer()
        }
        .padding([.leading, .top, .trailing], 12)
        .padding(.bottom, 4)
    }

    private var separator: some View {
        Divider()
            .background(Color.gray.grayscale(0.2))
            .padding(.init(top: 0, leading: 44, bottom: 0, trailing: 12))
    }
}

struct Cell_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            Cell(model: CellModel(
                iconColor: .red,
                description: "A preview description for the content of this cell")
            )
            .previewLayout(.fixed(width: 375, height: 100))

            Cell(model: CellModel(
                iconColor: .red,
                description: "A second preview description for the content of this cell")
            )
            .previewLayout(.fixed(width: 375, height: 100))
        }
    }
}
