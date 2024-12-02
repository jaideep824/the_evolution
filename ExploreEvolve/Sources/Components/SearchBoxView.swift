//
//  SearchBoxView.swift
//  ExploreEvolve
//
//  Created by Jaideep on 02/12/24.
//

import SwiftUI

extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content
    ) -> some View {
        ZStack(alignment: alignment) {
            placeholder().opacity(shouldShow ? 1 : 0)
            self
        }
    }
}

struct SearchBoxView: View {
    @Binding var searchText: String

    var body: some View {
        HStack {
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.white)

                TextField("Search", text: $searchText)
                    .foregroundColor(.white)
                    .placeholder(when: searchText.isEmpty) {
                        Text("Search").foregroundColor(.white)
                    }
            }
            .padding(10)
            .background(.white.opacity(0.2))
            .cornerRadius(18)
        }
    }
}



#Preview {
    SearchBoxView(searchText: .constant(""))
}
