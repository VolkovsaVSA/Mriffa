//
//  StartViewPage0.swift
//  Mriffa
//
//  Created by Sergei Volkov on 04.10.2021.
//

import SwiftUI

struct StartViewPage0: View {
    
    @State private var text1Animation = false {
        didSet {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                text2Animation.toggle()
            }
        }
    }
    @State private var text2Animation = false {
        didSet {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                text3Animation.toggle()
            }
        }
    }
    @State private var text3Animation = false {
        didSet {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                buttonAnimation.toggle()
            }
        }
    }
    @State private var buttonAnimation = false
    @State private var duration: Double = 2
    
    @Binding var tabSelection: Int
    
    var body: some View {
        VStack {
            Image("screen0")
                .resizable()
                .scaledToFit()
                .ignoresSafeArea()
            VStack(spacing: 10) {
                Text("Self love")
                    .opacity(text1Animation ? 1 : 0)
                    .animation(.easeIn(duration: duration))
                Text("Antistress")
                    .opacity(text2Animation ? 1 : 0)
                    .animation(.easeIn(duration: duration))
                Text("Self improvement")
                    .opacity(text3Animation ? 1 : 0)
                    .animation(.easeIn(duration: duration))
            }
            .font(.title)
            .foregroundColor(.white)
            
            Spacer()
            
            Button(action: {
                withAnimation {
                    tabSelection = 1
                }
            }, label: {
                Text("Next")
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .frame(width: UIScreen.main.bounds.width/1.3, height: 40)
                            .foregroundColor(.white)
                    )
            })
                .foregroundColor(.black)
                .padding(.bottom, 20)
                .disabled(!buttonAnimation)
                .opacity(buttonAnimation ? 1 : 0)
                .animation(.easeIn(duration: 2))
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