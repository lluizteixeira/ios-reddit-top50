//
//  Util.swift
//  Top50Tests
//
//  Created by Luiz Felipe Prestes Teixeira on 05/07/21.
//

import Foundation
@testable import Top50

class Util {
    static func readLocalFeedFile() -> [PostContainer] {
        do {
            if let bundlePath = Bundle(for: self).path(forResource: "mock_feed",
                                                 ofType: "json"),
                let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                
                let decodedData = try JSONDecoder().decode(FeedContainer.self, from: jsonData)
                
                return decodedData.data?.children ?? []
            }
        } catch {
            return []
        }
        return []
    }
}
