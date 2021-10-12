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
    @EnvironmentObject var alertManager: AlertManager
    
    @AppStorage(UDKeys.startView) var noStartupView: Bool = false {
        didSet {
            if noStartupView {
                ICloudDocumentsManager.downloadFilesFromIcloud(localFolder: DataManager.localFolderURL,
                                                               folder: settingsVM.iCloudFolder,
                                                               containerName: settingsVM.containerName) { error in
                    if let downloadError = error {
                        print("download error: \(downloadError)")
                    } else {
                        alertManager.alertTitle = LocalTxt.attention
                        alertManager.alertText = NSLocalizedString("You have backup data! Do you want to restore this data?", comment: " ")
                        alertManager.secondButtonTitle = NSLocalizedString("Restore", comment: " ")
                        alertManager.alertAction = {settingsVM.downloadFromIcloud()}
                        alertManager.alertType = .twoButton
                    }
                }
                UserDefaults.standard.set(true, forKey: UDKeys.noFirstRun)
            }
        }
    }
    
    var body: some View {
        
        ZStack {
            if categoryVM.selectedCategories.isEmpty {
                Text("No selected category")
                    .foregroundColor(.white)
                    .font(.system(size: settingsVM.affirmationFontSize, weight: .bold, design: .default))
                    .multilineTextAlignment(.center)
                    .padding()
            } else {
                AffirmationScroll(affirmations: affirmationVM.filteredAffirmation, index: $affirmationVM.mainIndex)
            }
            VStack {
                if !UserDefaults.standard.bool(forKey: UDKeys.fv) {
                    AdsManager.BannerVC(size: CGSize(width: UIScreen.main.bounds.width, height: 80))
                        .frame(width: UIScreen.main.bounds.width,
                               height: 80,
                               alignment: .center)
                        .offset(y: 36)
                    
                }
                Spacer()
                AffirmationTabView()
                    .disabled(!noStartupView)
            }
            .padding(.bottom, 30)
            
            if !noStartupView {
                StartView()
            }
            
               
           
        }
        .background(
            Image(uiImage: UIImage(named: themeVM.selectedTheme.image)!)
                .resizable()
                .scaledToFill()
                .overlay(Color.black.opacity(0.5))
//                .blur(radius: 4)
        )
        .onAppear() {
//            if !UserDefaults.standard.bool(forKey: UDKeys.noFirstRun) {
//                ICloudDocumentsManager.downloadFilesFromIcloud(localFolder: DataManager.localFolderURL,
//                                                               folder: settingsVM.iCloudFolder,
//                                                               containerName: settingsVM.containerName) { error in
//                    if let downloadError = error {
//                        print("download error: \(downloadError)")
//                    } else {
//                        alertManager.alertTitle = LocalTxt.attention
//                        alertManager.alertText = NSLocalizedString("You have backup data! Do you want to restore this data?", comment: " ")
//                        alertManager.secondButtonTitle = NSLocalizedString("Restore", comment: " ")
//                        alertManager.alertAction = {settingsVM.downloadFromIcloud()}
//                        alertManager.alertType = .twoButton
//                    }
//                }
//                UserDefaults.standard.set(true, forKey: UDKeys.noFirstRun)
//            }
//            
        }
        .alert(item: $alertManager.alertType) { item in
            alertManager.createAlert(alertType: item)
        }
        
    }

    
}
