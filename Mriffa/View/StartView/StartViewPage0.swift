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
                withAnimation(.easeIn(duration: 1)) {
                    if text1Animation {
                        text2Animation = true
                    }
                }
            }
        }
    }
    @State private var text2Animation = false {
        didSet {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                withAnimation(.easeIn(duration: 1)) {
                    if text2Animation {
                        text3Animation = true
                    }
                }
            }
        }
    }
    @State private var text3Animation = false {
        didSet {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                withAnimation(.easeIn(duration: 1)) {
                    if text3Animation {
                        buttonAnimation = true
                    }
                }
            }
        }
    }
    @State private var buttonAnimation = false
    @State private var duration: Double = 2

    let action: ()->()
    
    var body: some View {
        VStack {
            Image("screen0")
                .resizable()
                .scaledToFit()
                .ignoresSafeArea()
            VStack(spacing: 10) {
                Text("Self love")
                    .opacity(text1Animation ? 1 : 0)
                Text("Antistress")
                    .opacity(text2Animation ? 1 : 0)
                Text("Self improvement")
                    .opacity(text3Animation ? 1 : 0)
            }
            .font(.title)
            .foregroundColor(.white)
            
            Spacer()
            
            Button(action: {
                action()
            }, label: {
                Text("Next")
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
        }
        .background(
            Color.black
                .ignoresSafeArea()
        )
        
        .onAppear() {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                withAnimation(.easeIn(duration: 1)) {
                    text1Animation = true
                }
                
            }

        }
    }
}
