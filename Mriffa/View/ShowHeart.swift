//
//  ShowHeart.swift
//  Mriffa
//
//  Created by Sergei Volkov on 25.08.2021.
//

import SwiftUI

struct ShowHeart: View {
    
    @EnvironmentObject var settingsVM: SettingsViewModel
    @Binding var showHeart: Bool
    
    var body: some View {
        
        if showHeart {
            Image(systemName: "heart.fill")
                .font(.system(size: settingsVM.affirmationFontSize + 40))
                .shadow(color: Color(UIColor.gray).opacity(0.9), radius: 4, x: 6, y: 6)
                .transition(.asymmetric(insertion: .scale, removal: .opacity))
        } else {
            EmptyView()
        }
    }
}

