//
//  ThemeModel.swift
//  Mriffa
//
//  Created by Sergei Volkov on 21.08.2021.
//

import SwiftUI

struct ThemeModel: Hashable, Identifiable, Codable {
    var id = UUID()
    let image: String
    let font: String
    let index: Int
    let fontSize: CGFloat
}
