//
//  ChapterView.swift
//  Mriffa
//
//  Created by Sergei Volkov on 25.08.2021.
//

import SwiftUI

struct CategoryView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var affirmationVM: AffirmationViewModel
    @EnvironmentObject var categoryVM: CategoryViewModel
    @EnvironmentObject var settingsVM: SettingsViewModel
    @EnvironmentObject var themeVM: ThemeViewModel
    
    private let columnWidth: CGFloat!
    private let columns: [GridItem]!
    @State private var incomeCategories = Set<CategoryModel>()

    init(columnWidth: CGFloat) {
        self.columnWidth = columnWidth
        self.columns = [GridItem(.adaptive(minimum: columnWidth))]
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
        
        NavigationView {
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
            }
            .id(categoryVM.updatedID)
            .navigationTitle(NSLocalizedString("Categories", comment: "nav title"))
            .navigationBarItems(
                trailing:
                    NavDismissButton() {
                        presentationMode.wrappedValue.dismiss()
                    }
            )
            .background(
                BluredBackgroundView()
            )
        }

        .colorScheme(.dark)
        .onAppear() {
            incomeCategories = categoryVM.selectedCategories
        }
        .onDisappear() {
            if incomeCategories != categoryVM.selectedCategories {
                AffirmationViewModel.shared.updateAffirmation()
                AdsViewModel.shared.showInterstitial = true
            }
            
        }
        
    }
}


