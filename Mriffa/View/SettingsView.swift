//
//  SettingsView.swift
//  Mriffa
//
//  Created by Sergei Volkov on 13.09.2021.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var themeVM: ThemeViewModel
    
    init() {
        UITableView.appearance().backgroundColor = .clear
        UITableViewCell.appearance().backgroundColor = .clear
    }
    
    var body: some View {
        
        NavigationView {
            
            Form {
                Section(header: Text("Purchases")) {
                    Label("Remove ads", systemImage: "nosign")
                    Label("Restore purchases", systemImage: "purchased.circle")
                }
                Text("Hello, World!")
                Text("Hello, World!")
            }
            
            .navigationTitle("Settings")
            .navigationBarItems(trailing: NavDismissButton() {
                presentationMode.wrappedValue.dismiss()
            })
            .background(
                ZStack {
                    Image(themeVM.selectedTheme.image)
                        .resizable()
                        .scaledToFill()
                        .overlay(Color.black.opacity(0.7))
                        .blur(radius: 6)
                }
                .ignoresSafeArea()
            )
        }
        .colorScheme(.dark)
        
    }
}
