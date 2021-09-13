//
//  FontsView.swift
//  Mriffa
//
//  Created by Sergei Volkov on 11.09.2021.
//

import SwiftUI

struct FontsView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var themeVM: ThemeViewModel
    
    init() {
        UITableView.appearance().backgroundColor = .clear
        UITableViewCell.appearance().backgroundColor = .clear
    }
    
    var body: some View {
        
        NavigationView {
            ScrollView {
                ForEach(Array(0...15) + Array(17..<UIFont.familyNames.count), id:\.self) { index in
                    HStack {
                        Text(UIFont.familyNames[index])
                            .padding(.horizontal, 10)
                            .padding(.vertical, 4)
                            .foregroundColor(.white)
                            .font(.custom(UIFont.familyNames[index], size: 24))
                            
                        Spacer()
                    }
                    .background(
                        RoundedRectangle(cornerRadius: 6)
                            .foregroundColor(.gray.opacity(0.5))
                    )
                    
                }.padding()
            }
            .background(
                ZStack {
                    Image(uiImage: UIImage(named: themeVM.selectedTheme.image)!)
                        .resizable()
                        .scaledToFill()
                        .overlay(Color.black.opacity(0.6))
                        .blur(radius: 4)
                }.ignoresSafeArea()
                
            )
            .navigationTitle("Fonts")
            .navigationBarItems(trailing: NavDismissButton(action: {presentationMode.wrappedValue.dismiss()})
            )
            
        }
        .colorScheme(.dark)
        
    }
}
