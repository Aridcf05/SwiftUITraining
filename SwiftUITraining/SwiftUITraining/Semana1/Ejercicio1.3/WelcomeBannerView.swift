//
//  WelcomeBannerView.swift
//  SwiftUITraining
//
//  Created by Ariana Ileen Del Carpio Flores on 16/06/26.
//

import SwiftUI

struct WelcomeBannerView: View {
    var body: some View {
        // ZStack para manejar las capas: Fondo -> Icono Decorativo -> Velo Semitransparente -> Texto
        ZStack {
            
            // Capa 1: Rectángulo o Gradiente simple de fondo (Paso 1)
            LinearGradient(
                colors: [.blue, .indigo],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            
            // Capa 2: SF Symbol grande con baja opacidad como fondo decorativo (Paso 2)
            Image(systemName: "sparkles")
                .font(.system(size: 140)) // Símbolo decorativo grande
                .foregroundStyle(.white)
                .opacity(0.15) // Baja opacidad para que sea sutil y no compita con el texto
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .trailing)
                .padding(.trailing, 30) // Lo empujamos ligeramente a la derecha
            
            // Capa 3: Capa semitransparente (Velo) para mejorar contraste (Paso 3)
            Color.black
                .opacity(0.2) // Un velo oscuro muy suave para que el texto blanco resalte más
            
            // Capa 4: Texto principal al frente con jerarquía visual (Paso 4)
            VStack(alignment: .leading, spacing: 6) {
                Text("¡Bienvenido de nuevo!")
                    .font(.title2)
                    .bold()
                    .foregroundStyle(.white) // Jerarquía: Color fuerte para el título principal
                
                Text("Explora tus proyectos de desarrollo y mantén el control.")
                    .font(.subheadline)
                    .foregroundStyle(.white.opacity(0.85)) // Jerarquía: Texto secundario ligeramente más suave
            }
            .frame(maxWidth: .infinity, alignment: .leading) // Alinea el bloque de texto a la izquierda
            .padding(24) // Aire interno para el texto
            
        }
        // Tamaño fijo con sentido (Criterio de evaluación: tamaño controlado para un banner de portada)
        .frame(height: 160)
        .cornerRadius(16) // Esquinas redondeadas estéticas
        .shadow(color: Color.black.opacity(0.1), radius: 8, x: 0, y: 4)
    }
}

#Preview {
    WelcomeBannerView()
}
