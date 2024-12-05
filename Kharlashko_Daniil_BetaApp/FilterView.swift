//
//  FilterView.swift
//  Kharlashko_Daniil_BetaApp
//
//  Created by Daniil Kharlashko on 24/10/2024.
//



//import SwiftUI
//
//struct FilterView: View {
//    @Environment(\.presentationMode) var presentationMode  // For dismissing the view
//    
//    // Sort options
//    @State private var selectedSortOption: String = "None"
//    let sortOptions = ["None", "Highest Rating", "Lowest Rating", "Date"]
//
//    // Date range for filtering
//    @State private var startDate = Date()
//    @State private var endDate = Date()
//
//    // Event categories (now scrollable)
//    @State private var selectedCategories: Set<String> = []
//    let eventCategories = ["Music", "Sports", "Art", "Theater", "Festival", "Comedy", "Food", "Tech", "Science", "Education", "Health", "Business"]
//
//    var body: some View {
//        VStack {
//            // Sort by section
//            VStack(alignment: .leading, spacing: 10) {
//                Text("Sort by")
//                    .font(.headline)
//                    .foregroundColor(.white)
//                    .padding(.leading)
//
//                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 10) {
//                    ForEach(sortOptions, id: \.self) { option in
//                        Button(action: {
//                            selectedSortOption = option
//                        }) {
//                            Text(option)
//                                .frame(maxWidth: .infinity)
//                                .padding()
//                                .background(selectedSortOption == option ? Color.blue : Color(UIColor.systemBlue).opacity(0.2))
//                                .foregroundColor(.white)
//                                .cornerRadius(10)
//                        }
//                    }
//                }
//                .padding(.horizontal)
//            }
//            .padding(.top)
//
//            // Date range section
//            VStack(alignment: .leading, spacing: 10) {
//                Text("Select Date Range")
//                    .font(.headline)
//                    .foregroundColor(.white)
//                    .padding(.top, 15)
//
//                DatePicker("Start Date", selection: $startDate, displayedComponents: .date)
//                    .datePickerStyle(CompactDatePickerStyle())
//                    .padding()
//                    .background(Color(UIColor.systemBlue).opacity(0.2))
//                    .cornerRadius(10)
//                
//                DatePicker("End Date", selection: $endDate, displayedComponents: .date)
//                    .datePickerStyle(CompactDatePickerStyle())
//                    .padding()
//                    .background(Color(UIColor.systemBlue).opacity(0.2))
//                    .cornerRadius(10)
//            }
//            .padding(.horizontal)
//
//            VStack(alignment: .leading, spacing: 10) {
//                Text("Event Categories")
//                    .font(.headline)
//                    .foregroundColor(.white)
//                    .padding(.top, 15)
//
//                ScrollView {
//                    ForEach(eventCategories, id: \.self) { category in
//                        HStack {
//                            Button(action: {
//                                if selectedCategories.contains(category) {
//                                    selectedCategories.remove(category)
//                                } else {
//                                    selectedCategories.insert(category)
//                                }
//                            }) {
//                                HStack {
//                                    Image(systemName: selectedCategories.contains(category) ? "checkmark.square.fill" : "square")
//                                        .foregroundColor(.blue)
//                                    Text(category)
//                                        .foregroundColor(.white)
//                                }
//                            }
//                        }
//                        .padding()
//                        .background(Color(UIColor.systemBlue).opacity(0.2))
//                        .cornerRadius(10)
//                    }
//                }
//                .frame(height: 200)
//            }
//            .padding(.horizontal)
//
//            Spacer()
//
//            Button(action: {
//                performSearch()
//                presentationMode.wrappedValue.dismiss()  // Go back to the SearchView after performing search
//            }) {
//                Text("Search")
//                    .font(.headline)
//                    .foregroundColor(.white)
//                    .padding()
//                    .frame(maxWidth: .infinity)
//                    .background(Color.blue.opacity(0.7))
//                    .cornerRadius(10)
//            }
//            .padding()
//            .padding(.bottom, 10)
//        }
//        .background(Color(.darkGray).edgesIgnoringSafeArea(.all))
//        .toolbar {
//            ToolbarItem(placement: .bottomBar) {
//                EmptyView()  // Hide the tab bar when this view appears
//            }
//        }
//        .onAppear {
//            UITabBar.appearance().isHidden = true  // Hide tab bar when this view is active
//        }
//    }
//
//    func performSearch() {
//        print("Selected Sort Option: \(selectedSortOption)")
//        print("Selected Start Date: \(startDate)")
//        print("Selected End Date: \(endDate)")
//        print("Selected Categories: \(selectedCategories)")
//    }
//}
//
//

