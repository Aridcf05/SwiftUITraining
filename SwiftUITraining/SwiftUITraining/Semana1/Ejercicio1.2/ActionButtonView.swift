//
//  ActionButtonView.swift
//  SwiftUITraining
//
//  Created by Ariana Ileen Del Carpio Flores on 16/06/26.
//

import SwiftUI

struct ActionButtonView: View {
    let iconName: String
    let label: String
    var action: () -> Void = {}
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 8) {
                Image(systemName: iconName)
                    .font(.title3)
                Text(label)
                    .font(.caption)
                    .fontWeight(.medium)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 12)
            .background(Color(.secondarySystemBackground))
            .cornerRadius(12)
        }
    }
}
