//
//  IntExtension.swift
//  Top50
//
//  Created by Luiz Felipe Prestes Teixeira on 04/07/21.
//

import Foundation

extension Int {
    
    /// toDate - Get a Date from a given Int
    ///
    /// ```
    /// toDate()
    /// ```
    ///
    /// - Returns: Date
    func toDate() -> Date {
        return Date(timeIntervalSince1970: TimeInterval(self))
    }
}
