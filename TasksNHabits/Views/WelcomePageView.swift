//
//  WelcomePageView.swift
//  TasksNHabits
//
//  Created by Rudra Parvate on 3/27/25.
//

// For Splash Screen purposes

import SwiftUI

struct WelcomePageView: View {
    @State var alreadyViewed: Bool = false
    
    var body: some View {
        VStack {
            
            ZStack {
                RoundedRectangle(cornerRadius: 30)
                    .frame(width: 125, height: 125)
                    .foregroundStyle(.purple)
                
                Image(systemName: "checklist.checked")
                    .font(.system(size: 75))
                    .foregroundStyle(.white)
            }
            
            Text("Welcome to Task and Habits Manager!")
                .padding(.top)
                .font(.title)
                .multilineTextAlignment(.center)
        }
        .padding(.bottom, 70)
        
        
        Button("Continue") {
            alreadyViewed = true
        }
        .buttonStyle(BorderedProminentButtonStyle())
        .font(.headline)
        .tint(.purple)
        
    }
}

#Preview {
    WelcomePageView()
}
