//
//  AdsManager.swift
//  Tehcon (iOS)
//
//  Created by Sergei Volkov on 16.03.2021.
//

import UIKit
import SwiftUI
import GoogleMobileAds
import AppTrackingTransparency
import AdSupport

class AdsManager: NSObject, ObservableObject {
    
    private struct AdMobConstant {
        static let applicationID = "ca-app-pub-8399858472733455~2749002676"
        static let banner1ID = "ca-app-pub-8399858472733455/2016173801"
        static let interstitial1ID = "ca-app-pub-8399858472733455/2889244100"
    }
    
//    struct BannerSize {
//        static let kGADAdSizeLeaderboard_: GADAdSize = kGADAdSizeLeaderboard
//    }
    
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
            
            
            ATTrackingManager.requestTrackingAuthorization(completionHandler: { status in
                let gadRequest = GADRequest()
                DispatchQueue.main.async {
                    gadRequest.scene = UIApplication.shared.connectedScenes.first as? UIWindowScene
                }
                view.load(gadRequest)
            })
            return viewController
        }
        func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
    }
    
//    final class InterstitialVC: NSObject, UIViewControllerRepresentable, ObservableObject {
//
//        static let shared = InterstitialVC()
//
//        private var interstitial: GADInterstitialAd?
//
//        override init() {
//            super.init()
//            print(#function)
//            requestInterstitialAds()
//        }
//
//        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
//            if AdsViewModel.shared.showInterstitial {
//                showAd((UIApplication.shared.windows.first?.rootViewController)!)
//            }
//        }
//        func makeUIViewController(context: Context) -> some UIViewController {
//            let vc = UIViewController()
//            vc.view.frame = UIScreen.main.bounds
//            interstitial?.fullScreenContentDelegate = context.coordinator
//            return vc
//        }
//
//        func makeCoordinator() -> Coordinator {
//            Coordinator(self)
//        }
//
//        class Coordinator: NSObject, GADFullScreenContentDelegate{
//            var parent:InterstitialVC
//
//            init(_ parent: InterstitialVC) {
//                self.parent = parent
//            }
//
//            // Tells the delegate that the ad failed to present full screen content.
//            func ad(_ ad: GADFullScreenPresentingAd, didFailToPresentFullScreenContentWithError error: Error) {
//                print("Ad did fail to present full screen content.")
//                AdsViewModel.shared.showInterstitial = false
//                parent.requestInterstitialAds()
//            }
//
//            // Tells the delegate that the ad presented full screen content.
//            func adDidPresentFullScreenContent(_ ad: GADFullScreenPresentingAd) {
//                print("Ad did present full screen content.")
//            }
//
//            /// Tells the delegate that the ad dismissed full screen content.
//            func adDidDismissFullScreenContent(_ ad: GADFullScreenPresentingAd) {
//                print("Ad did dismiss full screen content.")
//                AdsViewModel.shared.showInterstitial = false
//                parent.requestInterstitialAds()
//            }
//        }
//
//        func requestInterstitialAds() {
//            let request = GADRequest()
//            request.scene = UIApplication.shared.connectedScenes.first as? UIWindowScene
//            ATTrackingManager.requestTrackingAuthorization(completionHandler: { status in
//                GADInterstitialAd.load(withAdUnitID: AdMobConstant.interstitial1ID, request: request, completionHandler: { [self] ad, error in
//                    if let error = error {
//                        print("Failed to load interstitial ad with error: \(error.localizedDescription)")
//                        return
//                    }
//                    interstitial = ad
//                    AdsViewModel.shared.showInterstitial = false
//                })
//            })
//        }
//        func showAd(_ controller:UIViewController) {
////            let root = UIApplication.shared.windows.first?.rootViewController
//            if let fullScreenAds = interstitial {
//                if !UserDefaults.standard.bool(forKey: UDKeys.fv) {
//                    fullScreenAds.present(fromRootViewController: controller)
//                }
//            } else {
//                print("not ready")
//                AdsViewModel.shared.showInterstitial = false
//            }
//        }
//
//    }
    
    final class Interstitial: NSObject, GADFullScreenContentDelegate, ObservableObject {

        private var interstitial: GADInterstitialAd?
        @Published var isLoaded: Bool = false

        override init() {
            super.init()
            requestInterstitialAds()
        }

        func requestInterstitialAds() {
            print(#function)
            let request = GADRequest()
            request.scene = UIApplication.shared.connectedScenes.first as? UIWindowScene
            ATTrackingManager.requestTrackingAuthorization(completionHandler: { status in
                GADInterstitialAd.load(withAdUnitID: AdMobConstant.interstitial1ID, request: request, completionHandler: { [self] ad, error in
                    if let error = error {
                        print("Failed to load interstitial ad with error: \(error.localizedDescription)")
                        return
                    }
                    interstitial = ad
                    interstitial?.fullScreenContentDelegate = self
                })
            })
        }
        func showAd() {
            let root = UIApplication.shared.windows.first?.rootViewController
            if let fullScreenAds = interstitial {
                if !UserDefaults.standard.bool(forKey: UDKeys.fv) {
                    fullScreenAds.present(fromRootViewController: root!)
                    isLoaded = false
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
            isLoaded = true
        }
    }
    
    
}
