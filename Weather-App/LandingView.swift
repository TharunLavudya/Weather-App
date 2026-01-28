//
//  ContentView.swift
//  Weather-App
//
//  Created by rentamac on 1/22/26.
//
import SwiftUI

struct LandingView: View {

    var body: some View {
        NavigationStack {
            ZStack {
                Color("bgColor").ignoresSafeArea()

                VStack {
                    Spacer()

                    Image("icon")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        .padding(40)

                    Text("Breeze")
                        .font(.largeTitle.bold())
                        .foregroundStyle(.white)

                    Text("Weather App")
                        .font(.title3)
                        .foregroundStyle(.gray)

                    Spacer()

                    NavigationLink(destination: ListView()) {
                        Image(systemName: "arrow.right.circle.fill")
                            .font(.system(size: 56))
                            .symbolRenderingMode(.palette)
                            .foregroundStyle(.white, .blue)
                            .padding(.bottom, 80)
                    }
                }
            }
        }
        .onAppear {
            seedDummyData()
        }
    }
}

private func seedDummyData() {

    let db = PersistenceController.shared

    // Check if data already exists
    let existingLocations = db.fetchAll()
    guard existingLocations.isEmpty else {
        return
    }

    // Dummy locations
    let dummyLocations = [
        ("Mumbai", 19.0760, 72.8777),
        ("Delhi", 28.6139, 77.2090),
        ("Pune", 18.5204, 73.8567),
        ("Bangalore", 12.9716, 77.5946),
        ("Chennai", 13.0827, 80.2707),
        ("Kolkata", 22.5726, 88.3639)
    ]

    // create weather Locations
    dummyLocations.forEach { name, lat, lon in
        db.createWeather(
            id: UUID(),
            name: name,
            latitude: lat,
            longitude: lon
        )
    }
}

//#Preview {
//    LandingView()
//}

