//
//  ContentView.swift
//  RockPaperScissor
//
//  Created by Bazil Macbook on 17/06/2025.
//

import SwiftUI

enum Action:String, CaseIterable {
    case rock
    case paper
    case scissors
}

struct ScoreStyling: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundStyle(.white)
            .font(.title)
            .fontWeight(.bold)
            .multilineTextAlignment(.center)
    }
}

extension View {
    func scoreStyle () -> some View {
        modifier(ScoreStyling())
    }
}

struct Score: View {
    var title: String
    var score: Int
    
    var body: some View {
        VStack {
            Text(title).scoreStyle()
            Text("\(score)").scoreStyle()
        }
    }
}

struct ContentView: View {
    
    @State private var showAlertOnPlayerWeaponTaped: Bool = false
    @State private var playerScore: Int = 0
    @State private var cpuScore: Int = 0
    @State private var showMessageAfterFight: String = ""
    @State private var showingFinalResult: Bool = false
    
    var body: some View {
        ZStack {
            
            Color.init(hex: "CE7DA5")
                .ignoresSafeArea()
            
            VStack {
                Text("Rock\nPaper\nScissors")
                    .foregroundStyle(.white)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                Text("Pick your weapon")
                    .foregroundStyle(.white)
                    .font(.subheadline)
                    .fontWeight(.medium)
                
                Weapon() { playerPick in
                    print("Player button tapped \(playerPick.rawValue)")
                    showAlertOnPlayerWeaponTaped = true
                    
                    self.fight(player: playerPick)
                }
                .alert("Fight", isPresented: $showAlertOnPlayerWeaponTaped) {
                    
                }
                message: {
                    Text(showMessageAfterFight)
                }
                
                HStack {
                    Score(title: "Player", score: playerScore)
                    Spacer()
                    Score(title: "CPU", score: cpuScore)
                }
                .padding()
                .padding()
            }
            .alert(isPresented: $showingFinalResult) {
                if playerScore == 5 || cpuScore == 5 {
                    return Alert(title: playerScore > cpuScore ? Text("Success!") : Text("Defeat!"), message: Text("\(showMessageAfterFight)\n\nPlayer: \(playerScore), CPU: \(cpuScore)"), dismissButton: Alert.Button.default(Text("Restart"), action: {self.playerScore = 0;self.cpuScore=0}))
                } else {
                    return Alert(title: Text("Fight!"), message: Text(showMessageAfterFight))
                }
            }
        }
    }
//    func fight(playerPick: Action, cpuPick: Action) {
//        if playerPick == .rock
//    }
    
    func fight(player: Action) {
        
        guard let cpu = Action.allCases.randomElement() else {
            showMessageAfterFight = "Error: CPU failed to choose an action."
            return
        }
        
        let cpuChoice = cpu.rawValue
        print("Cpu Value", cpuChoice)
        switch (player, cpu) {
            
        case _ where player == cpu:
            showMessageAfterFight = "Your opponent also chose \(cpuChoice). It's a draw!"
        case (.rock, .scissors), (.paper, .rock), (.scissors, .paper):
            showMessageAfterFight = "Your opponent chose \(cpuChoice). You win this round!"
            playerScore += 1
        default:
            showMessageAfterFight = "Unfortunately, your opponent chose \(cpuChoice). You lose this round!"
            cpuScore += 1
        }
        
        if playerScore == 5 || cpuScore == 5{
            showingFinalResult = true
            showAlertOnPlayerWeaponTaped = false
        }
    }
}

#Preview {
    ContentView()
}





