//
//  CategoryButtonLabel.swift
//  Mriffa
//
//  Created by Sergei Volkov on 30.08.2021.
//

import SwiftUI

struct CategoryButtonLabel: View {
    
    @EnvironmentObject var categoryVM: CategoryViewModel
    @EnvironmentObject var settingsVM: SettingsViewModel
    
    @Binding var item: CategoryModel
    let columnWidth: CGFloat!
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Image(systemName: categoryVM.selectedCategories.contains(item) ? "checkmark.circle.fill" : "circle")
                .font(.system(size: settingsVM.affirmationFontSize / 1.8,
                              weight: .medium,
                              design: .default))
                .foregroundColor(.white)
            Spacer()
            HStack {
                Text(item.title)
                    .foregroundColor(.white)
                    .font(.system(size: settingsVM.affirmationFontSize / 2.5,
                                  weight: .bold,
                                  design: .default))
                    .multilineTextAlignment(.leading)
                    .padding(3)
                    .background(
                        Blur(style: .systemUltraThinMaterialDark)
                    )
                    .cornerRadius(6)
                Spacer()
            }
        }
        .padding(8)
        .frame(width: columnWidth, height: columnWidth/1.5, alignment: .center)
        .background(
            Image(item.image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: columnWidth, height: columnWidth/1.5, alignment: .center)
                .cornerRadius(12)
                .shadow(color: .black, radius: 10, x: 4, y: 4)
        )
    }
}

