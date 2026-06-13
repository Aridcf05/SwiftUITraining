//
//  ContentView.swift
//  SwiftUI Ejercicios
//
//  Created by Ariana Ileen Del Carpio Flores on 8/06/26.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            // Fondo suave para resaltar la tarjeta (Criterio Ejercicio 1.1)
            Color(.systemGroupedBackground)
                .ignoresSafeArea()
            
            // Tarjeta de Perfil Principal
            VStack(spacing: 24) {
                
                // 1. Cabecera del perfil
                ProfileHeaderView()
                
                Divider() // Separador visual limpio
                
                // 2. Fila de acciones usando HStack y Spacer (Ejercicio 1.2)
                HStack(spacing: 12) {
                    ActionButtonView(iconName: "phone.fill", label: "Llamar")
                        .tint(Color.green)
                    
                    ActionButtonView(iconName: "message.fill", label: "Mensaje")
                        .tint(Color.blue)
                    
                    ActionButtonView(iconName: "envelope.fill", label: "Correo")
                        .tint(Color.orange)
                }
                .padding(.horizontal, 8)
                
            }
            .padding(24)
            .background(Color(.secondarySystemGroupedBackground)) // Fondo de la tarjeta limpia
            .cornerRadius(20)
            .shadow(color: Color.black.opacity(0.05), radius: 10, x: 0, y: 5)
            .padding()
        }
    }
}

#Preview {
    ContentView()
}
