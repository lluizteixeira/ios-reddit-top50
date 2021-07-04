//
//  UIImageViewExtension.swift
//  Top50
//
//  Created by Luiz Felipe Prestes Teixeira on 04/07/21.
//

import Foundation
import UIKit

extension UIImageView {
    func imageFromUrl(_ url: String, onComplete: @escaping (_ image: UIImage) -> Void) {
        
        guard let imageUrl = URL(string: url) else {
            return
        }
        
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: imageUrl) {
                DispatchQueue.main.async {
                    if let image = UIImage(data: data) {
                        self.image = image
                        onComplete(image)
                    }
                }
            }
        }
    }
}
