//
//  ContentView.swift
//  edutainment
//
//  Created by Bazil Macbook on 21/06/2025.
//

/**
 
 Your goal is to build an “edutainment” app for kids to help them practice multiplication tables – “what is 7 x 8?” and so on. Edutainment apps are educational at their core, but ideally have enough playfulness about them to make kids want to play.
 
 Breaking it down:
 
 The player needs to select which multiplication tables they want to practice. This could be pressing buttons, or it could be an “Up to…” stepper, going from 2 to 12.
 The player should be able to select how many questions they want to be asked: 5, 10, or 20.
 You should randomly generate as many questions as they asked for, within the difficulty range they asked for.
 
 
 */

import SwiftUI

struct ContentView: View {
    
    @State private var isGameActive: Bool = false
    @State private var tableNumber: Int = 2
    @State private var numberOfQuestions: Int = 5
    @State private var questions: [Questions] = []
    @State private var questionIndex = 0
    @State private var answerTextField = ""
    @State private var score = 0
    @State private var showAlertOnGameEnd = false
    
    
    var body: some View {
        
        NavigationView {
            
            ZStack {
                if isGameActive {
                    LinearGradient(colors: [.teal,.purple], startPoint: .top, endPoint: .bottom)
                    VStack {
                        Text("Question # \(questionIndex + 1)")
                            .font(.largeTitle.bold())
                            .padding()
                        
                        VStack {
                            if questions.count > 0 {
                                
                                Text(questions[questionIndex].text)
                                    .padding()
                                    .font(.title.bold())
                                
                                TextField("Enter your Answer", text: $answerTextField)
                                    .padding()
                                    .frame(width: 200 , height: 50)
                                    .background(.white)
                                    .cornerRadius(12)
                                    .keyboardType(.numberPad)
                                
//                                Spacer()
                                
                                Button("Submit", action: handleAnswer)
                                .padding()
                                .font(.system(.title2).bold())
                                .foregroundStyle(.white)
                                .frame(width: 120 , height: 50)
                                .background(.green)
                                .cornerRadius(15)
                                .padding()
                            }
                        }
                        .frame(maxWidth: .infinity, maxHeight: 250)
                        .background(.ultraThinMaterial)
                        .cornerRadius(20)
                        .padding()

                       
                        .alert("Score", isPresented: $showAlertOnGameEnd) {
                            Button("Restart", action: resetGame)
                        } message: {
                            Text("Your Score is \(score)")
                        }

                    }
                    .transition(.scale)
                }
                else {
                    LinearGradient(colors: [.teal, .orange], startPoint: .top, endPoint: .bottom)
                    SettingView(tableNumber: $tableNumber, numberOfQuestions: $numberOfQuestions) {
                        generateTableQuestions()
                        isGameActive = true
                    }
                    .transition(.opacity)
                    .padding()
                }
            }
            .ignoresSafeArea()
            .onAppear {
                self.generateTableQuestions()
            }
        }
    }
    
    
    
    func generateTableQuestions() {
        questions.removeAll()
        
        for number in 0..<numberOfQuestions {
            print(number)
            let randomNumber = Int.random(in: 2...10)
            let questionText = "What is \(tableNumber) x \(randomNumber) = ?"
            let answer = tableNumber * randomNumber
            
            let question = Questions(text: questionText, answer: answer)
            questions.append(question)
            
            print("Question Text \(questionText)")
            print("Answer \(answer)")
            print("Question \(question.text),  Answer \(answer)?")
        }
        print(questions)
    }
    
    func handleAnswer() {
        if !answerTextField.isEmpty {
            
            if Int(answerTextField)! == questions[questionIndex].answer {
                score += 1
            }
            
            answerTextField = ""
            
            if questionIndex < questions.count - 1 {
                questionIndex += 1
            } else {
                showAlertOnGameEnd = true
            }
        }
    }
    
    func resetGame() {
        print("Restart the Game")
        questionIndex = 0
        isGameActive = false
        questions.removeAll()
        answerTextField = ""
        score = 0
    }
}

#Preview {
    ContentView()
}

struct Questions {
    var text: String
    var answer: Int
}
