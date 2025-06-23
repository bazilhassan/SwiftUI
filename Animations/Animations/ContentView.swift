//
//  ContentView.swift
//  Animations
//
//  Created by Bazil Macbook on 18/06/2025.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ExplicitAnimation()
    }
}

#Preview {
    ContentView()
}

//Animating binding
// Animation bind with the stepper which, Animation on stepper + , -

struct ExplicitAnimation: View {
    
    @State private var animationAmount = 1.0
    @State private var coinTitles = ["Head" , "Tail"]
    var randomInt = Int.random(in: 0...1)
    
    var body: some View {
        
        AnimationBinding()
        
        ImplicitAnimation()
        
        Button {
            withAnimation(.spring(duration: 1, bounce: 0.5)) { // without this, this will not animate
                animationAmount += 360
            }
            
        } label: {
            Text("Head")
        }
        .padding(40)
        .background(.red)
        .foregroundStyle(.white)
        .clipShape(.circle)
        .rotation3DEffect(.degrees(animationAmount), axis: (x: 1, y: 0, z: 0))
        
        
        //        Button("Tap me") {
        //            withAnimation(.spring(duration: 1, bounce: 0.5)) { // without this, this will not animate
        //                animationAmount += 360
        //            }
        //
        //
        //
        //        }
        //        .padding(40)
        //        .background(.red)
        //        .foregroundStyle(.white)
        //        .clipShape(.circle)
        //        .rotation3DEffect(.degrees(animationAmount), axis: (x: 1, y: 1, z: 1))
        
        
    }
}


struct AnimationBinding : View {
    @State private var animationAmount = 1.0
        //Animating binding
    // Animation bind with the stepper which, Animation on stepper + , -
    var body: some View {
        Stepper("Scale Amount", value: $animationAmount
            .animation(
                .easeInOut(duration: 1)
                .repeatCount(3, autoreverses: false)
            ),
                in: 1...10)
        Spacer()
        
        Button("Tap me") {
            animationAmount += 1
        }
        .padding(50)
        .foregroundStyle(.white)
        .background(.red)
        .clipShape(.circle)
        .scaleEffect(animationAmount)
        
    }
}

//Implicit Animation
struct ImplicitAnimation: View {
    @State private var animationAmount = 1.0

    var body: some View {
        //**Implicit Animation**
        Button ("Tap me") {
            // animationAmount += 1
        }
        .padding(50)
        .background(.red)
        .foregroundStyle(.white)
        .clipShape(.circle)
        //        .scaleEffect(animationAmount)
        //        .blur(radius: (animationAmount - 1) * 3)
        .overlay(
            Circle()
                .stroke(.red)
                .scaleEffect(animationAmount)
                .opacity(2 - animationAmount)
                .animation(
                    .easeInOut(duration: 1)
                    .repeatForever(autoreverses: false)
                    /*.delay(1)*/,
                    value: animationAmount
                )
        ).onAppear {
            animationAmount = 2
            
        }
        //        .animation(.spring(duration: 1, bounce: 0.9), value: animationAmount)
        //        .animation(
        //            .easeInOut(duration: 2)
        //            .repeatForever(autoreverses: true)
        //            /*.delay(1)*/,
        //            value: animationAmount)
    }
}
