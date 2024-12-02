//
//  ExploreList.swift
//  ExploreEvolve
//
//  Created by Jaideep on 01/12/24.
//

import SwiftUI

struct ExploreListView: View {
    // MARK: Variables
    @Binding var reachedEndOfList: Bool
    let problems: [Problem]
    
    
    private let layout = [GridItem(.adaptive(minimum: 150), spacing: 20)]
   
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: layout, spacing: 30) {
                ForEach(problems) { problem in
                    ExploreItemView(problem: problem)
                        .onAppear {
                            if problem == problems.last {
                                reachedEndOfList = true
                            }
                        }
                    
                }
            }
        }
    }
}

#Preview {
    ExploreListView(reachedEndOfList: .constant(false), problems: [.example])
}
