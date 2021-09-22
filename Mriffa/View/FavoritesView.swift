//
//  FavoritesView.swift
//  Mriffa
//
//  Created by Sergei Volkov on 07.09.2021.
//

import SwiftUI

struct FavoritesView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var affirmationVM: AffirmationViewModel
    @EnvironmentObject var settingsVM: SettingsViewModel
    @EnvironmentObject var themeVM: ThemeViewModel
    
    
    var body: some View {
        
        ZStack {
            if affirmationVM.favorites.isEmpty {
                Text("No favorite affirmations")
                    .foregroundColor(.white)
                    .font(.system(size: settingsVM.affirmationFontSize, weight: .bold, design: .default))
                    .multilineTextAlignment(.center)
                    .frame(width: UIScreen.main.bounds.width)
                    .padding()
            } else {
                AffirmationScroll(affirmations: affirmationVM.favorites)
                    .id(settingsVM.refreshedID)
            }
            
            FavoritesDismissButton {
                presentationMode.wrappedValue.dismiss()
            }
            .padding(.top, 50)
            .padding(.trailing, 30)
        }
        .ignoresSafeArea()
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height + 8, alignment: .center)
        .offset(y: 8)
        .background(
            BluredBackgroundView()
                .id(settingsVM.refreshedID)
        )
        .onDisappear() {
            AdsViewModel.shared.showInterstitial = true
        }
        
    }
}
