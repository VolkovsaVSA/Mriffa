//
//  AffirView.swift
//  Mriffa
//
//  Created by Sergei Volkov on 14.08.2021.
//

import Foundation
import SwiftUI
import GoogleMobileAds
import AppTrackingTransparency
import AdSupport

struct AffirmationView: View {
    
    @EnvironmentObject var affirmationVM: AffirmationViewModel
    @EnvironmentObject var settingsVM: SettingsViewModel
    @EnvironmentObject var categoryVM: CategoryViewModel
    @EnvironmentObject var themeVM: ThemeViewModel
    @EnvironmentObject var alertManager: AlertManager
    
    @AppStorage(UDKeys.startView) var noStartupView: Bool = false
    
    var body: some View {
        
        ZStack {
            if categoryVM.selectedCategories.isEmpty {
                Text("No selected category")
                    .foregroundColor(.white)
                    .font(.system(size: settingsVM.affirmationFontSize, weight: .bold, design: .default))
                    .multilineTextAlignment(.center)
                    .padding()
            } else {
                AffirmationScroll(affirmations: affirmationVM.filteredAffirmation, index: $affirmationVM.mainIndex, isMainAffrmationScroll: true)
            }
            VStack {
                if !UserDefaults.standard.bool(forKey: UDKeys.fv) {
                    if noStartupView {
                        AdsManager.BannerVC(size: CGSize(width: UIScreen.main.bounds.width, height: 80))
                            .frame(width: UIScreen.main.bounds.width,
                                   height: 80,
                                   alignment: .center)
                            .offset(y: 36)
                    }
                }
                Spacer()
                AffirmationTabView()
                    .disabled(!noStartupView)
            }
            .id(SettingsViewModel.shared.fullVersionUpdatedID)
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
        .alert(item: $alertManager.alertType) { item in
            alertManager.createAlert(alertType: item)
        }
        .onChange(of: noStartupView) { newValue in
            
            if newValue {
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    ATTrackingManager.requestTrackingAuthorization { status in
                        ICloudDocumentsManager.downloadFilesFromIcloud(localFolder: DataManager.groupContainer,
                                                                       folder: settingsVM.iCloudFolder,
                                                                       containerName: settingsVM.containerName) { error in
                            if let downloadError = error {
                                print("download error: \(downloadError)")
                            } else {
                                DispatchQueue.main.async {
                                    alertManager.alertTitle = LocalTxt.attention
                                    alertManager.alertText = NSLocalizedString("You have backup data! Do you want to restore this data?", comment: " ")
                                    alertManager.secondButtonTitle = NSLocalizedString("Restore", comment: " ")
                                    alertManager.alertAction = {settingsVM.downloadFromIcloud()}
                                    alertManager.alertType = .twoButton
                                }
                                
                            }
                        }
                        UserDefaults.standard.set(true, forKey: UDKeys.noFirstRun)
                    }
                }
                
                
                
            }
        }
        
        
    }

    
}
