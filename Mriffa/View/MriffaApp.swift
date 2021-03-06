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
    let themeVM = ThemeViewModel.shared
    let adsVM = AdsViewModel.shared
    let alertManager = AlertManager.shared
    let storeManager = StoreManager.shared
    
    @State var showAlert = false
    
    init() {
        GADMobileAds.sharedInstance().start(completionHandler: nil)
//        IAPManager.shared.getProducts()
        UIDevice.current.setValue(UIInterfaceOrientation.landscapeLeft.rawValue, forKey: "orientation")
//        AppUtility.lockOrientation(.portrait)
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
                .environmentObject(alertManager)
                .environmentObject(storeManager)
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
                }
                
        }
    }
}
