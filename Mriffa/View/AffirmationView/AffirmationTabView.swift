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
    @State var sheet: SheetTypes? = nil
    
    var body: some View {
        HStack(alignment: .center, spacing: settingsVM.affirmationFontSize/2) {
            TabButton(imageSystemName: "square.grid.2x2") {
                sheet = .categories
            }
            TabButton(imageSystemName: "play") {
                sheet = .fonts
            }
            TabButton(imageSystemName: "heart.fill") {
                sheet = .favorites
            }
            Spacer()
            TabButton(imageSystemName: "paintbrush") {
                sheet = .themes
            }
            TabButton(imageSystemName: "gear") {
                
            }
        }
        .padding(.horizontal, settingsVM.affirmationFontSize)
        .fullScreenCover(item: $sheet) { item in
            switch item {
            case .categories:
                CategoryView(columnWidth: settingsVM.categoryBackgroundFrame)
                    .environmentObject(settingsVM)
                    .environmentObject(categoryVM)
            case .favorites:
                FavoritesView()
                    .ignoresSafeArea()
            case .themes:
                ThemeView(columnWidth: settingsVM.categoryBackgroundFrame)
            case .fonts:
                FontsView()
            default: EmptyView()
            }
        }
        
    }
}


