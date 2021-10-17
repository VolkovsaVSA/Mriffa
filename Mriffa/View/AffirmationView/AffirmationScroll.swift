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
    @Binding var index: Int
    let isMainAffrmationScroll: Bool
    
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
            ScrollView(.vertical, showsIndicators: true) {
                ForEach(0..<affirmations.count) { localIndex in

                    ZStack {
                        ShowHeart(showHeart: $affirmationVM.showHeart)
                        VStack {
                            if localIndex < affirmations.count {
                                Spacer()
                                Text(affirmations[localIndex].text)
                                    .font(.custom(themeVM.selectedTheme.font, size: themeVM.selectedTheme.fontSize).bold())
                                    .minimumScaleFactor(0.005)
                                    .multilineTextAlignment(.center)
                                    .padding()
                                Spacer()
                                AffirmationButtons(affirmation: affirmations[localIndex]) {
                                    if !isMainAffrmationScroll {
                                        withAnimation {
                                            scrollProxy.scrollTo(index, anchor: .center)
                                        }
                                    }
                                }
                            } else {
                                EmptyView()
                            }
                        }

                    }
                    .foregroundColor(.white)
                    .id(localIndex)
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height, alignment: .center)
                }
            }
            .id(affirmationVM.updatedID)
            .gesture(
                DragGesture(minimumDistance: 0, coordinateSpace: .local)
                    .onEnded { value in
                        dragGestureFunction(value, scrollProxy: scrollProxy)
                    }
            )
            .onAppear() {
                withAnimation {
                    scrollProxy.scrollTo(index, anchor: .center)
                }
            }
//            .onOpenURL { url in
//                guard url.scheme == "widget-deeplink" else { return }
//                let message = url.host?.removingPercentEncoding
//                print(message)
//
//                print(#function, #line, url.scheme?.description)
//            }
        }
    }
}

