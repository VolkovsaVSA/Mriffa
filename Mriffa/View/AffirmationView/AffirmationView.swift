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
    @EnvironmentObject var categoryVM: CategoryViewModel
    @State private var index = 0

    private func dragGestureFunction(_ value: _ChangedGesture<DragGesture>.Value, scrollProxy: ScrollViewProxy) {
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
    
    var body: some View {
        
        ZStack {

            if categoryVM.selectedCategories.isEmpty {
                Text("No selected category")
                    .foregroundColor(.white)
                    .font(.system(size: settingsVM.affirmationFontSize, weight: .bold, design: .default))
                    .multilineTextAlignment(.center)
                    .padding()
            } else {
                ScrollViewReader { scrollProxy in
                    ScrollView(.vertical, showsIndicators: false) {
                        ForEach(0..<affrimationVM.affirmation.count) { localIndex in
                            
                            ZStack {
                                ShowHeart(showHeart: $affrimationVM.showHeart)
                                
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
                            }.foregroundColor(.white)
                            
                        }
                        .padding(.horizontal)
                    }
                    .gesture(
                        DragGesture(minimumDistance: 0, coordinateSpace: .local)
                            .onChanged { value in
//                                print(value.location)
//                                dragGestureFunction(value, scrollProxy: scrollProxy)
                            }
                            .onEnded { value in
                                dragGestureFunction(value, scrollProxy: scrollProxy)
                            }
                    )
                    
                }
            }
            
            
            VStack {
                Spacer()
                AffirmationTabView()
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
