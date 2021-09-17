//
//  AffirView.swift
//  Mriffa
//
//  Created by Sergei Volkov on 14.08.2021.
//

import SwiftUI

struct AffirmationView: View {
    
    @EnvironmentObject var affirmationVM: AffirmationViewModel
    @EnvironmentObject var settingsVM: SettingsViewModel
    @EnvironmentObject var categoryVM: CategoryViewModel
    @EnvironmentObject var themeVM: ThemeViewModel
    
    var body: some View {
        
        ZStack {
            if categoryVM.selectedCategories.isEmpty {
                Text("No selected category")
                    .foregroundColor(.white)
                    .font(.system(size: settingsVM.affirmationFontSize, weight: .bold, design: .default))
                    .multilineTextAlignment(.center)
                    .padding()
            } else {
                AffirmationScroll(affirmations: affirmationVM.filteredAffirmation)
            }
            VStack {
                AdsManager.BannerVC(size: CGSize(width: UIScreen.main.bounds.width, height: 80))
                    .frame(width: UIScreen.main.bounds.width,
                           height: 80,
                           alignment: .center)
                    .offset(y: 36)
                Spacer()
                AffirmationTabView()
            }
            .padding(.bottom, 30)
            
           
        }
        .background(
            Image(uiImage: UIImage(named: themeVM.selectedTheme.image)!)
                .resizable()
                .scaledToFill()
                .overlay(Color.black.opacity(0.4))
//                .blur(radius: 4)
        )
        
    
    }
    
    
}
