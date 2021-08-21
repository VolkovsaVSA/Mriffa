//
//  MriffaApp.swift
//  Mriffa
//
//  Created by Sergei Volkov on 11.08.2021.
//

import SwiftUI

@main
struct MriffaApp: App {
    
    let affirmationVM = AffirmationViewModel()
    let settingsVM = SettingsViewModel.shared
    
    var body: some Scene {
        WindowGroup {
            AffirmationView()
                .colorScheme(.dark)
                .edgesIgnoringSafeArea(.all)
                .environmentObject(affirmationVM)
                .environmentObject(settingsVM)
        }
    }
}
