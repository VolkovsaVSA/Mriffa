//
//  AffirmationViewModel.swift
//  Mriffa
//
//  Created by Sergei Volkov on 15.08.2021.
//

import SwiftUI

class AffirmationViewModel: ObservableObject {
    @Published var selectedAffirmation: AffirmationModel?
    @Published var affirmation = healthData
    @Published var showHeart = false {
        didSet {
            if showHeart {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                    withAnimation(.easeOut) {
                        self.showHeart = false
                    }
//                    self.showHeart = false
                }
            }
        }
    }

    func checkFavorite(index: Int)->String {
        return affirmation[index].isFavorite ? "heart" : "heart.fill"
    }
}
