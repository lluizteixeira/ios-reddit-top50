//
//  UITableviewExtension.swift
//  Top50
//
//  Created by Luiz Felipe Prestes Teixeira on 05/07/21.
//

import Foundation
import UIKit

extension UITableView {
    func addFooterLoader() {
        self.tableFooterView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: self.frame.width, height: 50.0))
        let activity: UIActivityIndicatorView = UIActivityIndicatorView.init(style: .medium)
            activity.color = .orange
        activity.frame = CGRect.init(x: 0, y: 0, width: self.frame.width, height: 50.0)
        activity.startAnimating()
        activity.isHidden = false
        self.tableFooterView?.addSubview(activity)
    }
    
    func removeFooterLoader() {
        self.tableFooterView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: self.frame.width, height: 1.0))
    }
}
