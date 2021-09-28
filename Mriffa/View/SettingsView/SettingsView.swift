//
//  SettingsView.swift
//  Mriffa
//
//  Created by Sergei Volkov on 13.09.2021.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.presentationMode) var presentationMode
    @AppStorage(UDKeys.autoSaveInIcloud) var autoSave: Bool = false
    @AppStorage(UDKeys.fv) var isFullVersion: Bool = false
    
    @EnvironmentObject var affirmationVM: AffirmationViewModel
    @EnvironmentObject var categoryVM: CategoryViewModel
    @EnvironmentObject var settingsVM: SettingsViewModel
    @EnvironmentObject var themeVM: ThemeViewModel
    @EnvironmentObject var alertManager: AlertManager

    @State var sheetType: SheetTypes? = nil
    @State private var downloadError: Error!
    
    init() {
        UITableView.appearance().backgroundColor = .clear
        UITableViewCell.appearance().backgroundColor = .clear
    }
    
    
    var body: some View {
        
        NavigationView {
            
            Form {
                Section(header: Text("Purchases").foregroundColor(.white)) {
                    SettingsButton(label: "Pro version", systemImage: "crown.fill") {
                        
                    }
                    SettingsButton(label: "Restore purchases", systemImage: "purchased.circle") {
                        
                    }
                }
                Section(header: Text("iCloud").foregroundColor(.white),
                        footer: isFullVersion ? Text("") : Text("Saving data to iCloud is only available in the Pro version!")) {
                    Toggle("Auto save", isOn: $autoSave)
                        .foregroundColor(isFullVersion ? .white : .gray)
                    if !autoSave {
                        SettingsButton(label: "Save data", systemImage: "icloud.and.arrow.up") {
                            settingsVM.saveDataToIcloud()
                        }
                        SettingsButton(label: "Restore data", systemImage: "icloud.and.arrow.down") {
                            settingsVM.downloadFromIcloud()
                        }
                    }
                    
                }
                .disabled(!isFullVersion)
                Section(header: Text("User's data").foregroundColor(.white)) {
                    SettingsButton(label: "Favorites", systemImage: "heart.fill") {
                        sheetType = .favorites
                    }
                    SettingsButton(label: "Themes", systemImage: "paintbrush") {
                        sheetType = .themes
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
                default: EmptyView()
                }
            }
            .alert(item: $alertManager.alertType) { item in
                alertManager.createAlert(alertType: item)
            }
        }
        .colorScheme(.dark)
        
    }
}
