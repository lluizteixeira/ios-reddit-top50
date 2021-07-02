//
//  Feed.swift
//  Top50
//
//  Created by Luiz Felipe Prestes Teixeira on 02/07/21.
//

import Foundation

class Feed: Codable {
    var after: String?
    var dist: Int = 0
    var children: [PostContainer] = []
}
