//
//  AffirmationButtons.swift
//  Mriffa
//
//  Created by Sergei Volkov on 20.08.2021.
//

import SwiftUI

struct AffirmationButtons: View {
    
    @EnvironmentObject var affrimationVM: AffirmationViewModel
    @EnvironmentObject var settingsVM: SettingsViewModel
    @EnvironmentObject var categoryVM: CategoryViewModel

    
    let localIndex: Int!
    
    var body: some View {
        if categoryVM.selectedCategories.isEmpty {
            EmptyView()
        } else {
            HStack(alignment: .center, spacing: settingsVM.affirmationFontSize + 10) {
                Button {
                    
                } label: {
                    Image(systemName: "square.and.arrow.up")
                }
                Button {
                    affrimationVM.affirmation[localIndex].isFavorite.toggle()
                    DataManager.Affirmation.saveAffirmations(affirmations: affrimationVM.affirmation)
                    withAnimation(.interactiveSpring()) {
                        if affrimationVM.affirmation[localIndex].isFavorite {
                            affrimationVM.showHeart = true
                        }
                    }
                } label: {
                    Image(systemName: affrimationVM.affirmation[localIndex].isFavorite ? "heart.fill" : "heart")
                }
            }
//            .foregroundColor(Color(UIColor.label))
            .font(.system(size: settingsVM.affirmationFontSize, weight: .light, design: .default))
            .offset(y: -140)
        }
        
    }
}

