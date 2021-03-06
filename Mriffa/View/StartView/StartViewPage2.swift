//
//  StartViewPage2.swift
//  Mriffa
//
//  Created by Sergei Volkov on 04.10.2021.
//

import SwiftUI
import WidgetKit

struct StartViewPage2: View {
    
    @AppStorage(UDKeys.startView) var noStartView: Bool = false
    @EnvironmentObject var settingsVM: SettingsViewModel
    @EnvironmentObject var categoryVM: CategoryViewModel
    @EnvironmentObject var affirmationVM: AffirmationViewModel
//    
//    @Binding var tabSelection: Int
    
    
    let columnWidth: CGFloat!
    let columns: [GridItem]!
    
    private func getStarted() {
        AffirmationViewModel.shared.updateAffirmation()
        DataManager.Affirmation.saveAffirmations(affirmations: affirmationVM.affirmation)
        DataManager.Categories.saveSelectedCategory(categories: categoryVM.selectedCategories)
        DataManager.Theme.saveSelectedTheme(theme: ThemeViewModel.shared.selectedTheme)
        WidgetCenter.shared.reloadAllTimelines()
        withAnimation {
            noStartView = true
        }
    }
    
    private func updateCategories(index: Int) {
        if categoryVM.selectedCategories.contains(categoryVM.categories[index]) {
            if categoryVM.selectedCategories.count != 1 {
                categoryVM.selectedCategories.remove(categoryVM.categories[index])
            }
        } else {
            categoryVM.selectedCategories.update(with: categoryVM.categories[index])
        }
        withAnimation {
            affirmationVM.mainIndex = 0
        }
        DataManager.Categories.saveSelectedCategory(categories: categoryVM.selectedCategories)
    }
    
    
    var body: some View {
        
        ZStack {
            
            ScrollView {
                LazyVGrid(columns: columns, spacing: 14) {
                    ForEach(0..<categoryVM.categories.count) { index in
                        Button(action: {
                            updateCategories(index: index)
                        }, label: {
                            CategoryButtonLabel(item: $categoryVM.categories[index], columnWidth: columnWidth)
                        })
                    }
                }
                .padding()
                .padding([.top, .bottom], 50)
            }
            
            VStack {
                Text("Select the categories that interest you")
                    .multilineTextAlignment(.center)
                    .foregroundColor(.white)
                    .padding()
                    .background(
                        Blur(style: .systemUltraThinMaterialDark)
                    )
                    .cornerRadius(10)
                
                .edgesIgnoringSafeArea(.bottom)
                
                Spacer()
                
                Button(action: {
                    getStarted()
                }, label: {
                    Text("Get started")
                        .frame(width: UIScreen.main.bounds.width/1.3, height: 40)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundColor(.white)
                        )
                })
                    .foregroundColor(.black)
                    .padding(.bottom, 20)
                    .opacity(categoryVM.selectedCategories.isEmpty ? 0.5 : 1)
                    .disabled(categoryVM.selectedCategories.isEmpty)
            
            }
        }
        .background(
            Color.black
                .ignoresSafeArea()
        )
        
        
    }
}
