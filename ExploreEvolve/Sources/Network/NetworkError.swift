//
//  NetworkError.swift
//  ExploreEvolve
//
//  Created by Jaideep on 01/12/24.
//

import Foundation

enum NetworkError: Error {
    case unresolvedURL
    case scopeEscaped
    case invalidResponse
    case unknown
}
