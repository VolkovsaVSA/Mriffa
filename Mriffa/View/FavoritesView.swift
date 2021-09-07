//
//  FavoritesView.swift
//  Mriffa
//
//  Created by Sergei Volkov on 07.09.2021.
//

import SwiftUI

struct FavoritesView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var affirmationVM: AffirmationViewModel
    
    var body: some View {
        
        ZStack {
            AffirmationScroll(affirmations: affirmationVM.favorites)
                .background(Color.red)
            VStack {
                HStack {
                    Spacer()
                    TabButton(imageSystemName: "clear.fill") {
                        presentationMode.wrappedValue.dismiss()
                    }
                    .padding(.trailing, 30)
                }
                .padding(.top, 50)
                Spacer()
            }
        }
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height, alignment: .center)
        
    }
}
