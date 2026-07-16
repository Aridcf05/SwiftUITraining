import SwiftUI

struct Semana4View: View {
    var body: some View {
        ZStack {
            Color(.systemGroupedBackground)
                .ignoresSafeArea()
            
            ScrollView(.vertical, showsIndicators: true) {
                VStack(spacing: 20) {
                    Text("MVVM y Estado Compartido")
                        .font(.title2)
                        .bold()
                        .foregroundStyle(.primary)
                        .padding(.top, 20)
                    
                    Text("Explora la separación de responsabilidades usando ViewModels, bindings observables y flujos modales nativos.")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 32)
                    
                    VStack(spacing: 16) {
                        // Acceso directo a tu lista de tareas (Ejercicios 4.1 y 4.2 integrados)
                        NavigationLink(destination: TaskListView()) {
                            HStack {
                                VStack(alignment: .leading, spacing: 4) {
                                    Text("Ejercicios 4.1 y 4.2")
                                        .font(.headline)
                                        .bold()
                                        .foregroundStyle(.white)
                                    Text("Lista de tareas con arquitectura MVVM y adición desde modal Sheet")
                                        .font(.caption)
                                        .foregroundStyle(.white.opacity(0.8))
                                        .multilineTextAlignment(.leading)
                                }
                                Spacer()
                                Image(systemName: "checklist")
                                    .font(.title2)
                                    .foregroundStyle(.white)
                             }
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(12)
                            .shadow(color: Color.blue.opacity(0.15), radius: 5, x: 0, y: 3)
                        }
                    }
                    .padding(.horizontal, 24)
                    .padding(.top, 10)
                }
            }
        }
        .navigationTitle("Semana 4")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        Semana4View()
    }
}
