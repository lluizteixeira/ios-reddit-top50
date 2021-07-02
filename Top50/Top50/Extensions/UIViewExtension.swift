//
//  UIViewExtension.swift
//  Top50
//
//  Created by Luiz Felipe Prestes Teixeira on 02/07/21.
//

import Foundation
import UIKit

extension UIView {   
    @IBInspectable
    var cornerRadius: CGFloat {
        set {
            layer.cornerRadius = newValue
        }
        get {
            return layer.cornerRadius
        }
    }
}
