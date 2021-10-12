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
    let containerName = "Mriffa"
    
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
    
    func openUrl(openurl: URL?) {
        if let url = openurl {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    func purchasingFullversion() {
        AlertManager.shared.alertTitle = NSLocalizedString(LocalTxt.attention, comment: "purchasing alert")
        AlertManager.shared.alertText = NSLocalizedString("Buying the Pro version you get:\n1. No ads in the app\n2. Saving a backup to icloud\n\nDo you want buy Pro version?", comment: "purchasing alert")
        AlertManager.shared.secondButtonTitle = NSLocalizedString("Buy Pro version", comment: "purchasing alert")
        AlertManager.shared.alertAction = {
            if !IAPManager.shared.products.isEmpty {
                IAPManager.shared.purshase(product: IAPManager.shared.products.first!)
            }
        }
        AlertManager.shared.alertType = .twoButton
    }
    
    func downloadFromIcloud() {
        ICloudDocumentsManager.downloadFilesFromIcloud(localFolder: DataManager.localFolderURL,
                                                       folder: SettingsViewModel.shared.iCloudFolder,
                                                       containerName: containerName) { error in
            if let localDownloadError = error {
                self.icloudDataError(localDownloadError)
                print("download error: \(localDownloadError)")
            } else {
                UserDefaults.standard.setValue(true, forKey: UDKeys.noFirstRun)
                AffirmationViewModel.shared.affirmation = DataManager.Affirmation.loadAffirmations()
                CategoryViewModel.shared.selectedCategories = DataManager.Categories.loadSelectedCategory()
                ThemeViewModel.shared.selectedTheme = DataManager.Theme.loadSelectedTheme() ?? ThemeViewModel.shared.randomTheme()
                CategoryViewModel.shared.updatedID = UUID()
                AffirmationViewModel.shared.updateAffirmation()
                
                self.icloudDataSuccess(text: NSLocalizedString("Backup data has been restored from your iCloud", comment: ""))
            }
            
        }
    }
    private func icloudDataError(_ dataError: Error) {
        AlertManager.shared.alertTitle = LocalTxt.error
        AlertManager.shared.alertText = dataError.localizedDescription
        AlertManager.shared.alertAction = {}
        AlertManager.shared.alertType = .oneButton
    }
    private func icloudDataSuccess(text: String) {
        AlertManager.shared.alertTitle = LocalTxt.success
        AlertManager.shared.alertText = text
        AlertManager.shared.alertAction = {}
        AlertManager.shared.alertType = .oneButton
    }
    private func saveFilesToCloud() {
        ICloudDocumentsManager.saveFilesToICloudDOcuments(localFilePaths: DataManager.localFilePaths(),
                                                          icloudFolder: SettingsViewModel.shared.iCloudFolder) { result in
            switch result {
            case .failure(let error):
                self.icloudDataError(error)
            case .success(_):
                self.icloudDataSuccess(text: NSLocalizedString("Backup data has been saved in your iCloud", comment: " "))
            }
        }
        
    }

    func checkDataToIcloud() {

        ICloudDocumentsManager.checkFilesInIcloud(folder: SettingsViewModel.shared.iCloudFolder) { result in
            switch result {
            case .failure(let error):
                switch error {
                case ICloudDocumentsManager.ICloudError.iCloudAccessDenied:
                    SettingsViewModel.shared.icloudDataError(error)
                default: self.saveFilesToCloud()
                }
            case .success(let files):
                print(files)
                
                AlertManager.shared.alertTitle = LocalTxt.attention
                AlertManager.shared.alertText = NSLocalizedString("You have backup data! If you save your current data, then the backup will be overwritten! Do you want to save your data?", comment: " ")
                AlertManager.shared.secondButtonTitle = NSLocalizedString("Save", comment: " ")
                AlertManager.shared.alertAction = {
                    self.saveFilesToCloud()
                }
                AlertManager.shared.alertType = .twoButton
            }
        }

    }
    
   
}
