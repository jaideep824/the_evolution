//
//  ProblemFilter.swift
//  ExploreEvolve
//
//  Created by Jaideep on 01/12/24.
//

import Foundation

class ProblemFilter: Codable, Identifiable, Hashable {
    var id: Int?
    var title: String?
    
    static var example = ProblemFilter(id: 100, title: "🧠 Neurodiversity")
    
    init(id: Int?, title: String?) {
        self.id = id
        self.title = title
    }
    
    static func == (lhs: ProblemFilter, rhs: ProblemFilter) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
