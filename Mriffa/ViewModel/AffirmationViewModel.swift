//
//  AffirmationViewModel.swift
//  Mriffa
//
//  Created by Sergei Volkov on 15.08.2021.
//

import SwiftUI

class AffirmationViewModel: ObservableObject {
    
    static let shared = AffirmationViewModel()
    
    init() {
        if UserDefaults.standard.bool(forKey: UDKeys.noFirstRun) {
            affirmation = DataManager.Affirmation.loadAffirmations()
        } else {
            affirmation = AffirmationDefaultData
        }
    }

    @Published var selectedAffirmation: AffirmationModel?
    @Published var affirmation: [AffirmationModel]
    @Published var showHeart = false {
        didSet {
            if showHeart {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                    withAnimation(.easeOut) {
                        self.showHeart = false
                    }
                }
            }
        }
    }
    @Published var index = 0
    @Published var updatedID = UUID()
    @Published var filteredAffirmation: [AffirmationModel] = [] {
        didSet{
            print(AffirmationViewModel.shared.filteredAffirmation.count)
        }
    }

    func checkFavorite(index: Int)->String {
        return affirmation[index].isFavorite ? "heart" : "heart.fill"
    }
    func dragGestureFunction(_ value: _ChangedGesture<DragGesture>.Value, scrollProxy: ScrollViewProxy) {
        let horizontalAmount = value.translation.width as CGFloat
        let verticalAmount = value.translation.height as CGFloat
        
        if abs(horizontalAmount) < abs(verticalAmount) {
            if verticalAmount < 0 {
                guard (index + 1) < affirmation.count else {return}
                index += 1
            } else {
                guard (index - 1) >= 0 else {return}
                index -= 1
            }
        }
        withAnimation {
            scrollProxy.scrollTo(index, anchor: .center)
        }
    }
}
