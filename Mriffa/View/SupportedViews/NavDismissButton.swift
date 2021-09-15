//
//  NavDismissButton.swift
//  Mriffa
//
//  Created by Sergei Volkov on 10.09.2021.
//

import SwiftUI

struct NavDismissButton: View {
    
    let action: ()->()
    
    var body: some View {
        Button(action: {
            action()
        }, label: {
            Image(systemName: "xmark.circle.fill")
                .foregroundColor(.white)
                .font(.system(size: SettingsViewModel.shared.affirmationFontSize/1.5))
        })
    }
}
