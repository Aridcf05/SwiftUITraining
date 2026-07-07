/*import SwiftUI

struct ScreenView: View {
    @State private var contacts = [
        Contactos(name: "Ana Martínez", role: "UX/UI Designer", initials: "AM", email: "ana.martinez@company.com", phoneNumber: "+51 987 654 321", bio: "Apasionada por crear interfaces limpias, intuitivas y centradas en la experiencia del usuario."),
        Contactos(name: "Carlos Contreras", role: "iOS Developer", initials: "CC", email: "carlos.c@company.com", phoneNumber: "+51 912 345 678", bio: "Desarrollador enfocado en exprimir al máximo SwiftUI y arquitecturas reactivas."),
        Contactos(name: "Luis Flores", role: "Cybersecurity Analyst", initials: "LF", email: "lflores@company.com", phoneNumber: nil, bio: "Especialista en auditorías de vulnerabilidades y hardening de infraestructuras cloud."),
        Contactos(name: "Sofía Rodríguez", role: "Product Owner", initials: "SR", email: "sofia.r@company.com", phoneNumber: "+51 955 443 322", bio: "Encargada de conectar la visión de negocio con el roadmap técnico del producto.")
    ]
    
    var body: some View {
        ZStack {
            Color(.systemGroupedBackground)
                .ignoresSafeArea()
            
            ScrollView(.vertical, showsIndicators: true) {
                VStack(spacing: 20) {
                    VStack(alignment: .leading, spacing: 10) {
                        ForEach(contacts) { contact in
                            NavigationLink(destination: ContactDetailView(contact: contact)) {
                                HStack(spacing: 15) {
                                    Text(contact.initials)
                                        .font(.headline)
                                        .foregroundColor(.white)
                                        .frame(width: 45, height: 45)
                                        .background(Color.blue)
                                        .clipShape(Circle())
                                    
                                    VStack(alignment: .leading, spacing: 2) {
                                        Text(contact.name)
                                            .font(.body)
                                            .bold()
                                            .foregroundColor(.primary)
                                        
                                        Text(contact.role)
                                            .font(.caption)
                                            .foregroundColor(.secondary)
                                    }
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                        .foregroundColor(.secondary)
                                }
                                .padding()
                                .background(Color(.secondarySystemGroupedBackground))
                                .cornerRadius(12)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                    .padding(.horizontal)
                }
            }
        }
        .navigationTitle("Ejercicio 2.3")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: agregarContactoDePrueba) {
                    Image(systemName: "person.badge.plus")
                }
            }
        }
    }
    
    private func agregarContactoDePrueba() {
        let numeroRandom = contacts.count + 1
        let nuevo = Contactos(
            name: "Nuevo Colaborador \(numeroRandom)",
            role: "Tech Trainee",
            initials: "NC",
            email: "nuevo.\(numeroRandom)@company.com",
            phoneNumber: "+51 900 000 \(Int.random(in: 100...999))",
            bio: "Miembro del programa de talentos en fase de inducción técnica."
        )
        contacts.append(nuevo)
    }
}*/
import SwiftUI

struct ScreenView: View {
    @State private var contacts = [
        Contactos(name: "Ana Martínez", role: "UX/UI Designer", initials: "AM", email: "ana.martinez@company.com", phoneNumber: "+51 987 654 321", bio: "Apasionada por crear interfaces limpias, intuitivas y centradas en la experiencia del usuario."),
        Contactos(name: "Carlos Contreras", role: "iOS Developer", initials: "CC", email: "carlos.c@company.com", phoneNumber: "+51 912 345 678", bio: "Desarrollador enfocado en exprimir al máximo SwiftUI y arquitecturas reactivas."),
        Contactos(name: "Luis Flores", role: "Cybersecurity Analyst", initials: "LF", email: "lflores@company.com", phoneNumber: nil, bio: "Especialista en auditorías de vulnerabilidades y hardening de infraestructuras cloud."),
        Contactos(name: "Sofía Rodríguez", role: "Product Owner", initials: "SR", email: "sofia.r@company.com", phoneNumber: "+51 955 443 322", bio: "Encargada de conectar la visión de negocio con el roadmap técnico del producto.")
    ]

    // Contacto seleccionado para mostrar en el sheet
    @State private var contactoSeleccionado: Contactos?

    var body: some View {
        NavigationStack {
            ZStack {
                Color(.systemGroupedBackground)
                    .ignoresSafeArea()

                ScrollView(.vertical, showsIndicators: true) {
                    VStack(spacing: 20) {
                        VStack(alignment: .leading, spacing: 10) {
                            ForEach(contacts) { contact in
                                Button {
                                    contactoSeleccionado = contact
                                } label: {
                                    HStack(spacing: 15) {
                                        Text(contact.initials)
                                            .font(.headline)
                                            .foregroundColor(.white)
                                            .frame(width: 45, height: 45)
                                            .background(Color.blue)
                                            .clipShape(Circle())

                                        VStack(alignment: .leading, spacing: 2) {
                                            Text(contact.name)
                                                .font(.body)
                                                .bold()
                                                .foregroundColor(.primary)

                                            Text(contact.role)
                                                .font(.caption)
                                                .foregroundColor(.secondary)
                                        }
                                        Spacer()
                                        Image(systemName: "chevron.right")
                                            .foregroundColor(.secondary)
                                    }
                                    .padding()
                                    .background(Color(.secondarySystemGroupedBackground))
                                    .cornerRadius(12)
                                }
                                .buttonStyle(.plain)
                            }
                        }
                        .padding(.horizontal)
                    }
                }
            }
            .navigationTitle("Ejercicio 2.3")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: agregarContactoDePrueba) {
                        Image(systemName: "person.badge.plus")
                    }
                }
            }
            .sheet(item: $contactoSeleccionado) { contact in
                NavigationStack {
                    ContactDetailView(contact: contact)
                        .toolbar {
                            ToolbarItem(placement: .navigationBarTrailing) {
                                Button("Cerrar") {
                                    contactoSeleccionado = nil
                                }
                            }
                        }
                }
            }
        }
    }

    private func agregarContactoDePrueba() {
        let numeroRandom = contacts.count + 1
        let nuevo = Contactos(
            name: "Nuevo Colaborador \(numeroRandom)",
            role: "Tech Trainee",
            initials: "NC",
            email: "nuevo.\(numeroRandom)@company.com",
            phoneNumber: "+51 900 000 \(Int.random(in: 100...999))",
            bio: "Miembro del programa de talentos en fase de inducción técnica."
        )
        contacts.append(nuevo)
    }
}
