//
//  EventPreferencesView.swift
//  BetaApp
//
//  Created by Daniil Kharlashko on 23/10/2024.
//

import SwiftUI

struct EventPreferencesView: View {
    var body: some View {
        VStack {
            Text("Event Preferences")
                .font(.largeTitle)
                .foregroundColor(.white)
            // Add your event preferences content here
        }
        .padding()
        .background(Color(.darkGray).ignoresSafeArea())
        .navigationTitle("Event Preferences")
    }
}

#Preview {
    EventPreferencesView()
}
