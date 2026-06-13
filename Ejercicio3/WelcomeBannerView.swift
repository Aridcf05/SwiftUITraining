//
//  WelcomeBannerView.swift
//  SwiftUI Ejercicios
//
//  Created by Ariana Ileen Del Carpio Flores on 11/06/26.
//

import SwiftUI

struct WelcomeBannerView: View {
    var body: some View {
        ZStack {
                    
                    // Fondo
                    LinearGradient(
                        colors: [.green, .indigo],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                    
                    // Icono decorativo gigante de fondo con opacidad muy baja (15%)
                    Image(systemName: "sparkles")
                        .font(.system(size: 140))
                        .foregroundStyle(.white)
                        .opacity(0.15) // Sutil para que no tape las letras
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .trailing)
                        .padding(.trailing, 30) // Lo empujamos a la derecha
                    
                    //semitransparente (20%) para asegurar el contraste y lectura
                    Color.black
                        .opacity(0.2)
                    
                    // Paso 4: Textos principales alineados a la izquierda
                    VStack(alignment: .leading, spacing: 6) {
                        Text("¡Bienvenida de nuevo!")
                            .font(.title2)
                            .bold()
                            .foregroundStyle(.white) // Texto principal brillante
                        
                        Text("Explora tus proyectos de desarrollo y mantén el control.")
                            .font(.subheadline)
                            .foregroundStyle(.white.opacity(0.85)) // Jerarquía: un poco más suave
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(24) // Espaciado interno seguro
                    
                }
                // Criterio de tamaño fijo con sentido para una portada o banner
                .frame(height: 160)
                .cornerRadius(16) // Bordes redondeados estéticos
                .shadow(color: Color.black.opacity(0.1), radius: 8, x: 0, y: 4)
            }
        }

#Preview {
    WelcomeBannerView()
}
