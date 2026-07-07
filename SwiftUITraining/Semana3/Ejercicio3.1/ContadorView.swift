import SwiftUI

struct ContadorView: View {
    // Criterio 1: El estado es privado
    @State private var count: Int = 0
    
    var body: some View {
        ZStack {
            // Fondo nativo consistente con tu app
            Color(.systemGroupedBackground)
                .ignoresSafeArea()
            
            VStack(spacing: 30) {
                
                // Cabecera del ejercicio
                VStack(spacing: 6) {
                    Text("EJERCICIO 3.1")
                        .font(.caption)
                        .bold()
                        .foregroundStyle(.blue)
                    
                    Text("Contador Interactivo")
                        .font(.title3)
                        .bold()
                        .foregroundStyle(.primary)
                }
                .padding(.top, 20)
                
                // Contenedor principal de la tarjeta del contador
                VStack(spacing: 24) {
                    
                    // Display del número del contador
                    Text("\(count)")
                        .font(.system(size: 72, weight: .bold, design: .rounded))
                        .foregroundColor(count >= 10 ? .green : .primary)
                        .animation(.default, value: count) // Criterio: La UI responde suavemente
                    
                    // Criterio 4: Mostrar un mensaje distinto si llega a 10 usando lógica condicional simple
                    if count >= 10 {
                        Text("🎉 ¡Meta alcanzada! Has llegado a 10")
                            .font(.subheadline)
                            .bold()
                            .foregroundColor(.green)
                            .transition(.scale.combined(with: .opacity))
                    } else {
                        Text("Sigue sumando para alcanzar la meta")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    
                    // Criterio 2: Agregar botones para sumar y restar
                    HStack(spacing: 20) {
                        
                        // Botón de Restar
                        Button(action: {
                            if count > 0 { count -= 1 }
                        }) {
                            HStack {
                                Image(systemName: "minus.circle.fill")
                                Text("Restar")
                            }
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(count == 0 ? Color.gray.opacity(0.4) : Color.red)
                            .cornerRadius(12)
                        }
                        // Criterio 3: Deshabilitar restar cuando count == 0
                        .disabled(count == 0)
                        
                        // Botón de Sumar
                        Button(action: {
                            count += 1
                        }) {
                            HStack {
                                Image(systemName: "plus.circle.fill")
                                Text("Sumar")
                            }
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .cornerRadius(12)
                        }
                    }
                }
                .padding(24)
                .background(Color(.secondarySystemGroupedBackground))
                .cornerRadius(16)
                .shadow(color: Color.black.opacity(0.04), radius: 10, x: 0, y: 4)
                .padding(.horizontal, 24)
                
                // Botón secundario para reiniciar el estado
                if count > 0 {
                    Button(action: { count = 0 }) {
                        Text("Reiniciar contador")
                            .font(.footnote)
                            .foregroundColor(.secondary)
                            .underline()
                    }
                    .transition(.opacity)
                }
                
                Spacer()
            }
        }
        .navigationTitle("Interacción")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        ContadorView()
    }
}
