//
//  HistoryView.swift
//  BetaApp
//
//  Created by Daniil Kharlashko on 23/10/2024.
//

import SwiftUI

struct HistoryView: View {
    var body: some View {
        VStack {
            Text("History of Reviews and Q&A")
                .font(.largeTitle)
                .foregroundColor(.white)
            // Add your reviews/Q&A history content here
            // Test note for GitHub
        }
        .padding()
        .background(Color(.darkGray).ignoresSafeArea())
        .navigationTitle("History")
    }
}

#Preview {
    HistoryView()
}
