//
//  SettingsView.swift
//  Mriffa
//
//  Created by Sergei Volkov on 13.09.2021.
//

import SwiftUI
import MessageUI

struct SettingsView: View {
    @Environment(\.presentationMode) var presentationMode
    @AppStorage(UDKeys.autoSaveInIcloud) var autoSave: Bool = false
    @AppStorage(UDKeys.fv) var isFullVersion: Bool = false
    
    @EnvironmentObject var affirmationVM: AffirmationViewModel
    @EnvironmentObject var categoryVM: CategoryViewModel
    @EnvironmentObject var settingsVM: SettingsViewModel
    @EnvironmentObject var themeVM: ThemeViewModel
    @EnvironmentObject var alertManager: AlertManager
    
    @ObservedObject var purchaseVM = IAPManager.shared

    @State var sheetType: SheetTypes? = nil
    @State private var downloadError: Error!
    
    @State var mailResult: Result<MFMailComposeResult, Error>? = nil
    
    init() {
        UITableView.appearance().backgroundColor = .clear
        UITableViewCell.appearance().backgroundColor = .clear
    }
    
    
    var body: some View {
        
        LoadingView(isShowing: $purchaseVM.purchaseLoading, text: purchaseVM.purchasingText) {
            NavigationView {
                Form {
                    Section(header: Text("Purchases").foregroundColor(.white)) {
                        SettingsButton(label: NSLocalizedString("Pro version", comment: "settings button"),
                                       systemImage: "crown.fill") {
                            if !purchaseVM.products.isEmpty {
                                purchaseVM.purshase(product: purchaseVM.products.first!)
                            }
                        }
                        SettingsButton(label: NSLocalizedString("Restore purchases", comment: "settings button"),
                                       systemImage: "purchased.circle") {
                            purchaseVM.restoreCompletedTransaction()
                        }
                    }
                    Section(header: Text("iCloud").foregroundColor(.white),
                            footer: isFullVersion ? Text("") : Text("Saving data to iCloud is only available in the Pro version!")) {
                        Toggle("Auto save", isOn: $autoSave)
                            .foregroundColor(isFullVersion ? .white : .gray)
                        if !autoSave {
                            SettingsButton(label: NSLocalizedString("Save data", comment: "settings button"),
                                           systemImage: "icloud.and.arrow.up") {
                                settingsVM.saveDataToIcloud()
                            }
                            SettingsButton(label: NSLocalizedString("Restore data", comment: "settings button"),
                                           systemImage: "icloud.and.arrow.down") {
                                settingsVM.downloadFromIcloud()
                            }
                        }
                        
                    }
                    .disabled(!isFullVersion)
                    Section(header: Text("User's data").foregroundColor(.white)) {
                        SettingsButton(label: NSLocalizedString("Favorites", comment: "settings button"),
                                       systemImage: "heart.fill") {
                            sheetType = .favorites
                        }
                        SettingsButton(label: NSLocalizedString("Themes", comment: "settings button"),
                                       systemImage: "paintbrush") {
                            sheetType = .themes
                        }
                    }
                    Section(header: Text("Feedback").foregroundColor(.white)) {
                        SettingsButton(label: LocalTxt.rateApp,
                                       systemImage: "star.fill") {
                            settingsVM.openUrl(openurl: AppId.appUrl)
                        }
                        SettingsButton(label: LocalTxt.sendEmailToTheDeveloper,
                                       systemImage: "mail.fill") {
                            if MFMailComposeViewController.canSendMail() {
                                sheetType = .sendMail
                            }
                        }
                        SettingsButton(label: LocalTxt.otherApplications,
                                       systemImage: "arrow.down.app.fill") {
                            settingsVM.openUrl(openurl: AppId.developerUrl)
                        }
                    }

                    
                }
                
                .navigationTitle("Settings")
                .navigationBarItems(trailing: NavDismissButton() {
                    presentationMode.wrappedValue.dismiss()
                })
                .background(
                    BluredBackgroundView()
                )
                .sheet(item: $sheetType) { item in
                    switch item {
                    case .favorites: FavoritesView()
                    case .themes: ThemeView(columnWidth: settingsVM.categoryBackgroundFrame)
                    case .sendMail:
                        MailView(result: $mailResult,
                                 recipients: [AppId.feedbackEmail],
                                 messageBody: LocalTxt.feedbackOnApplication)
                    default: EmptyView()
                    }
                }
                .alert(item: $alertManager.alertType) { item in
                    alertManager.createAlert(alertType: item)
                }
                .onAppear() {
                    purchaseVM.getProducts()
                }
                .onDisappear() {
                    purchaseVM.purchaseLoading = false
                }
            }
        }
        
        
        .colorScheme(.dark)
        
    }
}
