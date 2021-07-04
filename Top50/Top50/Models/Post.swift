//
//  Post.swift
//  Top50
//
//  Created by Luiz Felipe Prestes Teixeira on 01/07/21.
//

import Foundation
import UIKit

class Post: Codable {
    var author: String?
    var title: String?
    var url: String?
    var thumbnail: String?
    var media: Media?
    var num_comments: Int = 0
    var created: Int = 0
    
    var imageFile: UIImage?
    
    enum CodingKeys: CodingKey  { //CodingKeys
        
        case author
        case title
        case url
        case thumbnail
        case media
        case num_comments
        case created
        
    }
}
