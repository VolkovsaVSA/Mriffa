//
//  AffirView.swift
//  Mriffa
//
//  Created by Sergei Volkov on 14.08.2021.
//

import SwiftUI

struct AffirmationView: View {
    
    @EnvironmentObject var affrimationVM: AffirmationViewModel
    @EnvironmentObject var settingsVM: SettingsViewModel
    @State private var index = 0

    var body: some View {
        
        ZStack {

            ScrollViewReader { scrollProxy in
                ScrollView(.vertical, showsIndicators: false) {
                    ForEach(0..<affrimationVM.affirmation.count) { localIndex in
                        
                        ZStack {
                            
                            if affrimationVM.showHeart {
                                Image(systemName: "heart.fill")
                                    .font(.system(size: settingsVM.affirmationFontSize + 40))
                                    .shadow(color: Color(UIColor.gray).opacity(0.9), radius: 4, x: 6, y: 6)
                                    .transition(.asymmetric(insertion: .scale, removal: .opacity))
                            } else {
                                EmptyView()
                            }

                            VStack {
                                Spacer()
                                Text(affrimationVM.affirmation[localIndex].text)
                                    .font(.system(size: settingsVM.affirmationFontSize, weight: .bold, design: .default))
                                    .multilineTextAlignment(.center)
                                    .padding()
                                Spacer()
                                AffirmationButtons(localIndex: localIndex)
                            }
                            .id(localIndex)
                            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height, alignment: .center)
                            
                        }
                        
                    }
                    .padding(.horizontal)
                }
                .gesture(
                    DragGesture(minimumDistance: 0, coordinateSpace: .global)
                        .onChanged { value in
                            
                        }
                        .onEnded { value in
                            
                            let horizontalAmount = value.translation.width as CGFloat
                            let verticalAmount = value.translation.height as CGFloat
                            
                            if abs(horizontalAmount) < abs(verticalAmount) {
                                if verticalAmount < 0 {
                                    guard (index + 1) < affrimationVM.affirmation.count else {return}
                                    index += 1
                                } else {
                                    guard (index - 1) >= 0 else {return}
                                    index -= 1
                                }
                            }

                            withAnimation {
                                scrollProxy.scrollTo(index, anchor: .center)
                            }
                            
                        }
                )
                
            }
            
            VStack {
                Spacer()
                HStack(alignment: .center, spacing: settingsVM.affirmationFontSize/2) {
                    TabButton(imageSystemName: "square.grid.2x2") {
                        
                    }
                    TabButton(imageSystemName: "play") {
                        
                    }
                    Spacer()
                    TabButton(imageSystemName: "paintbrush") {
                        
                    }
                    TabButton(imageSystemName: "gear") {
                        
                    }
                }
                .padding(.horizontal, settingsVM.affirmationFontSize)
            }
            .padding(.bottom, 30)
            
           
        }
        .background(
            Image("image3")
                .resizable()
                .scaledToFill()
        )
        
        
        
        
    }
    
    
}
