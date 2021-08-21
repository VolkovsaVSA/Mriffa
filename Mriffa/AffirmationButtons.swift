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
    
    let localIndex: Int!
    
    var body: some View {
        HStack(alignment: .center, spacing: settingsVM.affirmationFontSize + 10) {
            Button {
                
            } label: {
                Image(systemName: "square.and.arrow.up")
            }
            Button {
                affrimationVM.affirmation[localIndex].isFavorite.toggle()
                withAnimation(.interactiveSpring()) {
                    if affrimationVM.affirmation[localIndex].isFavorite {
                        affrimationVM.showHeart = true
                    }
                }
            } label: {
                Image(systemName: affrimationVM.affirmation[localIndex].isFavorite ? "heart.fill" : "heart")
            }
        }
        .foregroundColor(Color(UIColor.label))
        .font(.system(size: settingsVM.affirmationFontSize, weight: .light, design: .default))
        .offset(y: -140)
    }
}

