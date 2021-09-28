//
//  AffirmationViewModel.swift
//  Mriffa
//
//  Created by Sergei Volkov on 15.08.2021.
//

import SwiftUI

class AffirmationViewModel: ObservableObject {
    
    static let shared = AffirmationViewModel()
    
    init() {
        if UserDefaults.standard.bool(forKey: UDKeys.noFirstRun) {
            affirmation = DataManager.Affirmation.loadAffirmations()
        } else {
            affirmation = AffirmationDefaultData
        }
    }

    @Published var selectedAffirmation: AffirmationModel?
    @Published var affirmation: [AffirmationModel]
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

    @Published var updatedID = UUID()
    @Published var filteredAffirmation: [AffirmationModel] = []
    
    @Published var mainIndex = 0
    @Published var favoritesIndex = 0
    
    var favorites: [AffirmationModel] {
        return affirmation.filter { $0.isFavorite }
    }

    func checkFavorite(index: Int)->String {
        return affirmation[index].isFavorite ? "heart" : "heart.fill"
    }
    func updateAffirmation() {
        AffirmationViewModel.shared.filteredAffirmation = AffirmationViewModel.shared.affirmation.lazy.filter {
            CategoryViewModel.shared.selectedCategories.contains(CategoryModel(category: $0.category,
                                                                               title: $0.category.localizedTitle,
                                                                               image: $0.category.rawValue))
        }
        .shuffled()
        withAnimation {
            AffirmationViewModel.shared.updatedID = UUID()
        }
        
        
    }
}
