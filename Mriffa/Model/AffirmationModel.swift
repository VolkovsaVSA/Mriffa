//
//  AffirmationModel.swift
//  Mriffa
//
//  Created by Sergei Volkov on 11.08.2021.
//

import Foundation

struct AffirmationModel: Identifiable, Codable, Equatable {
    var id = UUID()
    let category: Category
    let text: String
    var isFavorite = false
}
