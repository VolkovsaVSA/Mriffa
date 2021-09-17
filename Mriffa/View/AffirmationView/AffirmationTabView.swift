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
    
    @State var sheet: SheetTypes? = nil
    
    var body: some View {
        HStack(alignment: .center, spacing: settingsVM.affirmationFontSize/2) {
            TabButton(imageSystemName: "square.grid.2x2") {
                sheet = .categories
            }
            TabButton(imageSystemName: "heart.fill") {
                sheet = .favorites
            }
            Spacer()
            TabButton(imageSystemName: "paintbrush") {
                sheet = .themes
            }
            TabButton(imageSystemName: "gear") {
                sheet = .settings
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
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height + 16, alignment: .center)
                    .offset(y: -10)
            case .themes:
                ThemeView(columnWidth: settingsVM.categoryBackgroundFrame)
            case .fonts:
                FontsView()
            case .settings:
                SettingsView()
            default: EmptyView()
            }
        }
        
        
    }
}


