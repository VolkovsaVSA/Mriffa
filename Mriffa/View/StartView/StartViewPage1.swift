//
//  StartViewPage1.swift
//  Mriffa
//
//  Created by Sergei Volkov on 04.10.2021.
//

import SwiftUI

struct StartViewPage1: View {
    
    @State private var text1Animation = false {
        didSet {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                if text1Animation {
                    text2Animation = true
                }
            }
        }
    }
    @State private var text2Animation = false {
        didSet {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                if text2Animation {
                    text3Animation = true
                }
            }
        }
    }
    @State private var text3Animation = false {
        didSet {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                if text3Animation {
                    text4Animation = true
                }
            }
        }
    }
    @State private var text4Animation = false {
        didSet {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                if text4Animation {
                    buttonAnimation = true
                }
                
            }
        }
    }
    @State private var buttonAnimation = false
    @State private var duration: Double = 2

    let action: ()->()
    
    var body: some View {
        VStack {
            Image("screen1")
                .resizable()
                .scaledToFit()
                .ignoresSafeArea()
            
            VStack(spacing: 30) {
                Text("Mriffa")
                    .font(.system(size: 30,
                                  weight: .bold,
                                  design: .default))
                    .opacity(text1Animation ? 1 : 0)
                    .animation(.easeIn(duration: duration))
                
                Text("is your self-confidence assistant")
                    .opacity(text2Animation ? 1 : 0)
                    .animation(.easeIn(duration: duration))
                
                Text("is more than 1000 affirmations from 14 categories")
                    .opacity(text3Animation ? 1 : 0)
                    .animation(.easeIn(duration: duration))
                
                Text("Read and repeat affirmations several times a day to help you build a positive mindset")
                    .opacity(text4Animation ? 1 : 0)
                    .animation(.easeIn(duration: duration))
                   
            }
            .multilineTextAlignment(.center)
            .padding(.horizontal)
            .foregroundColor(.white)
            
            Spacer()
            
            Button(action: {
                action()
            }, label: {
                Text("Select Categories")
                    .frame(width: UIScreen.main.bounds.width/1.3, height: 40)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(.white)
                    )
                
                
            })
                .foregroundColor(.black)
                .padding(.bottom, 20)
                .disabled(!buttonAnimation)
                .opacity(buttonAnimation ? 1 : 0)
                .animation(.easeIn(duration: 1))
        
        }
        .background(
            Color.black
                .ignoresSafeArea()
        )
        
        .onAppear() {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                text1Animation = true
            }
            
        }
    }
}
