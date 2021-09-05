//
//  CategoryViewModel.swift
//  Mriffa
//
//  Created by Sergei Volkov on 27.08.2021.
//

import Foundation

class CategoryViewModel: ObservableObject {
    
    static let shared = CategoryViewModel()
    
    @Published var selectedCategories: Set<CategoryModel>
    @Published var categories = [CategoryModel]()
    
    init() {
        selectedCategories = DataManager.Category.loadSelectedCategory()
        Category.allCases.forEach { category in
            categories.append(CategoryModel(category: category, title: category.localizedTitle, image: category.rawValue))
        }
        
    }

}
