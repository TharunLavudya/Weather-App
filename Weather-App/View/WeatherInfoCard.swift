//
//  WeatherInfoRow.swift
//  Weather-App
//
//  Created by rentamac on 1/26/26.
//
import SwiftUI

struct WeatherInfoCard: View {

    let title: String
    let value: String

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title.uppercased())
                .font(.caption)
                .foregroundColor(.white.opacity(0.6))

            Text(value)
                .font(.title3)
                .fontWeight(.semibold)
                .foregroundColor(.white)
        }
        .padding()
        .frame(maxWidth: .infinity, minHeight: 80)
        .background(
            RoundedRectangle(cornerRadius: 14)
                .fill(.white.opacity(0.08))
        )
    }
}

