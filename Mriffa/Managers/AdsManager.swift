//
//  AdsManager.swift
//  Tehcon (iOS)
//
//  Created by Sergei Volkov on 16.03.2021.
//


import SwiftUI
import GoogleMobileAds
import AppTrackingTransparency
import AdSupport

final class AdsManager: NSObject, ObservableObject {
    
    private struct AdMobConstant {
        static let applicationID = "ca-app-pub-8399858472733455~2749002676"
        static let banner1ID = "ca-app-pub-8399858472733455/2016173801"
        static let interstitial1ID = "ca-app-pub-8399858472733455/2889244100"
    }
    
    final class BannerVC: UIViewControllerRepresentable  {
        
        init(size: CGSize) {
            self.size = size
        }
        var size: CGSize

        func makeUIViewController(context: Context) -> UIViewController {
            let view = GADBannerView(adSize: GADAdSizeFromCGSize(size))
            let viewController = UIViewController()
            view.adUnitID = AdMobConstant.banner1ID
            view.rootViewController = viewController
            viewController.view.addSubview(view)
            viewController.view.frame = CGRect(origin: .zero, size: size)
            
            let gadRequest = GADRequest()
            DispatchQueue.main.async {
                gadRequest.scene = UIApplication.shared.connectedScenes.first as? UIWindowScene
            }
            view.load(gadRequest)
            
//            ATTrackingManager.requestTrackingAuthorization(completionHandler: { status in
//                let gadRequest = GADRequest()
//                DispatchQueue.main.async {
//                    gadRequest.scene = UIApplication.shared.connectedScenes.first as? UIWindowScene
//                }
//                view.load(gadRequest)
//            })
            return viewController
        }
        func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
    }

    final class Interstitial: NSObject, GADFullScreenContentDelegate, ObservableObject {

        private var interstitial: GADInterstitialAd?
        
        override init() {
            super.init()
            requestInterstitialAds()
        }

        func requestInterstitialAds() {
            let request = GADRequest()
            request.scene = UIApplication.shared.connectedScenes.first as? UIWindowScene
//            ATTrackingManager.requestTrackingAuthorization(completionHandler: { status in
//                GADInterstitialAd.load(withAdUnitID: AdMobConstant.interstitial1ID, request: request, completionHandler: { [self] ad, error in
//                    if let error = error {
//                        print("Failed to load interstitial ad with error: \(error.localizedDescription)")
//                        return
//                    }
//                    interstitial = ad
//                    interstitial?.fullScreenContentDelegate = self
//                })
//            })
            GADInterstitialAd.load(withAdUnitID: AdMobConstant.interstitial1ID, request: request, completionHandler: { [self] ad, error in
                if let error = error {
                    print("Failed to load interstitial ad with error: \(error.localizedDescription)")
                    return
                }
                interstitial = ad
                interstitial?.fullScreenContentDelegate = self
            })
        }
        func showAd() {
            let root = UIApplication.shared.windows.last?.rootViewController
            if let fullScreenAds = interstitial {
                if !UserDefaults.standard.bool(forKey: UDKeys.fv) {
                    fullScreenAds.present(fromRootViewController: root!)
                }
            } else {
                print("not ready")
            }
        }
        func interstitialDidDismissScreen(_ ad: GADFullScreenPresentingAd) {
            print(#function)
            requestInterstitialAds()
        }
        func interstitialDidReceiveAd(_ ad: GADFullScreenPresentingAd) {
            print(#function)
        }
    }
    
    
}
