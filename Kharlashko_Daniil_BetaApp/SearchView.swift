//  SearchView.swift
//  Kharlashko_Daniil_BetaApp
//
//  Created by Daniil Kharlashko on 24/10/2024.
//

//  SearchView.swift
//  Kharlashko_Daniil_BetaApp
//
//  Created by Daniil Kharlashko on 24/10/2024.
//
//  SearchView.swift
//  Kharlashko_Daniil_BetaApp
//
//  Created by Daniil Kharlashko on 24/10/2024.
//

import SwiftUI
import MapKit

struct SearchView: View {
    @EnvironmentObject var appState: AppState
    @State private var searchQuery: String = "" // For search functionality

    var filteredEvents: [Event] {
        if searchQuery.isEmpty {
            return appState.events
        } else {
            return appState.events.filter { event in
                event.title.lowercased().contains(searchQuery.lowercased()) ||
                event.description.lowercased().contains(searchQuery.lowercased()) ||
                event.location.lowercased().contains(searchQuery.lowercased())
            }
        }
    }

    var body: some View {
        NavigationView {
            VStack {
                // Header
                Text("Featured Events")
//                    .font(.largeTitle)
//                    .bold()
//                    .foregroundColor(.white)
//                    .padding()
//                    .background(Color("AccentRed")) // AccentRed background
//                    .cornerRadius(15) // Rounded edges
//                    .padding(.horizontal) // Ensure alignment within the view
                
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(
                        LinearGradient(
                            gradient: Gradient(colors: [Color.red, Color.red.opacity(0.9), Color.red]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .cornerRadius(15)
                    .padding(.horizontal)
                

                // Search bar
                TextField("Type Search", text: $searchQuery)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.blue.opacity(0.7), lineWidth: 2)
                    )
                    .padding(.horizontal)

                // Filter and Clear Filter buttons
                HStack(spacing: 10) {
                    // Filter Button
                    NavigationLink(destination: FilterView()) {
                        Text("Filter")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity) // Ensures equal width
//                            .background(Color.blue)
                            .background(Color("PrimaryBlue"))
                            .cornerRadius(10)
                    }
                    
                    // Clear Filter Button
                    Button(action: {
                        searchQuery = "" // Clear the search query
                    }) {
                        Text("Clear Filter")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity) // Ensures equal width
//                            .background(Color.blue)
                            .background(Color("PrimaryBlue"))
                            .cornerRadius(10)
                    }
                }
                .padding(.horizontal)
                .padding(.top, 10)

                // Display filtered events or empty state
                if filteredEvents.isEmpty {
                    Spacer()
                    Text("No events found.")
                        .font(.headline)
//                        .foregroundColor(.white)
                        .foregroundColor(Color("TextGray"))
                        .padding()
                    Spacer()
                } else {
                    ScrollView {
                        ForEach(filteredEvents) { event in
                            NavigationLink(destination: DetailView(event: event)) {
                                EventRow(event: event)
                            }
                            .padding(.vertical, 10)
                            .padding(.horizontal)
                        }
                    }
                }
            }
//            .background(Color(.darkGray).ignoresSafeArea())
            .background(Color("BackgroundWhite").ignoresSafeArea())
        }
    }
}

struct EventRow: View {
    let event: Event
    @EnvironmentObject var appState: AppState // Access global app state

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            // Ratings and favorite button
            HStack {
                HStack(spacing: 3) {
                    ForEach(0..<5) { star in
                        Image(systemName: star < event.rating ? "star.fill" : "star")
                            .resizable()
                            .frame(width: 15, height: 15)
//                            .foregroundColor(.yellow)
                            .foregroundColor(Color("SecondaryYellow"))
                    }
                }
                Spacer()
                Button(action: {
                    appState.toggleFavorite(event: event) // Toggle favorite status
                }) {
                    Image(systemName: appState.isFavorited(event: event) ? "heart.fill" : "heart")
                        .resizable()
                        .frame(width: 20, height: 20)
//                        .foregroundColor(appState.isFavorited(event: event) ? .red : .white)
                        .foregroundColor(appState.isFavorited(event: event) ? Color("AccentRed") : Color("SecondaryGray"))
                }
            }

