//
//  SettingsViewModel.swift
//  Mriffa
//
//  Created by Sergei Volkov on 20.08.2021.
//

import SwiftUI

class SettingsViewModel: ObservableObject {
    
    static let shared = SettingsViewModel()
    
    var affirmationFontSize: CGFloat {
        switch UIDevice.current.userInterfaceIdiom {
        case .pad:
            return 50
        @unknown default:
            return 32
        }
    }
}
