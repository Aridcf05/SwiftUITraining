//
//  ContentView.swift
//  SwiftUITraining
//
//  Created by Ariana Ileen Del Carpio Flores on 16/06/26.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            ZStack {
                // Fondo gris suave nativo de iOS
                Color(.systemGroupedBackground)
                    .ignoresSafeArea()
                
                // Usamos un ScrollView vertical principal para que toda la pantalla sea deslizable
                ScrollView(.vertical, showsIndicators: true) {
                    VStack(spacing: 20) {
                        // Título del Menú Principal
                        Text("Mis Ejercicios SwiftUI")
                            .font(.title2)
                            .bold()
                            .foregroundStyle(.primary)
                            .padding(.top, 20) // Un poco de espacio superior inicial
                        
                        Text("Selecciona una sección para revisar el entregable correspondiente de la semana.")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 32)
                        
                        // CAMBIO CLAVE: Cambiado a VStack para alineación vertical
                        VStack(spacing: 16) {
                            
                            // BOTÓN 1: Abre el Ejercicio 1.2 (Perfil con Acciones)
                            NavigationLink(destination: Semana1View()) {
                                Text("Semana 1")
                                    .font(.headline)
                                    // Cambiado a .primary o .blue para que contraste mejor sobre fondo blanco
                                    .foregroundStyle(.primary)
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(Color(.secondarySystemGroupedBackground)) // Fondo blanco
                                    .cornerRadius(12)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 12)
                                            .stroke(Color.gray.opacity(0.2), lineWidth: 1)
                                    )
                            }
                            
                            // BOTÓN 2: Abre el Ejercicio 1.3 (Banner con Capas)
                            NavigationLink(destination: Semana2View()) {
                                Text("Semana 2")
                                    .font(.headline)
                                    .bold()
                                    .foregroundStyle(.white)
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(Color.blue) // Color azul llamativo
                                    .cornerRadius(12)
                                    .shadow(color: Color.blue.opacity(0.2), radius: 5, x: 0, y: 3)
                            }
                            // BOTÓN 2: Abre el Ejercicio 1.3 (Banner con Capas)
                            NavigationLink(destination: Semana3View()) {
                                Text("Semana 3")
                                    .font(.headline)
                                    .bold()
                                    .foregroundStyle(.white)
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(Color.blue) // Color azul llamativo
                                    .cornerRadius(12)
                                    .shadow(color: Color.blue.opacity(0.2), radius: 5, x: 0, y: 3)
                            }
                            
                        }
                        .padding(.horizontal, 24)
                        .padding(.top, 10)
                    }
                }
            }
            // Título opcional en la barra superior de navegación
            .navigationTitle("Ruta de Aprendizaje")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    ContentView()
}
