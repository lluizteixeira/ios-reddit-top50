//
//  UIViewControllerExtension.swift
//  Top50
//
//  Created by Luiz Felipe Prestes Teixeira on 01/07/21.
//

import Foundation
import UIKit

extension UIViewController {
    
    // Get UIViewController identifier - usually its own file name
    class var identifier: String {
        return String(describing: self)
    }
    
    /// instantiate - Instatiate UIViewController by identifier (file name) or specific id
    /// storyboard enum required
    ///
    /// ```
    /// instantiate()
    /// ```
    /// - Parameter myIdentifier: string for specific identifier
    /// - Parameter storyboard: enum for the storyboard where view controller is
    /// - Returns: an `UIViewController`.
    ///
    class func instantiate(_ myIdentifier: String? = nil, storyboard: UIStoryboardEnum) -> UIViewController {
        let storyBoard = UIStoryboard(name: storyboard.identifier, bundle: nil)
        if let viewIdentifier = myIdentifier {
            return storyBoard.instantiateViewController(withIdentifier: viewIdentifier)
        } else {
            return storyBoard.instantiateViewController(withIdentifier: identifier)
        }
    }
    
    /// alert - Default alert for messages
    ///
    /// ```
    /// alert()
    /// ```
    /// - Parameter title: string for title
    /// - Parameter message: error message
    /// - Parameter button: title for main button
    /// - Parameter handler: callback handler for actions
    ///
    func alert(title: String, error message: String,
               button: String = "OK", handler: ((UIAlertAction) -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: button, style: .default, handler: handler))
        self.present(alert, animated: true, completion: nil)
    }
}
