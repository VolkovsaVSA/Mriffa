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
            return 46
        @unknown default:
            return 32
        }
    }
    
    var categoryBackgroundFrame: CGFloat {
        print(UIScreen.main.bounds.width)
        switch UIDevice.current.userInterfaceIdiom {
        case .pad:
            switch UIScreen.main.bounds.width {
            case 768: return UIScreen.main.bounds.width / 3.7
            case 1024: return UIScreen.main.bounds.width / 4.9
            default: return UIScreen.main.bounds.width / 4
            }
        @unknown default:
            return UIScreen.main.bounds.width / 2.3
        }
    }
   
}