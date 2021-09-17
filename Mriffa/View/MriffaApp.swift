//
//  MriffaApp.swift
//  Mriffa
//
//  Created by Sergei Volkov on 11.08.2021.
//

import SwiftUI
import GoogleMobileAds

@main
struct MriffaApp: App {
    
    let affirmationVM = AffirmationViewModel.shared
    let categoryVM = CategoryViewModel.shared
    let settingsVM = SettingsViewModel.shared
    let themeVM = ThemeViewModel()
    let adsVM = AdsViewModel.shared
    
    init() {
        GADMobileAds.sharedInstance().start(completionHandler: nil)
    }
    
    var body: some Scene {
        WindowGroup {
            AffirmationView()
                .colorScheme(.dark)
                .edgesIgnoringSafeArea(.all)
                .environmentObject(affirmationVM)
                .environmentObject(settingsVM)
                .environmentObject(categoryVM)
                .environmentObject(themeVM)
                .environmentObject(adsVM)
                .onAppear() {
                    AffirmationViewModel.shared.filteredAffirmation = AffirmationViewModel.shared.affirmation.filter {
                        CategoryViewModel
                            .shared
                            .selectedCategories
                            .contains(CategoryModel(category: $0.category,
                                                    title: $0.category.localizedTitle,
                                                    image: $0.category.rawValue))
                        
                    }
                    .shuffled()
                    AffirmationViewModel.shared.updatedID = UUID()
                    print("\(UIFont.familyNames.count) \(UIFont.familyNames)")                                             
                }
        }
    }
}
