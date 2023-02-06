//
//  ListDetail.swift
//  Lists2023
//
//  Created by Miguel Rojas Cortes on 2/4/23.
//

import SwiftUI

struct ListDetail: View {

    @State var text: String

    // MARK: - Main

    var body: some View {
        container
    }

    // MARK: - Subviews

    private var container: some View {
        ZStack {
            Color.white
                .ignoresSafeArea()
            content
        }
    }

    private var content: some View {
        VStack {
            quotedText
            alienEmojis
            Spacer()
        }
        .padding(20)
    }

    private var quotedText: some View {
        Text("\"\(text)\"")
            .italic()
            .bold()
            .dynamicTypeSize(.large)
            .lineSpacing(8)
            .padding()
    }

    private var alienEmojis: some View {
        VStack {
            Text("🛸")
            Text("👽")
            Text("🌑")
        }
        .font(Font.system(size: 100))
    }

}

struct ListDetail_Previews: PreviewProvider {
    static var previews: some View {
        ListDetail(text: "The search for extraterrestrial life is about understanding the origins and evolution of life in the universe and the potential for life to exist in different conditions.")
    }
}
