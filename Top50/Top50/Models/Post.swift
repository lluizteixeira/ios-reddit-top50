//
//  Post.swift
//  Top50
//
//  Created by Luiz Felipe Prestes Teixeira on 01/07/21.
//

import Foundation

class Post: Codable {
    var author: String?
    var title: String?
    var url: String?
    var thumbnail: String?
    var media: Media?
    var num_comments: Int = 0
    var created: Int = 0
}
