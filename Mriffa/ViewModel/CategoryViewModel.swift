//
//  CategoryViewModel.swift
//  Mriffa
//
//  Created by Sergei Volkov on 27.08.2021.
//

import Foundation

class CategoryViewModel: ObservableObject {
    
    static let shared = CategoryViewModel()
    
    @Published var selectedCategories: Set<CategoryModel> {
        didSet {
            AffirmationViewModel.shared.filteredAffirmation =  AffirmationViewModel.shared.affirmation.filter {
                CategoryViewModel.shared.selectedCategories.contains(CategoryModel(category: $0.category,
                                                                                   title: $0.category.localizedTitle,
                                                                                   image: $0.category.rawValue))
            }
            .shuffled()
            AffirmationViewModel.shared.updatedID = UUID()
//            print(AffirmationViewModel.shared.filteredAffirmation)
        }
    }
//    @Published var selectedCategories: [CategoryModel] {
//        didSet {
//            AffirmationViewModel.shared.filteredAffirmation =  AffirmationViewModel.shared.affirmation.filter {
//                CategoryViewModel.shared.selectedCategories.contains(CategoryModel(category: $0.category,
//                                                                                   title: $0.category.localizedTitle,
//                                                                                   image: $0.category.rawValue))
//            }
//            .shuffled()
//            AffirmationViewModel.shared.updatedID = UUID()
//        }
//    }
    @Published var categories = [CategoryModel]()
    
    init() {
        selectedCategories = DataManager.Category.loadSelectedCategory()
        Category.allCases.forEach { category in
            categories.append(CategoryModel(category: category, title: category.localizedTitle, image: category.rawValue))
        }
        
    }

}
