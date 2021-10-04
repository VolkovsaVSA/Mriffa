//
//  StartViewPage2.swift
//  Mriffa
//
//  Created by Sergei Volkov on 04.10.2021.
//

import SwiftUI

struct StartViewPage2: View {
    
    @AppStorage(UDKeys.startView) var noStartView: Bool = false
    @EnvironmentObject var settingsVM: SettingsViewModel
    @EnvironmentObject var categoryVM: CategoryViewModel
    @EnvironmentObject var affirmationVM: AffirmationViewModel
    
    @Binding var tabSelection: Int
    
    let columnWidth: CGFloat!
    let columns: [GridItem]!
    
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
        DataManager.Category.saveSelectedCategory(categories: categoryVM.selectedCategories)
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
    //            .id(categoryVM.updatedID)
                
                Spacer()
                
                Button(action: {
                    withAnimation {
                        noStartView = true
                    }
                }, label: {
                    Text("Get started")
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .frame(width: UIScreen.main.bounds.width/1.3, height: 40)
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

//struct StartViewPage2_Previews: PreviewProvider {
//    static var previews: some View {
//        StartViewPage2()
//    }
//}
