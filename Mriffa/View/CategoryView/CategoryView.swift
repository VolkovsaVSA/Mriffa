//
//  ChapterView.swift
//  Mriffa
//
//  Created by Sergei Volkov on 25.08.2021.
//

import SwiftUI

struct CategoryView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var affrimationVM: AffirmationViewModel
    @EnvironmentObject var categoryVM: CategoryViewModel
    @EnvironmentObject var settingsVM: SettingsViewModel
    
    private let columnWidth: CGFloat!
    private let columns: [GridItem]!

    init(columnWidth: CGFloat) {
        self.columnWidth = columnWidth
        self.columns = [GridItem(.adaptive(minimum: columnWidth))]
    }
    
    private func udateData() {
        affrimationVM.affirmation = testData.filter {
            CategoryViewModel
                .shared
                .selectedCategories.contains(CategoryModel(category: $0.category,
                                                           title: $0.category.localizedTitle,
                                                           image: $0.category.rawValue))
        }
//        .shuffled()
        
        DataManager.Category.saveSelectedCategory(categories: categoryVM.selectedCategories)
    }
    
    var body: some View {
        
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 14) {
                    ForEach(0..<categoryVM.categories.count) { index in
                        
                        Button(action: {
                            
                            if categoryVM.selectedCategories.contains(categoryVM.categories[index]) {
//                                if categoryVM.selectedCategories.count != 1 {
//                                    categoryVM.selectedCategories.remove(categoryVM.categories[index])
////                                    udateData()
//                                }
                                categoryVM.selectedCategories.remove(categoryVM.categories[index])
                            } else {
                                categoryVM.selectedCategories.update(with: categoryVM.categories[index])
//                                udateData()
                            }
                            udateData()
                        }, label: {
                            CategoryButtonLabel(item: $categoryVM.categories[index], columnWidth: columnWidth)
                        })
                        
                    }
                }
                .padding()
            }
            .navigationTitle("Categories")
            .navigationBarItems(
                leading:
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Text("Cancel")
                    })
//                    .buttonStyle(PlainButtonStyle())
//                ,
//                trailing:
//                    Button(action: {
//
//                    }, label: {
//                        Text("Unlock all")
//                    })
            )
        }
        
    }
}


