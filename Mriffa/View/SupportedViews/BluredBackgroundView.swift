//
//  BackgroundView.swift
//  Mriffa
//
//  Created by Sergei Volkov on 18.09.2021.
//

import SwiftUI

struct BluredBackgroundView: View {
    @EnvironmentObject var themeVM: ThemeViewModel
    
    var body: some View {
        ZStack {
            Image(themeVM.selectedTheme.image)
                .resizable()
                .scaledToFill()
                .overlay(Color.black.opacity(0.7))
                .blur(radius: 6)
        }
        .ignoresSafeArea()
    }
}

