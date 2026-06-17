//
//  CardView.swift
//  SwiftUITraining
//
//  Created by Ariana Ileen Del Carpio Flores on 16/06/26.
//

import SwiftUI

struct PersonalCardView: View {
    var body: some View {
        VStack(spacing: 16) {
            // SF Symbol grande e intencional
            Image(systemName: "person.crop.circle.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .foregroundStyle(.tint)
            
            // Datos principales
            VStack(spacing: 8) {
                Text("Ariana Del Carpio")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundStyle(.primary)
                
                Text("IT Specialist & Developer")
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .foregroundStyle(.secondary)
                
                Text("Construyendo soluciones eficientes paso a paso.")
                    .font(.body)
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.secondary)
                    .padding(.horizontal)
            }
        }
        .padding(24)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color(.systemBackground))
                .shadow(color: Color.black.opacity(0.08), radius: 10, x: 0, y: 4)
        )
        .padding()
        // Fondo suave para resaltar la tarjeta centrada
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.systemGroupedBackground))
    }
}

#Preview {
    PersonalCardView()
}
