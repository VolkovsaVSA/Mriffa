//
//  Chapter.swift
//  Mriffa
//
//  Created by Sergei Volkov on 11.08.2021.
//

import Foundation

enum Chapter: String, CaseIterable {
    case health = "Health"
    case success = "Success"
    case energy = "Energy, power"
    
    var localizedTitle: String {
        return NSLocalizedString(self.rawValue, comment: " ")
    }
}
