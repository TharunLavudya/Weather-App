//
//  ListView.swift
//  Weather-App
//
//  Created by rentamac on 1/22/26.
//

import SwiftUI

struct ListView: View {
    
    @StateObject private var viewModel = ViewModel()
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.filterLocations) { location in
                    NavigationLink{
                        LocationView(location: location)
                    } label: {
                        
                        HStack {
                            Image(systemName: location.weather.icon)
                                .font(.title2)
                                .foregroundColor(.yellow)
                            
                            Text(location.name)
                                .font(.headline)
                                .foregroundColor(.white)
                            
                            Spacer()
                            
                            Text("\(location.temperature.max)°")
                                .font(.title3)
                                .foregroundColor(.white)
                        }
                        .padding(.vertical, 6)
                    }
                        .listRowBackground(Color.clear)
                }
            }
            .scrollContentBackground(.hidden)
            .background(Color("bgColor"))
            .navigationTitle("Locations")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.white)
                    }
                }
            }
            .searchable(text: $viewModel.searchText, placement: .navigationBarDrawer(displayMode: .always), prompt: "Search")
            
        }
    }
}
#Preview {
    ListView()
}
