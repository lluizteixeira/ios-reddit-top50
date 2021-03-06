//
//  StoryboardEnum.swift
//  Top50
//
//  Created by Luiz Felipe Prestes Teixeira on 01/07/21.
//

import Foundation
import UIKit

// Enum IDs for stortyboard
enum UIStoryboardEnum: String {
    case main
        
    var identifier: String {
        return self.rawValue.capitalized
    }
}
