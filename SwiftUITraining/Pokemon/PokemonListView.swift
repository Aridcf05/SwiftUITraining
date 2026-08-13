import SwiftUI

struct PokemonListView: View {
    @StateObject private var viewModel = PokemonListViewModel()
    
    var body: some View {
        Group {
            if viewModel.isLoading {
                ProgressView("Cargando lista...")
            } else if let error = viewModel.errorMessage {
                VStack(spacing: 10) {
                    Text(error).foregroundColor(.red)
                    Button("Reintentar") {
                        Task { await viewModel.loadPokemons() }
                    }
                }
            } else {
                List(viewModel.pokemons) { pokemon in
                    // 👇 Cambiado a navegación directa por destino
                    NavigationLink(destination: PokemonDetailView(pokemonName: pokemon.name)) {
                        Text(pokemon.name.capitalized)
                            .font(.body)
                            .fontWeight(.medium)
                    }
                }
            }
        }
        .navigationTitle("Pokédex")
        .task {
            if viewModel.pokemons.isEmpty {
                await viewModel.loadPokemons()
            }
        }
    }
}

#Preview {
    NavigationStack {
        PokemonListView()
    }
}
