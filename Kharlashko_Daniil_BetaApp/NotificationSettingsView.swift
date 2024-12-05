//
//  NotificationSettingsView.swift
//  BetaApp
//
//  Created by Daniil Kharlashko on 23/10/2024.
//

import SwiftUI

struct NotificationSettingsView: View {
    var body: some View {
        VStack {
            Text("Notification Settings")
                .font(.largeTitle)
                .foregroundColor(.white)
            // Add your notification settings content here
        }
//        .padding()
        .padding()
        .background(Color(.darkGray).ignoresSafeArea())
        .navigationTitle("Notification Settings")
    }
}

#Preview {
    NotificationSettingsView()
}
