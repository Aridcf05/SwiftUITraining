import SwiftUI



struct ProfileHeaderView: View {

    let name: String

    let role: String

    let avatarSymbol: String

    

    var body: some View {

        HStack(spacing: 16) {

            Image(systemName: avatarSymbol)

                .resizable()

                .scaledToFit()

                .frame(width: 70, height: 70)

                .foregroundStyle(.tint)

            

            VStack(alignment: .leading, spacing: 4) {

                Text(name)

                    .font(.headline)

                    .foregroundStyle(.primary)

                Text(role)

                    .font(.subheadline)

                    .foregroundStyle(.secondary)

            }

            Spacer() // Empuja el contenido hacia la izquierda de la tarjeta

        }

    }

}
