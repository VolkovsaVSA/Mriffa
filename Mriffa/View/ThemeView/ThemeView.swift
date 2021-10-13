//
//  ThemeView.swift
//  Mriffa
//
//  Created by Sergei Volkov on 10.09.2021.
//

import SwiftUI
import GoogleMobileAds

struct ThemeView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var themeVM: ThemeViewModel
    @EnvironmentObject var settingsVM: SettingsViewModel
    
    private let columnWidth: CGFloat!
    private let columns: [GridItem]!
    
     
    init(columnWidth: CGFloat) {
        self.columnWidth = columnWidth
        self.columns = [GridItem(.adaptive(minimum: columnWidth))]
    }
    
    private var fontSize: CGFloat {
        switch UIDevice.current.userInterfaceIdiom {
        case .pad:
            return 50
        @unknown default:
            return 24
        }
    }
    
    var body: some View {
        
        
        NavigationView {
            
            ScrollView {
                LazyVGrid(columns: columns, spacing: 20) {

                    ForEach(themeVM.themes) { theme in
                        
                        if theme.index == 80 {
                            ThemeCard(text: "Mriffa",
                                      font: Font.custom(theme.font, size: fontSize).bold(),
                                      columnWidth: columnWidth,
                                      theme: theme,
                                      colors: []) {
                                themeVM.selectedTheme = theme
                                presentationMode.wrappedValue.dismiss()
                            }
                        } else {
                            ThemeCard(text: "Mriffa",
                                      font: Font.custom(theme.font, size: theme.fontSize).bold(),
                                      columnWidth: columnWidth,
                                      theme: theme,
                                      colors: []) {
                                themeVM.selectedTheme = theme
                                presentationMode.wrappedValue.dismiss()
                            }
                        }
                        
                    }
                    
                    ThemeCard(text: NSLocalizedString("Random", comment: "theme card"),
                              font: .system(size: settingsVM.affirmationFontSize/1.5),
                              columnWidth: columnWidth,
                              theme: nil,
                              colors: [.purple, .black]) {
                        themeVM.selectedTheme = themeVM.randomTheme()
                        presentationMode.wrappedValue.dismiss()
                    }
                    
//                    ThemeCard(text: "Custom",
//                              font: .system(size: settingsVM.affirmationFontSize),
//                              columnWidth: columnWidth,
//                              theme: nil,
//                              colors: [.black, .purple]) {
//
//                    }

                    
                }
                .padding(.horizontal)
            }
            
            .background(
                BluredBackgroundView()
            )
            .navigationTitle("Themes")
            .navigationBarItems(
                trailing:
                    NavDismissButton() {
                        presentationMode.wrappedValue.dismiss()
                    }
            )
            .onDisappear() {
                AdsViewModel.shared.showInterstitial = true
            }
        }
        .colorScheme(.dark)
        
    }
}
