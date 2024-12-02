//
//  Problem.swift
//  ExploreEvolve
//
//  Created by Jaideep on 01/12/24.
//

import Foundation

enum PremiumState: String, Codable {
    case premium = "Premium"
    case free = "Free"
}


class Problem: Codable, Identifiable, Equatable, Hashable {
    var id: Int?
    var title: String?
    var juLabel: String?
    var promoText: String?
    var description: String?
    var juType: String?
    var juPremium: String?
    var numDays: Int?
    var thumbImage: String?
    var coverImage: String?
    var problems: [String]?
    var details: String?
    var sessions: String?
    var mins: String?
    var days: [SolutionDay]?
    
    // MARK: Computed Property
    var imageURL: URL? {
        guard let thumbImage else {
            return nil
        }
        
        return URL(string: thumbImage)
    }
    
    var premiumState: PremiumState {
        PremiumState(rawValue: juPremium ?? "") ?? .free
    }
    
    static let example = Problem(id: Int.random(in: 1...100),
                                 title: "Coming out at work",
                                 thumbImage: "https://prod-assets.evolveinc.in/media/journey/thumb/20230414162606.webp",
                                 sessions: "3 sessions",
                                 mins: "7-10 mins")
    
    // MARK: Initialisation
    init(id: Int? = nil, title: String? = nil, thumbImage: String? = nil, sessions: String? = nil, mins: String? = nil) {
        self.id = id
        self.title = title
        self.thumbImage = thumbImage
        self.sessions = sessions
        self.mins = mins
    }
    
    // MARK: Equatable
    static func == (lhs: Problem, rhs: Problem) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
