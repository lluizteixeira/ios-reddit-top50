//
//  UIViewControllerExtension.swift
//  Top50
//
//  Created by Luiz Felipe Prestes Teixeira on 01/07/21.
//

import Foundation
import UIKit

extension UIViewController {
    
    class var identifier: String {
        return String(describing: self)
    }
    
    class func instantiate(_ myIdentifier: String? = nil, storyboard: UIStoryboardEnum) -> UIViewController {
        let storyBoard = UIStoryboard(name: storyboard.identifier, bundle: nil)
        if let viewIdentifier = myIdentifier {
            return storyBoard.instantiateViewController(withIdentifier: viewIdentifier)
        } else {
            return storyBoard.instantiateViewController(withIdentifier: identifier)
        }
    }
    
    func alert(title: String, error message: String,
               button: String = "OK", handler: ((UIAlertAction) -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: button, style: .default, handler: handler))
        self.present(alert, animated: true, completion: nil)
    }
}
