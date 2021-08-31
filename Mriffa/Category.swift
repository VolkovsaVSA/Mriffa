//
//  Chapter.swift
//  Mriffa
//
//  Created by Sergei Volkov on 11.08.2021.
//

import Foundation

enum Category: String, CaseIterable, Codable {
    case health = "Health"
    case success = "Success"
    case energy = "Energy, power"
    case luck = "Luck"
    case selfConfidence = "Self confidence"
    case stressAndAnxiety = "Stress and anxiety"
    case personalGrowth = "Personal growth"
    
    
    var localizedTitle: String {
        return NSLocalizedString(self.rawValue, comment: "enum category")
    }
}
