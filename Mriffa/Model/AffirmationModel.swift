//
//  AffirmationModel.swift
//  Mriffa
//
//  Created by Sergei Volkov on 11.08.2021.
//

import Foundation

struct AffirmationModel: Identifiable {
    let id = UUID()
    let chapter: Chapter
    let text: String
    var isFavorite = false
}


