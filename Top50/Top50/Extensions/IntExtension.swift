//
//  IntExtension.swift
//  Top50
//
//  Created by Luiz Felipe Prestes Teixeira on 04/07/21.
//

import Foundation

extension Int {
    func toDate() -> Date {
        return Date(timeIntervalSince1970: TimeInterval(self))
    }
}
