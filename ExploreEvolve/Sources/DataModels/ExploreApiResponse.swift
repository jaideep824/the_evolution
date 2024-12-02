//
//  ExploreApiResponse.swift
//  ExploreEvolve
//
//  Created by Jaideep on 01/12/24.
//

import Foundation
import SwiftData

class ExploreApiResponse: Codable {
    let status: Bool?
    let totalPages: Int?
    let premiumStatus: Int?
    let problemFilter: [ProblemFilter]?
    let data: [Problem]?
}
