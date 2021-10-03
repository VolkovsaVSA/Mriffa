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
        
        TabView(selection: $tabSelection) {
            
            StartViewPage0(tabSelection: $tabSelection)
                .tag(0)
            StartViewPage1(tabSelection: $tabSelection)
                .tag(1)
            StartViewPage2(tabSelection: $tabSelection,
                           columnWidth: settingsVM.categoryBackgroundFrame,
                           columns: [GridItem(.adaptive(minimum: settingsVM.categoryBackgroundFrame))])
                .tag(2)

            
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
        
    }
}

//
//struct StartView_Previews: PreviewProvider {
//    static var previews: some View {
//        StartView()
//            .ignoresSafeArea()
//    }
//}
