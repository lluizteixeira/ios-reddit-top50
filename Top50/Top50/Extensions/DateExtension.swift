//
//  DateExtension.swift
//  Top50
//
//  Created by Luiz Felipe Prestes Teixeira on 04/07/21.
//

import Foundation

extension Date {
    func timeAgo() -> String {
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .full
        return formatter.localizedString(for: self, relativeTo: Date())
    }
}
