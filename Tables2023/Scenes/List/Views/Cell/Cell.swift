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
    }

    private var horizontalContainer: some View {
        HStack(alignment: .top, spacing: 12) {
            Image(systemName: "pencil.circle")
                .foregroundColor(Color(uiColor: model.iconColor))
            Text(model.description)
                .alignmentGuide(.listRowSeparatorLeading) { d in
                    d[.leading]
                }
            Spacer()
        }
        .alignmentGuide(.listRowSeparatorTrailing) { d in
            d[.listRowSeparatorTrailing]
        }
        .listRowInsets(EdgeInsets(
            top: 12, leading: 12, bottom: 12, trailing: 12)
        )
        .listRowSeparatorTint(Color.gray.opacity(0.4))
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
