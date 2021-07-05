//
//  FeedService.swift
//  Top50
//
//  Created by Luiz Felipe Prestes Teixeira on 01/07/21.
//

import Foundation
import Combine

class FeedService {
    
    /// get - Get remote feed from Reddit API using URLSession and Combine
    ///
    /// ```
    /// get("optional id for next page")
    /// ```
    /// - Parameter after: string id for the next page of posts
    /// - Returns: an `AnyPublisher<FeedContainer, Error>`.
    ///
    class func get(_ after: String = "") -> AnyPublisher<FeedContainer, Error> {
        
        let url = URL(string: "https://www.reddit.com/r/popular/top.json?limit=10&after=\(after)")!
        
        #if DEBUG
        print("REQUEST URL \n \(url) \n")
        #endif
        
        return URLSession.shared
            .dataTaskPublisher(for: url)
            .tryMap{ element -> Data in
                guard let httpResponse = element.response as? HTTPURLResponse,
                      httpResponse.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                
                #if DEBUG
                    print("RESPONSE \n \(String.init(data: element.data, encoding: .utf8) ?? "NO DATA") \n")
                #endif
                
                return element.data
            }
            .decode(type: FeedContainer.self, decoder: JSONDecoder()) //Decode result to main object FeedContainer
            .eraseToAnyPublisher()
    }
}
