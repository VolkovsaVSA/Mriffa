//
//  AffirmationButtons.swift
//  Mriffa
//
//  Created by Sergei Volkov on 20.08.2021.
//

import SwiftUI

struct AffirmationButtons: View {
    
    @EnvironmentObject var affirmationVM: AffirmationViewModel
    @EnvironmentObject var settingsVM: SettingsViewModel
    @EnvironmentObject var categoryVM: CategoryViewModel
    @State var showShareSheet = false

    let affirmation: AffirmationModel
    let action: ()->()
    
    private var globalAffirmation: AffirmationModel? {
        return affirmationVM.affirmation.filter {$0.id == affirmation.id}.first
    }
    private func isFavoriteToggle() {
        for (index, value) in affirmationVM.affirmation.enumerated() {
            if value.id == affirmation.id {
                if affirmationVM.favorites.last?.id == affirmationVM.affirmation[index].id {
                    if affirmationVM.favoritesIndex != 0 {
                        affirmationVM.favoritesIndex -= 1
                        action()
//                        withAnimation {
//                            affirmationVM.updatedID = UUID()
//                        }
                        
                    }
                }
                withAnimation {
                    affirmationVM.affirmation[index].isFavorite.toggle()
//                    affirmationVM.updatedID = UUID()
                }
                withAnimation(.interactiveSpring()) {
                    if affirmationVM.affirmation[index].isFavorite {
                        affirmationVM.showHeart = true
                    }
                }
            }
        }
        DataManager.Affirmation.saveAffirmations(affirmations: affirmationVM.affirmation)
    }

    var body: some View {
        if categoryVM.selectedCategories.isEmpty {
            EmptyView()
        } else {
            HStack(alignment: .center, spacing: settingsVM.affirmationFontSize + 10) {
                Button {
                    showShareSheet = true
                } label: {
                    Image(systemName: "square.and.arrow.up")
                }
                Button {
                    isFavoriteToggle()
                } label: {
                    Image(systemName: (globalAffirmation?.isFavorite ?? false) ? "heart.fill" : "heart")
                }
            }
            .font(.system(size: settingsVM.affirmationFontSize, weight: .light, design: .default))
            .offset(y: -140)
            .sheet(isPresented: $showShareSheet) {
                ShareSheet(sharing: [affirmation.text, "\n" + "Mriffa: " + AppId.appUrl!.description])
            }
        }
        
        
    }
}
