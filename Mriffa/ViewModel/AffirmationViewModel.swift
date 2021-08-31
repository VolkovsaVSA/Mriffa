//
//  AffirmationViewModel.swift
//  Mriffa
//
//  Created by Sergei Volkov on 15.08.2021.
//

import SwiftUI

class AffirmationViewModel: ObservableObject {

    @Published var selectedAffirmation: AffirmationModel?
    @Published var affirmation: [AffirmationModel]
//        = testData.filter {
//        CategoryViewModel
//            .shared
//            .selectedCategories.contains(CategoryModel(category: $0.category,
//                                                       title: $0.category.localizedTitle,
//                                                       image: $0.category.rawValue))
//    }.shuffled()
    @Published var showHeart = false {
        didSet {
            if showHeart {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                    withAnimation(.easeOut) {
                        self.showHeart = false
                    }
                }
            }
        }
    }

    func checkFavorite(index: Int)->String {
        return affirmation[index].isFavorite ? "heart" : "heart.fill"
    }
    
    init() {
        if UserDefaults.standard.bool(forKey: UDKeys.noFirstRun) {
            affirmation = DataManager.Affirmation.loadAffirmations().shuffled()
        } else {
            affirmation = testData.filter {
                CategoryViewModel
                    .shared
                    .selectedCategories.contains(CategoryModel(category: $0.category,
                                                               title: $0.category.localizedTitle,
                                                               image: $0.category.rawValue))
            }
//            .shuffled()
        }
    }
}
