//
//  CategoryModel.swift
//  Mriffa
//
//  Created by Sergei Volkov on 29.08.2021.
//

import Foundation

struct CategoryModel: Equatable, Hashable, Codable {
    let category: Category
    let title: String
    let image: String
}
