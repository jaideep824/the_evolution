//
//  ProblemFilterListView.swift
//  ExploreEvolve
//
//  Created by Jaideep on 02/12/24.
//

import SwiftUI

struct ProblemFilterListView: View {
    let selectedFilters: Set<ProblemFilter>
    let problemFilter: [ProblemFilter]
    private let layout = [GridItem(.fixed(20))]
    
    var onNewFilterSelected: (_ newFilter: ProblemFilter) -> Void
    
    var body: some View {
        ScrollView(.horizontal) {
            LazyHGrid(rows: layout) {
                ForEach(problemFilter) { problemFilter in
                    ChipView(title: problemFilter.title ?? "", isSelected: selectedFilters.contains(problemFilter)) {
                        onNewFilterSelected(problemFilter)
                    }
                }
            }
        }
        .scrollIndicators(.hidden)
    }
}

#Preview {
    ProblemFilterListView(selectedFilters: [.example], problemFilter: [.example]) { newFilter in
        print(newFilter)
    }
}
