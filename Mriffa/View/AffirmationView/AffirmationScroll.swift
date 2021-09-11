//
//  AffirmationScroll.swift
//  Mriffa
//
//  Created by Sergei Volkov on 07.09.2021.
//

import SwiftUI

struct AffirmationScroll: View {
    @EnvironmentObject var affirmationVM: AffirmationViewModel
    @EnvironmentObject var settingsVM: SettingsViewModel
    @EnvironmentObject var themeVM: ThemeViewModel
    
    let affirmations: [AffirmationModel]
    @State private var index: Int = 0
    
    private func dragGestureFunction(_ value: _ChangedGesture<DragGesture>.Value, scrollProxy: ScrollViewProxy) {
        let horizontalAmount = value.translation.width as CGFloat
        let verticalAmount = value.translation.height as CGFloat
        
        if abs(horizontalAmount) < abs(verticalAmount) {
            if verticalAmount < 0 {
                guard (index + 1) < affirmations.count else {return}
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
        ScrollViewReader { scrollProxy in
            ScrollView(.vertical, showsIndicators: false) {
                ForEach(0..<affirmations.count) { localIndex in

                    ZStack {
                        ShowHeart(showHeart: $affirmationVM.showHeart)
                        VStack {
                            if localIndex < affirmations.count {
                                Spacer()
                                Text(affirmations[localIndex].text)
                                    .font(themeVM.selectedTheme.font)
                                    .multilineTextAlignment(.center)
                                    .padding()
                                Spacer()
                                AffirmationButtons(affirmation: affirmations[localIndex])
                            } else {
                                EmptyView()
                            }
                        }
                        .id(localIndex)
                        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height, alignment: .center)
                    }.foregroundColor(.white)

                }
                .padding(.horizontal)
            }
            .id(affirmationVM.updatedID)
            .onAppear() {
                if affirmationVM.index == 0 {
                    withAnimation {
                        scrollProxy.scrollTo(affirmationVM.index)
                    }
                }
            }
            .gesture(
                DragGesture(minimumDistance: 0, coordinateSpace: .local)
                    .onChanged { value in
//                                print(value.location)
//                                dragGestureFunction(value, scrollProxy: scrollProxy)
                    }
                    .onEnded { value in
//                        affirmationVM.dragGestureFunction(value, scrollProxy: scrollProxy)
                        dragGestureFunction(value, scrollProxy: scrollProxy)
                    }
            )
        }
    }
}

