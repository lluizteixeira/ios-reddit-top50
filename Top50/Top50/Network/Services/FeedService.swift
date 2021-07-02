//
//  FeedService.swift
//  Top50
//
//  Created by Luiz Felipe Prestes Teixeira on 01/07/21.
//

import Foundation

class FeedService {
    
    class func get(_ limit: Int = 0, onSuccess: @escaping () -> Void, onFail: @escaping (_ error: String) -> Void) {
        
        let url = URL(string: "https://www.reddit.com/r/popular/top.json?limit=\(limit)")!
        _ = URLSession.shared
            .dataTaskPublisher(for: url)
            .tryMap{ element -> Data in
                guard let httpResponse = element.response as? HTTPURLResponse,
                      httpResponse.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                return element.data
            }
            .decode(type: Post.self, decoder: JSONDecoder())
            .sink(receiveCompletion: {
                    print("completion: \($0)")
            },receiveValue: {
                post in print("Received: \(post)")
            })
    }
}
