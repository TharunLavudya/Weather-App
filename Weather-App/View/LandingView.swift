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
    }
}

//#Preview {
//    LandingView()
//}

