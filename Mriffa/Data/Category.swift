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
    case positiveThinking = "Positive thinking"
    case relationship = "Relationship"
    case womans = "Woman's"
    case gratitude = "Gratitude"
    case money = "Money"
    case wisdom = "Wisdom"
    case love = "Love"
    
    
    var localizedTitle: String {
        
        switch self {
        case .health:
            return NSLocalizedString("Health", comment: "enum category")
        case .success:
            return NSLocalizedString("Success", comment: "enum category")
        case .energy:
            return NSLocalizedString("Energy, power", comment: "enum category")
        case .luck:
            return NSLocalizedString("Luck", comment: "enum category")
        case .selfConfidence:
            return NSLocalizedString("Self confidence", comment: "enum category")
        case .stressAndAnxiety:
            return NSLocalizedString("Stress and anxiety", comment: "enum category")
        case .personalGrowth:
            return NSLocalizedString("Personal growth", comment: "enum category")
        case .positiveThinking:
            return NSLocalizedString("Positive thinking", comment: "enum category")
        case .relationship:
            return NSLocalizedString("Relationship", comment: "enum category")
        case .womans:
            return NSLocalizedString("Woman's", comment: "enum category")
        case .gratitude:
            return NSLocalizedString("Gratitude", comment: "enum category")
        case .money:
            return NSLocalizedString("Money", comment: "enum category")
        case .wisdom:
            return NSLocalizedString("Wisdom", comment: "enum category")
        case .love:
            return NSLocalizedString("Love", comment: "enum category")
        }
        
    }
}
