import SwiftUI

struct Semana3View: View {
    var body: some View {
        ZStack {
            Color(.systemGroupedBackground)
                .ignoresSafeArea()
            
            ScrollView(.vertical, showsIndicators: true) {
                VStack(spacing: 20) {
                    Text("Ejercicios de la Semana")
                        .font(.title2)
                        .bold()
                        .foregroundStyle(.primary)
                        .padding(.top, 20)
                    
                    VStack(spacing: 16) {
                        // BOTÓN 1
                        NavigationLink(destination: ContadorView()) {
                            Text("Ejercicio 3.1")
                                .font(.headline)
                                .bold()
                                .foregroundStyle(.white)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.blue)
                                .cornerRadius(12)
                        }
                        
                        // BOTÓN 2
                        NavigationLink(destination: FormularioCortoView()) {
                            Text("Ejercicio 3.2")
                                .font(.headline)
                                .bold()
                                .foregroundStyle(.white)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.blue)
                                .cornerRadius(12)
                        }

                        // BOTÓN 3: Abre el Ejercicio 3.3 (Registro Completo con Form y Picker)
                        NavigationLink(destination: RegistroCompletoView()) {
                            Text("Ejercicio 3.3 (Registro Completo)")
                                .font(.headline)
                                .bold()
                                .foregroundStyle(.white)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.blue)
                                .cornerRadius(12)
                                .shadow(color: Color.blue.opacity(0.15), radius: 5, x: 0, y: 3)
                        }
                    }
                    .padding(.horizontal, 24)
                }
            }
        }
        .navigationTitle("Semana 3")
        .navigationBarTitleDisplayMode(.inline)
    }
}
