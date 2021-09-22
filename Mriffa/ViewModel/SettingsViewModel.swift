//
//  SettingsViewModel.swift
//  Mriffa
//
//  Created by Sergei Volkov on 20.08.2021.
//

import SwiftUI

class SettingsViewModel: ObservableObject {
    static let shared = SettingsViewModel()

    @Published var ads = AdsManager.init()

    var affirmationFontSize: CGFloat {
        switch UIDevice.current.userInterfaceIdiom {
        case .pad:
            return 50
        @unknown default:
            return 32
        }
    }
    
    var selectedTheme: ThemeModel!
    let iCloudFolder: ICloudDocumentsManager.ICloudFolder = .mainHiddenFolder
    
    var categoryBackgroundFrame: CGFloat {
//        print(UIScreen.main.bounds.width)
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
    
    func downloadFromIcloud() {
        ICloudDocumentsManager.downloadFilesFromIcloud(localFolder: DataManager.localFolderURL, folder: SettingsViewModel.shared.iCloudFolder, containerName: "Mriffa") { error in
            if let downloadError = error {
                print("download error: \(downloadError)")
            } else {
                UserDefaults.standard.setValue(true, forKey: UDKeys.noFirstRun)
                AffirmationViewModel.shared.affirmation = DataManager.Affirmation.loadAffirmations()
                CategoryViewModel.shared.selectedCategories = DataManager.Category.loadSelectedCategory()
                ThemeViewModel.shared.selectedTheme = DataManager.Theme.loadSelectedTheme() ?? ThemeViewModel.shared.randomTheme()
                AffirmationViewModel.shared.updateAffirmation()
                CategoryViewModel.shared.updatedID = UUID()
            }
            
        }
    }
   
}
