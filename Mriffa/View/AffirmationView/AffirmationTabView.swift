//
//  AffirmationTabView.swift
//  Mriffa
//
//  Created by Sergei Volkov on 25.08.2021.
//

import SwiftUI

struct AffirmationTabView: View {
    
    @EnvironmentObject var settingsVM: SettingsViewModel
    @EnvironmentObject var categoryVM: CategoryViewModel
    @State var showSheet = false
    
    var body: some View {
        HStack(alignment: .center, spacing: settingsVM.affirmationFontSize/2) {
            TabButton(imageSystemName: "square.grid.2x2") {
                showSheet.toggle()
            }
            TabButton(imageSystemName: "play") {
              
            }
            Spacer()
            TabButton(imageSystemName: "paintbrush") {
                
            }
            TabButton(imageSystemName: "gear") {
                
            }
        }
        .padding(.horizontal, settingsVM.affirmationFontSize)
        .sheet(isPresented: $showSheet, content: {
            CategoryView(columnWidth: settingsVM.categoryBackgroundFrame)
                .environmentObject(settingsVM)
                .environmentObject(categoryVM)
        })
    }
}


