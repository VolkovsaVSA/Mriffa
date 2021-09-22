//
//  SettingsButton.swift
//  Mriffa
//
//  Created by Sergei Volkov on 17.09.2021.
//

import SwiftUI

struct SettingsButton: View {
    
    let label: String
    let systemImage: String
    let action: ()->()
    
    var body: some View {
        Button(action: {
            action()
        }, label: {
            Label(label, systemImage: systemImage)
        })
        .buttonStyle(PlainButtonStyle())
    }
}
