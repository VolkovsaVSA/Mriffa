//
//  PurchasesSectionView.swift
//
//  Created by Sergei Volkov on 14.12.2021.
//

import SwiftUI
import StoreKit

struct PurchasesSection: View {
    
    @EnvironmentObject private var storeManager: StoreManager
    @State private var showPurchaseWarning = false
    
    @AppStorage(UDKeys.fv) var isFullVersion: Bool = false
    
    var body: some View {
        Section(header: Text("Purchases").fontWeight(.semibold).foregroundColor(.primary)) {
            if isFullVersion {
                HStack {
                    Spacer()
                    Text("You use a full version")
                    Spacer()
                }
            } else {
                SettingsButton(label: "Purchase Full version", systemImage: "crown.fill") {
                    showPurchaseWarning = true
                }
            }
        }
        
        .alert("Purchasing the full version for \(storeManager.priceFullVersion)",
               isPresented: $showPurchaseWarning) {
            
            if let product = storeManager.products?.first {
                Button("Purchase", role: .destructive) {
                    Task.init {
                        try await storeManager.purchase(product)
                    }
                }
            }
            
        } message: {
            Text("When you purchase the full version of the application, all the application functions will be available to you, and the ads will not be displayed.")
                .autocapitalization(.none)
        }

    }
    
}

