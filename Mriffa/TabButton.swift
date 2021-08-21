//
//  TabButton.swift
//  Mriffa
//
//  Created by Sergei Volkov on 21.08.2021.
//

import SwiftUI

struct TabButton: View {
    
    @EnvironmentObject var settingsVM: SettingsViewModel
    
    let imageSystemName: String
    let action: ()->()
    
    var body: some View {
        
        Button {
            action()
        } label: {
            Image(systemName: imageSystemName)
                .foregroundColor(Color(UIColor.label))
                .font(.system(size: settingsVM.affirmationFontSize/1.3))
                .frame(width: settingsVM.affirmationFontSize + 16, height: settingsVM.affirmationFontSize + 16, alignment: .center)
                .background(
                    Blur(style: .systemChromeMaterialDark)
                )
                .cornerRadius(10)
        }

    }
}
