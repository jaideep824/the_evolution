//
//  ExploreView.swift
//  ExploreEvolve
//
//  Created by Jaideep on 01/12/24.
//

import SwiftUI
import SwiftData

struct ExploreView: View {
    @StateObject private var viewModel = ViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    if viewModel.filteredProblems.isEmpty && viewModel.problemFilters.isEmpty {
                        ContentUnavailableView("Too much silence!",
                                               systemImage: "exclamationmark.triangle",
                                               description: Text("Please check back later or restart the this app"))
                    } else {
                        VStack {
                            Text("Discover")
                                .font(.title.bold())
                                .frame(maxWidth: .infinity, alignment: .leading)
                            SearchBoxView(searchText: $viewModel.searchText)
                                .padding(.horizontal, 20)
                            ProblemFilterListView(selectedFilters: viewModel.selectedFilters, problemFilter: viewModel.problemFilters) { newFilter in
                                viewModel.newFilterSelected(newFilter)
                            }
                            .frame(height: 40)
                            .padding()
                            
                            ExploreListView(reachedEndOfList: $viewModel.reachedEndOfList, problems: viewModel.filteredProblems)
                            
                        }
                        .padding(.horizontal, 10)
                    }
                }
                
                if viewModel.filteredProblems.isEmpty && viewModel.problemFilters.isEmpty {
                    ProgressView()
                        .padding()
                        .background(.gray)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                }
            }
        }
        .navigationTitle("Explore")
        .navigationBarTitleDisplayMode(.inline)
        .background(.black)
        .preferredColorScheme(.dark)
        .onAppear {
            viewModel.getMoreProblems()
        }
        .onReceive(viewModel.$searchText) { searchText in
            viewModel.search(searchText)
        }
        .onReceive(viewModel.$reachedEndOfList) { reachedEndOfList in
            if reachedEndOfList {
                viewModel.getMoreProblems()
                viewModel.reachedEndOfList = false
            }
        }
    }
}

#Preview {
    ExploreView()
}
