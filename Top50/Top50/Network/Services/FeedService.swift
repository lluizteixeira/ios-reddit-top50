//
//  FeedService.swift
//  Top50
//
//  Created by Luiz Felipe Prestes Teixeira on 01/07/21.
//

import Foundation
import Combine

class FeedService {
    
    class func get(_ after: String = "") -> AnyPublisher<FeedContainer, Error> {
        
        let url = URL(string: "https://www.reddit.com/r/popular/top.json?limit=10&after=\(after)")!
        
        print("REQUEST URL \n \(url) \n")
        
        return URLSession.shared
            .dataTaskPublisher(for: url)
            .tryMap{ element -> Data in
                guard let httpResponse = element.response as? HTTPURLResponse,
                      httpResponse.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                
                print("RESPONSE \n \(String.init(data: element.data, encoding: .utf8) ?? "NO DATA") \n")
                return element.data
            }
            .decode(type: FeedContainer.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
