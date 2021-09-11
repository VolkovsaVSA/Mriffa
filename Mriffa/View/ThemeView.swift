//
//  ThemeView.swift
//  Mriffa
//
//  Created by Sergei Volkov on 10.09.2021.
//

import SwiftUI

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
    
    var body: some View {
        
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(themeVM.themes, id: \.self) { theme in
                        
                        Button {
                            themeVM.selectedTheme = theme
                            presentationMode.wrappedValue.dismiss()
                        } label: {
                            ZStack {
                                Image(uiImage: theme.image)
                                    .resizable()
                                    .scaledToFill()
                                    .overlay(Color.black.opacity(0.3))
                                Text("Mriffa")
                                    .font(theme.font)
                                    .foregroundColor(.white)
                            }
                            .frame(width: columnWidth - 8, height: columnWidth - 8, alignment: .center)
                            .clipped()
                            .cornerRadius(12)
                            .shadow(color: .black, radius: 6, x: 4, y: 4)
                        }
                            
                    }
                    
                    Button {
                        themeVM.selectedTheme = themeVM.randomTheme()
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        RadialGradient(gradient: Gradient(colors: [.purple, .black]), center: .center, startRadius: 20, endRadius: 80)
                            .frame(width: columnWidth - 8, height: columnWidth - 8, alignment: .center)
                            .clipped()
                            .cornerRadius(12)
                            .shadow(color: .black, radius: 6, x: 4, y: 4)
                            .overlay(Text("Random theme")
                                        .multilineTextAlignment(.center)
                                        .font(.system(size: settingsVM.affirmationFontSize))
                                        .foregroundColor(.white)
                            )
                    }
                    
                }
                .padding(.horizontal)
            }
            .background(
                Image(uiImage: themeVM.selectedTheme.image)
                    .resizable()
                    .scaledToFill()
                    .overlay(Color.black.opacity(0.6))
                    .blur(radius: 4)
            )
            .navigationTitle("Themes")
            .navigationBarItems(
                trailing:
                    NavDismissButton() {
                        presentationMode.wrappedValue.dismiss()
                    }
            )
            .navigationBarTitleDisplayMode(.inline)
        }
        .colorScheme(.dark)
        
        
    }
}
