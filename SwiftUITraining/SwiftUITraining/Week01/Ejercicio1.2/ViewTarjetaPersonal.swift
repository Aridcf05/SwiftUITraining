import SwiftUI



struct ProfileCardView: View {

    var body: some View {

        VStack(spacing: 20) {

            // 1. Encabezado del perfil

            ProfileHeaderView(

                name: "Ariana Del Carpio",

                role: "IT Specialist",

                avatarSymbol: "person.crop.circle.badge.checkmark"

            )

            

            Divider()

            

            // 2. Fila de acciones (HStack distribuyendo los botones uniformemente)

            HStack(spacing: 12) {

                ActionButtonView(iconName: "phone.fill", label: "Teléfono")

                ActionButtonView(iconName: "message.fill", label: "Mensaje")

                ActionButtonView(iconName: "envelope.fill", label: "Correo")

            }

        }

        .padding()

        .background(

            RoundedRectangle(cornerRadius: 16)

                .fill(Color(.systemBackground))

                .shadow(color: Color.black.opacity(0.05), radius: 8, x: 0, y: 2)

        )

        .padding()

        .frame(maxWidth: .infinity, maxHeight: .infinity)

        .background(Color(.systemGroupedBackground))

    }

}



#Preview {

    ProfileCardView()

}

