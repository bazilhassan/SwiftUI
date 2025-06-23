//
//  SettingView.swift
//  edutainment
//
//  Created by Bazil Macbook on 23/06/2025.
//

import SwiftUI

struct SettingView: View {
    @Binding var tableNumber: Int
    @Binding var numberOfQuestions:Int
    var startGameCompletion: (()-> Void)?
    
    
    
    var body: some View {
        VStack {
            Text("Multiplication Fun")
                .foregroundStyle(.black)
                .font(.largeTitle.bold())
                .multilineTextAlignment(.center)
            Text("Which multiplication table do yo want to practice ")
                .foregroundStyle(.black)
                .font(.headline.bold())
            
            Stepper("Up to..\(tableNumber)",
                    value: $tableNumber,
                    in: 2...20,
                    step: 1)
            .foregroundStyle(.black)
            .font(.title3.bold())
            .padding()
            
            Text("How many questions do you want?")
                .foregroundStyle(.black)
                .font(.headline.bold())
            Stepper("Up to..\(numberOfQuestions)", value: $numberOfQuestions, in: 5...20, step: 5)
                .foregroundStyle(.black)
                .font(.title3.bold())
                .padding()
            
            Button("Let's Play") {
                print("Game Started")
                startGameCompletion?()
//                self.generateTableQuestions()
//                isGameActive = true
            }
            .frame(width: 150, height: 50)
            .font(.title3.bold())
            .background(.teal)
            .foregroundStyle(.white)
            .cornerRadius(10)
            .padding(.bottom)
        }
        .background(.ultraThinMaterial)
        .cornerRadius(20)
        .padding()

    }
}

//#Preview {
//    SettingView()
//}
