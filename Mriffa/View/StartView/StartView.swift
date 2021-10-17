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
    @State private var isDisabled = true
    
    var body: some View {

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
    }
}
