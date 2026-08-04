import Combine
import SwiftUI

struct CharacterListView: View {
    @StateObject private var viewModel = CharacterListViewModel()

    var body: some View {
        NavigationStack {
            Group {
                if let errorMessage = viewModel.errorMessage {
                    ContentUnavailableView(
                        "Error de Carga",
                        systemImage: "exclamationmark.triangle",
                        description: Text(errorMessage)
                    )
                } else {
                    List(viewModel.characters) { character in
                        VStack(alignment: .leading, spacing: 6) {
                            HStack {
                                Text(character.fullName)
                                    .font(.headline)
                                Spacer()
                                if character.isJedi {
                                    Text("JEDI")
                                        .font(.caption2)
                                        .fontWeight(.bold)
                                        .padding(.horizontal, 8)
                                        .padding(.vertical, 4)
                                        .background(Color.blue.opacity(0.2))
                                        .foregroundColor(.blue)
                                        .clipShape(Capsule())
                                }
                            }
                            
                            HStack {
                                Text("\(character.race) • \(character.planet)")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                                Spacer()
                                Text("\(character.age) años")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }
                        }
                        .padding(.vertical, 4)
                    }
                }
            }
            .navigationTitle("Personajes")
        }
    }
}

#Preview {
    CharacterListView()
}
