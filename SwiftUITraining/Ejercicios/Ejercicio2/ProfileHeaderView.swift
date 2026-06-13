//
//  ProfileHeaderView.swift
//  SwiftUI Ejercicios
//
//  Created by Ariana Ileen Del Carpio Flores on 8/06/26.
//

import SwiftUI

struct ProfileHeaderView: View {
    var body: some View {
        // SF Symbol grande como Avatar (Ejercicio 1.1 y 1.2)
                    Image(systemName: "person.crop.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        .foregroundStyle(.blue)
                    
                    // Nombre y Rol
                    Text("Ariana del Carpio Flores")
                        .font(.title)
                        .bold()
                        .foregroundStyle(.primary)
                    
                    Text("Trainee")
                        .font(.headline)
                        .foregroundStyle(.secondary)
                    
                    // Frase corta (Ejercicio 1.1)
                    Text("Construyendo el futuro del software un pixel a la vez.")
                        .font(.subheadline)
                        .italic()
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
    }
}

#Preview {
    ProfileHeaderView()
}
