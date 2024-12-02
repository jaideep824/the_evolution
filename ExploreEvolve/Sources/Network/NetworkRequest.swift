//
//  NetworkRequest.swift
//  ExploreEvolve
//
//  Created by Jaideep on 01/12/24.
//

import Foundation

enum Server: String {
    case beeceptor
    case xyz // any other server which app interact with
    
    // MARK: Computed Properties
    var baseURL: String {
        switch self {
        case .beeceptor:
            return "https://evolve.free.beeceptor.com"
        default:
            fatalError("This server is not handled in the app.")
        }
    }
}


enum URLEndPoint: String {
    case explore = "explore"
    // any other endpoint app supports
}


struct NetworkRequest {
    // MARK: Stored Propertiess
    let server: Server
    let endPoint: URLEndPoint
    let params: [String: String]
    
    // MARK: Computed Properties
    var url: URL? {
        let baseURL = server.baseURL
        let endPoint = endPoint.rawValue
        var urlString = baseURL + "/" + endPoint
        for (index, dict) in params.enumerated() {
            urlString += index == 0 ? "?" : "&"
            urlString += "\(dict.key)=\(dict.value)" 
        }
        
        debugPrint("URL string generated is \(urlString)")
        if let urlString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
            return URL(string: urlString)
        }
        
        return nil
    }
}
