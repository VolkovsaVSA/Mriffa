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
        
        NavigationView {
           
            if affirmationVM.favorites.isEmpty {
                Text("No favorite affirmations")
                    .foregroundColor(.white)
                    .font(.system(size: settingsVM.affirmationFontSize, weight: .bold, design: .default))
                    .multilineTextAlignment(.center)
                    .frame(width: UIScreen.main.bounds.width)
                    .padding()
                    .ignoresSafeArea()
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height, alignment: .center)
                    .background(
                        BluredBackgroundView()
                    )
                    .navigationBarItems(trailing: NavDismissButton() {
                        presentationMode.wrappedValue.dismiss()
                    })
            } else {
                AffirmationScroll(affirmations: affirmationVM.favorites, index: $affirmationVM.favoritesIndex)
                    .ignoresSafeArea()
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height + 8, alignment: .center)
                    .background(
                        BluredBackgroundView()
                    )
                    .navigationTitle(NSLocalizedString("Favorites", comment: "settingsView navTitle"))
                    .navigationBarItems(trailing: NavDismissButton() {
                        presentationMode.wrappedValue.dismiss()
                    })
                   
            }
                
        }
        .colorScheme(.dark)
        .background(
            BluredBackgroundView()
        )
        .onDisappear() {
            AdsViewModel.shared.showInterstitial = true
        }
        
    }
}
