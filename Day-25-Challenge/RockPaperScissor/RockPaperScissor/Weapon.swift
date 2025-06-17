//
//  Weapon.swift
//  RockPaperScissor
//
//  Created by Bazil Macbook on 17/06/2025.
//

import SwiftUI

struct Weapon: View {
    
    var onTapped: (Action) -> Void
    
    var body: some View {
        
        ForEach(Action.allCases, id: \.self) {action in
            
            Button () {
                onTapped(action)
            } label: {
                Image(action.rawValue)
                    .resizable()
                    .frame(width: 100,height: 100)
            }
        }
    }
}

//#Preview {
//    Weapon(onTapped: ((Action) -> Void))
//}
