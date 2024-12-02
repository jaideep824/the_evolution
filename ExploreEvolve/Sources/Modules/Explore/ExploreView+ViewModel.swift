//
//  ExploreView+ViewModel.swift
//  ExploreEvolve
//
//  Created by Jaideep on 01/12/24.
//


import Combine
import Foundation
import SwiftData

extension ExploreView {
    class ViewModel: ObservableObject {
        // MARK: Variables
        static let allFilterType = ProblemFilter(id: -1, title: "All")
        private var problems: [Problem] = [] {
            didSet {
                refreshFilterProblemMapping()
            }
        }
        private var filterAndProblemDict: [ProblemFilter: [Problem]] = [:]
        
        @Published var searchText: String = ""
        @Published var problemFilters: [ProblemFilter] = []
        @Published var filteredProblems: [Problem] = []
        @Published var reachedEndOfList: Bool = false
        @Published var selectedFilters: Set<ProblemFilter> = []
        
        private var subscribers: Set<AnyCancellable> = []
        private var numberOfPages: Int = 1
        private var currentPageNumber = 0
        
        // MARK: Functions
        func newFilterSelected(_ filter: ProblemFilter) {
            selectedFilters.remove(Self.allFilterType)
            
            if filter == Self.allFilterType {
                selectedFilters.removeAll()
                selectedFilters.insert(Self.allFilterType)
            } else if selectedFilters.contains(filter) {
                selectedFilters.remove(filter)
            } else {
                selectedFilters.insert(filter)
            }
            
            if selectedFilters.isEmpty {
                selectedFilters.insert(Self.allFilterType)
            }
            
            filterProblems()
        }
        
        func search(_ searchText: String) {
            filteredProblems = []
            if searchText.isEmpty {
                filterProblems()
            } else {
                filteredProblems = problems.filter { $0.title?.localizedCaseInsensitiveContains(searchText) == true }
            }
        }
        
        private func refreshFilterProblemMapping() {
            filterAndProblemDict = [:]
            for filter in problemFilters {
                var tempArray: [Problem] = []
                for problem in problems {
                    if problem.problems?.contains(where: { $0.localizedCaseInsensitiveContains(filter.title ?? "") == true }) ?? false {
                        tempArray.append(problem)
                    }
                }
                filterAndProblemDict[filter] = tempArray
            }
        }
        
        private func filterProblems() {
            self.filteredProblems = []
            
            if self.selectedFilters.contains(Self.allFilterType) {
                self.filteredProblems = problems
            } else {
                var tempFilteredProblems: Set<Problem> = []
                for selectedFilter in selectedFilters {
                    tempFilteredProblems.formUnion(filterAndProblemDict[selectedFilter] ?? [])
                }
                filteredProblems = Array(tempFilteredProblems)
            }
        }
        
        // MARK: APIs
        func getMoreProblems() {
            if currentPageNumber >= numberOfPages || searchText.isEmpty == false || filteredProblems.count < problems.count {
                return
            }
        
            currentPageNumber += 1
            let reqeust = NetworkRequest(server: .beeceptor, endPoint: .explore, params: ["pageNumber": "\(currentPageNumber)"])
            NetworkManager.shared.makeGetNetworkRequest(reqeust, for: ExploreApiResponse.self)
                .sink { completion in
                    switch completion {
                    case .failure(let error):
                        debugPrint(error)
                    case .finished:
                        debugPrint("finished")
                    }
                } receiveValue: {[weak self] apiResponse in
                    self?.numberOfPages = apiResponse.totalPages ?? 1
                    self?.problemFilters = apiResponse.problemFilter ?? []
                    self?.problems.append(contentsOf: apiResponse.data ?? [])
                    self?.problemFilters.insert(Self.allFilterType, at: 0)
                    self?.newFilterSelected(Self.allFilterType)
                }
                .store(in: &subscribers)
        }
        
        // MARK: Storage
        func persistApiResponse(apiResponse: ExploreApiResponse) {
            // TODO: more code to come.
        }
    }
}
