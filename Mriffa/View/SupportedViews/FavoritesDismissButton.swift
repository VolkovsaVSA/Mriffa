//
//  DismissButton.swift
//  Mriffa
//
//  Created by Sergei Volkov on 10.09.2021.
//

import SwiftUI

struct FavoritesDismissButton: View {
    
    let action: ()->()
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                NavDismissButton {
                    action()
                }
                .frame(width: 30, height: 30)
                .padding(.top, 6)
                .padding(.trailing, 6)
            }
            Spacer()
        }
    }
}
