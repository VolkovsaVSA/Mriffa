//
//  StartView.swift
//  Mriffa
//
//  Created by Sergei Volkov on 28.09.2021.
//

import SwiftUI

struct StartView: View {
    
    @AppStorage(UDKeys.startView) var noStartView: Bool = false
    @EnvironmentObject var settingsVM: SettingsViewModel
    
    @State private var tabSelection = 0

    var body: some View {
//
//        GeometryReader { geometryProxy in
//            ScrollViewReader { scrollProxy in
//                ScrollView(.horizontal, showsIndicators: false) {
//                    HStack {
//                        StartViewPage0() {
//                            withAnimation {
//                                scrollProxy.scrollTo(1, anchor: .center)
//                            }
//                        }
//                            .frame(width: geometryProxy.size.width, height: geometryProxy.size.height)
//                            .id(0)
//                        StartViewPage1() {
//                            withAnimation {
//                                scrollProxy.scrollTo(2, anchor: .center)
//                            }
//                        }
//                            .frame(width: geometryProxy.size.width, height: geometryProxy.size.height)
//                            .id(1)
//                        StartViewPage2(columnWidth: settingsVM.categoryBackgroundFrame,
//                                       columns: [GridItem(.adaptive(minimum: settingsVM.categoryBackgroundFrame))])
//                            .frame(width: geometryProxy.size.width, height: geometryProxy.size.height)
//                            .id(2)
//                    }
//
//
//                }
//                .gesture(
//                    DragGesture(minimumDistance: 0, coordinateSpace: .local)
//                        .onEnded { value in
//
//                        }
//                )
//            }
//        }
        
        
        TabView(selection: $tabSelection) {

            StartViewPage0() {
                withAnimation {
                    tabSelection = 1
                }
            }
                .tag(0)
            StartViewPage1() {
                withAnimation {
                    tabSelection = 2
                }
            }
                .tag(1)
            StartViewPage2(columnWidth: settingsVM.categoryBackgroundFrame,
                           columns: [GridItem(.adaptive(minimum: settingsVM.categoryBackgroundFrame))])
                .tag(2)


        }
        .tabViewStyle(.page(indexDisplayMode: .never))
//        .gesture(
//            DragGesture(minimumDistance: 0, coordinateSpace: .local)
//                .onEnded { value in
//                    
//                }
//        )
        
    }
}

//
//struct StartView_Previews: PreviewProvider {
//    static var previews: some View {
//        StartView()
//            .ignoresSafeArea()
//    }
//}
