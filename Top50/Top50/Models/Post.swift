//
//  Post.swift
//  Top50
//
//  Created by Luiz Felipe Prestes Teixeira on 01/07/21.
//

import Foundation

struct Post: Codable {
    let author: String?
    let title: String?
    let url: String?
    let thumbnail: String?
    let media: String?
    let num_comments: String?
    let created: String?
}
