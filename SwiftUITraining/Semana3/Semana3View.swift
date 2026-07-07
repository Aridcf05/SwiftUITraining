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
                            Text("Ejercicio 3.1 (Contador)")
                                .font(.headline)
                                .bold()
                                .foregroundStyle(.white)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.blue)
                                .cornerRadius(12)
                        }
                        
                        // BOTÓN 2
                        NavigationLink(destination: ContactsListView()) {
                            Text("Ejercicio 3.2")
                                .font(.headline)
                                .bold()
                                .foregroundStyle(.white)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.blue)
                                .cornerRadius(12)
                        }
                        
                        // BOTÓN 3: Abre tu Ejercicio 2.3
                        NavigationLink(destination: ScreenView()) {
                            Text("Ejercicio 3.3")
                                .font(.headline)
                                .bold()
                                .foregroundStyle(.white)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.blue)
                                .cornerRadius(12)
                                .shadow(color: Color.blue.opacity(0.2), radius: 5, x: 0, y: 3)
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