// IMPLEMENT THIS
//
//  FilterView.swift
//  Kharlashko_Daniil_BetaApp
//
//  Created by Daniil Kharlashko on 24/10/2024.

import SwiftUI

struct FilterView: View {
    @Binding var filterData: FilterData
    
    @Environment(\.presentationMode) private var presentationMode

    
    private func applyFiltersAndDismiss() {
        // Perform any necessary actions to update filters
        print("Applied Filters: \(filterData)")
        
        // Dismiss the FilterView
        presentationMode.wrappedValue.dismiss()
    }
    
    var body: some View {
        VStack {
            // Sort by section
            VStack(alignment: .leading, spacing: 10) {
                Text("Sort by")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding(.leading)
                
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 10) {
                    ForEach(["None", "Highest Rating", "Lowest Rating", "Date"], id: \.self) { option in
                        Button(action: {
                            filterData.selectedSortOption = option
                        }) {
                            Text(option)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(filterData.selectedSortOption == option ? Color.blue : Color(UIColor.systemBlue).opacity(0.2))
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                    }
                }
                .padding(.horizontal)
            }
            .padding(.top)
            
            // Date range section
            VStack(alignment: .leading, spacing: 10) {
                Text("Select Date Range")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding(.top, 15)
                
                DatePicker(
                    "Start Date",
                    selection: Binding(
                        get: { filterData.startDate ?? Date() },
                        set: { filterData.startDate = $0 }
                    ),
                    displayedComponents: .date
                )
                .datePickerStyle(CompactDatePickerStyle())
                   .padding()
                   .background(Color(UIColor.systemBlue).opacity(0.2))
                   .cornerRadius(10)
                
                DatePicker(
                      "End Date",
                      selection: Binding(
                          get: { filterData.endDate ?? Date() },
                          set: { filterData.endDate = $0 }
                      ),
                      displayedComponents: .date
                  )
                  .datePickerStyle(CompactDatePickerStyle())
                  .padding()
                  .background(Color(UIColor.systemBlue).opacity(0.2))
                  .cornerRadius(10)
              }
              .padding(.horizontal)
                
                // Categories
                VStack(alignment: .leading, spacing: 10) {
                    Text("Event Categories")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding(.top, 15)
                    
                    ScrollView {
                        ForEach(["Music", "Sports", "Art", "Theater", "Festival", "Comedy", "Food", "Tech", "Science", "Education", "Health", "Business"], id: \.self) { category in
                            HStack {
                                Button(action: {
                                    if filterData.selectedCategories.contains(category) {
                                        filterData.selectedCategories.remove(category)
                                    } else {
                                        filterData.selectedCategories.insert(category)
                                    }
                                }) {
                                    HStack {
                                        Image(systemName: filterData.selectedCategories.contains(category) ? "checkmark.square.fill" : "square")
                                            .foregroundColor(.blue)
                                        Text(category)
                                            .foregroundColor(.white)
                                    }
                                }
                            }
                            .padding()
                            .background(Color(UIColor.systemBlue).opacity(0.2))
                            .cornerRadius(10)
                        }
                    }
                    .frame(height: 200)
                }
                .padding(.horizontal)
                
                Spacer()
                
                // Apply Button
                Button(action: {
                    // Filters will automatically update due to the binding
                    applyFiltersAndDismiss()
                }) {
                    Text("Apply Filters")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue.opacity(0.7))
                        .cornerRadius(10)
                }
                .padding()
                .padding(.bottom, 10)
            }
            .background(Color(.darkGray).edgesIgnoringSafeArea(.all))
        
        
        }
    }
    
    struct FilterData {
        var selectedSortOption: String
        var startDate: Date?
        var endDate: Date?
        var selectedCategories: Set<String>
        
        static var defaultData: FilterData {
            FilterData(
                selectedSortOption: "None",
                startDate: nil,
                endDate: nil,
                selectedCategories: []
            )
        }
    }

