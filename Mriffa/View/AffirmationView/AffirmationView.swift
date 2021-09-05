//
//  AffirView.swift
//  Mriffa
//
//  Created by Sergei Volkov on 14.08.2021.
//

import SwiftUI

//struct AffirmationView1: View {
//    @EnvironmentObject var affrimationVM: AffirmationViewModel
//    @EnvironmentObject var settingsVM: SettingsViewModel
//    @EnvironmentObject var categoryVM: CategoryViewModel
//    
//    var body: some View {
//        
//        TabView {
//            ForEach(affrimationVM.filteredAffirmation()) { affirmation in
//
//                VStack {
//                    Spacer()
//                    Text(affirmation.text)
//                        .font(.system(size: settingsVM.affirmationFontSize, weight: .bold, design: .default))
//                        .multilineTextAlignment(.center)
//                        .padding()
//                    Spacer()
//                    AffirmationButtons1(affirmation: affirmation)
//                }
//                .frame(width: getRect().width)
//
//            }
//        }
//        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
//        
//       
//    }
//}

struct AffirmationView: View {
    
    @EnvironmentObject var affirmationVM: AffirmationViewModel
    @EnvironmentObject var settingsVM: SettingsViewModel
    @EnvironmentObject var categoryVM: CategoryViewModel
    
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
                        ForEach(0..<affirmationVM.filteredAffirmation.count) { localIndex in

                            ZStack {
                                ShowHeart(showHeart: $affirmationVM.showHeart)

                                VStack {
                                    if localIndex < affirmationVM.filteredAffirmation.count {
                                        Spacer()
                                        Text(affirmationVM.filteredAffirmation[localIndex].text)
                                            .font(.system(size: settingsVM.affirmationFontSize, weight: .bold, design: .default))
                                            .multilineTextAlignment(.center)
                                            .padding()
                                        Spacer()
                                        AffirmationButtons(affirmation: affirmationVM.filteredAffirmation[localIndex])
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
                                affirmationVM.dragGestureFunction(value, scrollProxy: scrollProxy)
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
