//
//  MapView.swift
//  Kharlashko_Daniil_BetaApp
//
//  Created by Daniil Kharlashko on 24/10/2024.
//



import SwiftUI
import MapKit

struct MapView: View {
    @EnvironmentObject var appState: AppState
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 29.7604, longitude: -95.3698), // Houston region
        span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)
    )
    
    @State private var selectedEvent: Event?  // Track the selected event
    @State private var showDetail = false     // Control navigation to DetailView
    
    var events: [Event]
    
    var body: some View {
        ZStack {
            
//            // Dark Background
//            Color(.darkGray)
//                .edgesIgnoringSafeArea(.all)
            
            // Background color
            Color("BackgroundGray")
                .edgesIgnoringSafeArea(.all)
            
            // Map with event annotations
            Map(coordinateRegion: $region, annotationItems: events) { event in
                MapAnnotation(coordinate: event.coordinate) {
                    Button(action: {
                        // Set the selected event when an annotation is tapped
                        selectedEvent = event
                    }) {
                        VStack {
                            Image(event.imageName)
//                                .resizable()
//                                .frame(width: 50, height: 50)
//                                .cornerRadius(10)
                            
                                .resizable()
                                .frame(width: 50, height: 50)
                                .cornerRadius(10)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color("AccentRed"), lineWidth: 1.5) // AccentRed stroke with reduced width
                                )
                            
                            // Event title on map pin
                            Text(event.title)
                                .font(.caption)
                                .padding(5)
                                .background(Color("SecondaryYellow")) // SecondaryYellow background
                                .foregroundColor(.black)
                                .cornerRadius(8)
                            
                        }
                    }
                }
            }
            .accentColor(.blue)
            .ignoresSafeArea(edges: .top)
            
            // Event Details Card when an event is selected
            if let event = selectedEvent {
                VStack {
                    Spacer()  // Push the card to the bottom of the screen
                    VStack(alignment: .leading, spacing: 10) {
                        // Event image and details
                        HStack(alignment: .top) {
                            Image(event.imageName)
                                .resizable()
                                .frame(width: 60, height: 60)  // Smaller image
                                .cornerRadius(10)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color("AccentRed"), lineWidth: 2) // AccentRed stroke
                                )
                            
                            VStack(alignment: .leading, spacing: 5) {
                                Text(event.title)
                                    .font(.headline)
//                                    .foregroundColor(.white)
                                    .foregroundColor(Color("TextGray"))
                                
                                Text("\(event.location)")
                                    .font(.subheadline)
                                    .foregroundColor(Color("TextGray"))
                                
                                Text("\(event.time)")
                                    .font(.subheadline)
                                    .foregroundColor(Color("TextGray"))
                                
                                Text("\(event.date)")
                                    .font(.subheadline)
                                    .foregroundColor(Color("TextGray"))
                            }
                        }
                        .padding(.horizontal)
                        
                        Text(event.description)
                            .foregroundColor(Color("TextGray"))
                            .padding(.horizontal)
                            .padding(.top, 5)
                        
                        Spacer()
                        
                        Button(action: {
                            selectedEvent = nil  // Dismiss the card when the close button is clicked
                        }) {
                            Text("Close")
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color("PrimaryBlue"))
                                .cornerRadius(10)
                        }
                        .padding(.horizontal)
                        .padding(.bottom, 10)
                    }
                    .padding()
                    .background(
                        Color.white // White background for the card
                    )
                    .cornerRadius(15)
                    .shadow(color: Color.black.opacity(0.2), radius: 4, x: 0, y: 2) // Drop shadow
                    
//                    .shadow(radius: 10)
                    .padding(.horizontal, 10)  // Wider padding so the card almost touches the screen edges
                    .frame(maxWidth: .infinity, minHeight: 130, maxHeight: 170)  // Reduce height for better fit
                    .onTapGesture {
                        // When the card is tapped, navigate to DetailView
                        showDetail = true
                    }
                    .offset(y: -45)  // Raised more (10 pixels higher) to avoid overlapping the tab bar
                    .sheet(isPresented: $showDetail) {
                        // Navigate to DetailView while keeping the tab bar visible
                        NavigationView {
                            DetailView(event: event)
                                .navigationBarTitle("Event Details", displayMode: .inline)
                                .navigationBarBackButtonHidden(false)  // Show back button
                                .navigationBarItems(leading: Button(action: {
                                    showDetail = false  // Dismiss detail view
                                }) {
                                    Image(systemName: "chevron.left")
                                        .foregroundColor(.blue)
                                        .padding(.leading)
                                    Text("Back")
                                        .foregroundColor(.blue)
                                })
                        }
                    }
                }
                .transition(.move(edge: .bottom))
                .animation(.spring())
            }
        }
        .background(Color("BackgroundGray")) // Background layer specifically for the map, not overlapping tab bar

    }
}