            // Main content with image, description, and details
            HStack(alignment: .top, spacing: 15) {
                // Event image
                Image(event.imageName)
                    .resizable()
                    .frame(width: 120, height: 100)
                    .cornerRadius(10)

                VStack(alignment: .leading, spacing: 5) {
                    // Event title
                    Text(event.title)
                        .font(.headline)
//                        .foregroundColor(.white)
                        .foregroundColor(Color("TextGray"))
                        .lineLimit(1) // Restrict to one line with ellipses
                        .truncationMode(.tail)

                    // Location
                    HStack(alignment: .center, spacing: 5) {
                        Image(systemName: "mappin.and.ellipse")
//                            .foregroundColor(.white)
                            .foregroundColor(Color("TextGray"))
                        Text(event.location)
                            .font(.subheadline)
//                            .foregroundColor(.white) // Changed to white for readability
                            .foregroundColor(Color("TextGray"))
                            .lineLimit(1) // Restrict to one line with ellipses
                            .truncationMode(.tail)
                    }

                    // Time
                    HStack(alignment: .center, spacing: 5) {
                        Image(systemName: "clock")
//                            .foregroundColor(.white)
                            .foregroundColor(Color("TextGray"))
                        Text(event.time)
                            .font(.subheadline)
//                            .foregroundColor(.white) // Changed to white for readability
                            .foregroundColor(Color("TextGray"))
                            .lineLimit(1) // Restrict to one line with ellipses
                            .truncationMode(.tail)
                    }

                    // Date
                    HStack(alignment: .center, spacing: 5) {
                        Image(systemName: "calendar")
                            .foregroundColor(.white)
                        Text(event.date)
                            .font(.subheadline)
//                            .foregroundColor(.white) // Changed to white for readability
                            .foregroundColor(Color("TextGray"))
                            .lineLimit(1) // Restrict to one line with ellipses
                            .truncationMode(.tail)
                    }
                }
            }

            // Description directly under the image
            Text(event.description)
                .font(.subheadline)
//                .foregroundColor(.white)
                .foregroundColor(Color("TextGray"))
                .lineLimit(3) // Restrict to 3 lines
                .truncationMode(.tail)
                .multilineTextAlignment(.leading)
        }
//        .padding()
//        .background(Color("CardBackgroundGray")) // Slightly darker gray for contrast
////        .background(Color("SecondaryGray"))
//        .cornerRadius(15)
        
//        .padding()
//        .background(Color(.darkGray)) // Matches the overall background
//        .background(Color("BackgroundWhite")) // Matches the overall background
//        .cornerRadius(15)
        
        .padding()
        .background(
            Color.white // White background
        )
        .cornerRadius(15)
        .shadow(color: Color.black.opacity(0.2), radius: 4, x: 0, y: 2) // Drop shadow
    }
}

struct DetailView: View {
    let event: Event

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) { // Changed alignment to .leading
                // Title
                Text(event.title)
                    .font(.largeTitle)
                    .bold()
//                    .foregroundColor(.white)
                    .foregroundColor(Color("TextGray"))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                    .padding(.bottom, 10)

                // Image
                Image(event.imageName)
                    .resizable()
                    .frame(height: 250)
                    .cornerRadius(15)
                    .padding(.horizontal) // Added padding for consistent alignment

                
                // Location, Time, and Date aligned to the left
                VStack(alignment: .leading, spacing: 8) { // Aligned to .leading
                    HStack(alignment: .top, spacing: 10) {
                        Image(systemName: "mappin.and.ellipse")
//                            .foregroundColor(.white)
                            .foregroundColor(Color("TextGray"))
                        Text(event.location)
//                            .foregroundColor(.white)
                            .foregroundColor(Color("TextGray"))
                            .multilineTextAlignment(.leading)
                    }

                    HStack(spacing: 10) {
                        Image(systemName: "clock")
//                            .foregroundColor(.white)
                            .foregroundColor(Color("TextGray"))
                        Text(event.time)
//                            .foregroundColor(.white)
                            .foregroundColor(Color("TextGray"))
                    }

                    HStack(spacing: 10) {
                        Image(systemName: "calendar")
                            .foregroundColor(Color("TextGray")) // Match your text color theme
                        Text(event.date)
//                            .foregroundColor(.white)
                            .foregroundColor(Color("TextGray"))
                    }
                    
                }
                .padding(.horizontal) // Align to the left with the description

                // Description
                Text(event.description)
                    .font(.body)
//                    .foregroundColor(.white)
                    .foregroundColor(Color("TextGray"))
                    .multilineTextAlignment(.leading)
                    .padding(.horizontal)
            }
            .padding(.vertical)
        }
//        .background(Color(.darkGray).ignoresSafeArea())
        .background(Color("BackgroundWhite").ignoresSafeArea())
    }
}

#Preview {
    DetailView(event: Event(
        id: 1,
        title: "Pixar Putt Returns to Discovery Green",
        location: "1500 McKinney Street, Houston, TX 77010",
        time: "Varying times",
        date: "October 13, 2024 – January 20, 2025",
        description: "18 fun and interactive holes inspired by Disney and Pixar's films, including Toy Story, Cars, Monsters, Inc., Soul, and more!",
        imageName: "HoustonGolf",
        isFavorited: false,
        rating: 4,
        coordinate: CLLocationCoordinate2D(latitude: 29.7544, longitude: -95.3700)
    ))
}
