//
//  ThemeCard.swift
//  Mriffa
//
//  Created by Sergei Volkov on 12.09.2021.
//

import SwiftUI

struct ThemeCard: View {
    @EnvironmentObject var themeVM: ThemeViewModel
    
    let text: String
    let font: Font
    let columnWidth: CGFloat
    let theme: ThemeModel?
    let colors: [Color]
    let action: ()->()
    
    var body: some View {
        
        Button {
            action()
        } label: {
            
            if let themeCard = theme {
                Image(uiImage: UIImage(named: themeCard.image + "_preview")!)
                    .resizable()
                    .scaledToFill()
                    .overlay(Color.black.opacity(0.3))
                    .frame(width: columnWidth - 8, height: columnWidth - 8, alignment: .center)
                    .clipped()
                    .cornerRadius(12)
                    .shadow(color: .black, radius: 6, x: 4, y: 4)
                    .overlay(
                        Text(text)
                            .multilineTextAlignment(.center)
                            .font(.custom(themeCard.font, size: themeCard.fontSize).bold())
                            .foregroundColor(.white)
                    )
            } else {
                RadialGradient(gradient: Gradient(colors: colors), center: .center, startRadius: 20, endRadius: 80)
                    .frame(width: columnWidth - 8, height: columnWidth - 8, alignment: .center)
                    .clipped()
                    .cornerRadius(12)
                    .shadow(color: .black, radius: 6, x: 4, y: 4)
                    .overlay(
                        Text(text)
                            .multilineTextAlignment(.center)
                            .font(font)
                            .foregroundColor(.white)
                    )
            }
            
        }
        
    }
}
